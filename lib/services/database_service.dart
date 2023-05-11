import "package:cloud_firestore/cloud_firestore.dart";
import "package:pocket_pal/services/authentication_service.dart";


class PocketPalFirestore {

  final _db = FirebaseFirestore.instance;
  final String _userUid = PocketPalAuthentication().getUserUID;
  final String _email = PocketPalAuthentication().getUserEmail;

  // Folders ======================================================
  Future<QuerySnapshot> getFolderSnapshot({String ? orderBy, String ? code}) async {
    final collection = _db.collection(code ??_userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).orderBy(
      orderBy ?? "folderDate", descending: true
    );
    return await collection.get();
  } 

   Future<void> addFolder(Map<String, dynamic> data, {String ? code}) async {
    final document = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc();
    data["folderId"] = document.id;
    await document.set(data);
    return;
  }

  Future<void> deleteFolder(String docName, { String ? code }) async {
    final document = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName);
  
    final List<String> docNames = [
      "$docName+Envelope",
      "$docName+ChatBox"
    ];

    for (int i = 0; i < docNames.length; i++) {
      final subCollection = document.collection(docNames[i]);

      final subCollectionSnapshot = await subCollection.get();
      for (final docs in subCollectionSnapshot.docs) {
        await docs.reference.delete();
      }
      await subCollection.doc(subCollection.id).delete();
    }
    await document.delete();
    return;
  }

  Future<void> updateFolder(String docName, Map<String, dynamic> data, {String ? code}) async {
    final document = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName);
    await document.update(data);
    return;
  }

  //Events =================
  Future<void> addEvent (
      Map<String, dynamic> data, 
      {String ? orderBy}
    ) async{

      final document = _db
        .collection(_userUid)
        .doc("$_userUid+Event")
        .collection(_userUid)
        .doc();

      data["eventId"] = document.id;
      await document.set(data);
      getEventSnapshot();
      return;
    }

  Future<QuerySnapshot> getEventSnapshot({String ? orderBy,}) async {
    final collection = _db
        .collection(_userUid)
        .doc("$_userUid+Event")
        .collection(_userUid).orderBy(
      orderBy ?? "eventDate", descending: false
    );
    return await collection.get();
  } 
 
  Future<void> deleteEvent(String docName) async{
    final document = _db
    .collection(_userUid)
    .doc("$_userUid+Event")
    .collection(_userUid)
    .doc(docName);

    await document.delete();

  }

  // Envelope ======================================================
  Future<void> addEnvelope(Map<String, dynamic> data, String docName, {String ? code}) async {
    final folderDocs = _db
    .collection(code ?? _userUid)
    .doc("${code ?? _userUid}+Wall")
    .collection(code ?? _userUid);

    final collection = _db
    .collection(code ?? _userUid)
    .doc("${code ?? _userUid}+Wall")
    .collection(code ?? _userUid)
    .doc(docName) //folders 
    .collection("$docName+Envelope")
    .doc(); //envelope

    data["envelopeId"] = collection.id;
    await collection.set(data);

    final folderDoc = await folderDocs.doc(docName).get();
    final currentNumberOfEnvelopes = folderDoc.get("folderNumberOfEnvelopes") ?? 0;
    final updatedNumberOfEnvelopes = currentNumberOfEnvelopes + 1;
    await folderDocs.doc(docName).update({
      "folderNumberOfEnvelopes": updatedNumberOfEnvelopes
    });

    return;
  }

  Future<QuerySnapshot> getEnvelopeSnapshot(String docName, { String ? orderBy, String ? code}) async {
    final collection = _db.collection(code ??_userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+Envelope").orderBy(
        orderBy ?? "envelopeDate",
        descending: true
      );
    return await collection.get();
  } 

  Future<List<Map<String, dynamic>>> getAllEnvelopes(String docName, {String? code}) async {
  final collectionPath = _db
      .collection(code ?? _userUid)
      .doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid)
      .doc(docName);

  final querySnapshot = await collectionPath.get();
  final envelopesList = <Map<String, dynamic>>[];

  if (querySnapshot.exists) {
    final envelopesCollection = collectionPath
        .collection("$docName+Envelope");

    final envelopesSnapshot = await envelopesCollection.get();

    for (var doc in envelopesSnapshot.docs) {
      envelopesList.add(doc.data());
    }
  }

  return envelopesList;
}


  Future<void> updateEnvelope(String docName, String docId, Map<String, dynamic> data, {String ? code}) async {
    final collection = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+Envelope").doc(docId);

    await collection.update(data);
    return;
  }

  Future<void> deleteEnvelope(String docName, String docId, {String ? code}) async {
     final folderDocs = _db
      .collection(code ?? _userUid)
      .doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid);

    final document = _db
      .collection(code ?? _userUid)
      .doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid)
      .doc(docName)
      .collection("$docName+Envelope")
      .doc(docId);
    await document.delete();

    final folderDoc = await folderDocs.doc(docName).get();
    final currentNumberOfEnvelopes = folderDoc.get("folderNumberOfEnvelopes") ?? 0;
    final updatedNumberOfEnvelopes = currentNumberOfEnvelopes - 1;

    final newNumberOfEnvelopes = updatedNumberOfEnvelopes >= 0 ? updatedNumberOfEnvelopes : 0;
    await folderDocs.doc(docName).update({
      "folderNumberOfEnvelopes": newNumberOfEnvelopes
    });

    return;
  }

   Future<int> getTotalNumberOfEnvelopes() async {
    final _db = FirebaseFirestore.instance;
    final String _userUid = PocketPalAuthentication().getUserUID;
    final folderDocs = _db.collection(_userUid).doc("$_userUid+Wall").collection(_userUid);

    num totalNumberOfEnvelopes = 0;
    final documentsSnapshot = await folderDocs.get();
    for (final docSnapshot in documentsSnapshot.docs) {
      final folderDoc = await docSnapshot.reference.get();
      final folderNumberOfEnvelopes = folderDoc.data()?["folderNumberOfEnvelopes"] ?? 0;
      totalNumberOfEnvelopes  += folderNumberOfEnvelopes;
    }
    return totalNumberOfEnvelopes.toInt();
  }

  // ChatBox ======================================================
  Future<QuerySnapshot> getMessage(String docName, {String ? code}) async {
    final collection = _db.collection(code ??_userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+ChatBox")
      .orderBy(
        "messageDate",
        descending: false
      );

    return await collection.get();
  }

  Future<void> addMessage(Map<String, dynamic> data, String docName, {String ?  code}) async {
    final document = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+ChatBox").doc();
    
    data["messageId"] = document.id;
    await document.set(data); 
    return;
  }

  Future<void> updateMessage() async {
    return;
  }

  Future<void> deleteMessage(String docName, String docId, {String ? code}) async {  
    final document = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+ChatBox").doc(docId);
    await document.delete();
    return;
  }

  // User ======================================================
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserCredential() async {
    final collection = _db.collection(_userUid).doc("$_userUid+$_email");
    return await collection.get();
  } 

  Future<void> addUserCredential(Map<String, dynamic> data) async {
    final userInformationcollection = _db.collection(_userUid).doc("$_userUid+$_email");
    final recentTabCollection = _db.collection(_userUid).doc("$_userUid+RecentTab");

    await userInformationcollection.set(data);
    await recentTabCollection.set({
      "RecentTabItems" : []
    });
    return;
  }

  Future<void> updateUserCredential(Map<String, dynamic> data) async {
    final document = _db.collection(_userUid).doc("$_userUid+$_email");
    await document.update(data);
    return;
  }

  // Wall Manipulation ==========================================
  Future<DocumentSnapshot<Map<String, dynamic>>> getGroupCollecton(String code) async {
    final document = _db.collection(code).doc("$code+Information");
    return await document.get();
  } 

  Future<void> createGroupCollection(String code, Map<String, dynamic> data) async{
    final document = _db.collection(code).doc("$code+Information");
    await document.set(data);
    return;
  }
  
  Future<void> deleteGroupCollection(String code) async{
    
    return;
  }
  Future<void> updateGroupCollection(String code, Map<String, dynamic> data) async {
    final document = _db.collection(code).doc("$code+Information");
    await document.update(data);
    return;
  }

  // Recent Tab ==========================================
  Future<void> updateRecentTab(Map<String, dynamic> data) async {
    final document = _db.collection(_userUid).doc("$_userUid+RecentTab"); 
    await document.update(data);
    return;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getRecentTab() async {
    final document = _db.collection(_userUid).doc("$_userUid+RecentTab"); 
    return await document.get();
  }

}

class PocketPalDatabase {

  final _db = FirebaseFirestore.instance;
  final _userUid = PocketPalAuthentication().getUserUID;

// Envelope Transactions ===========================================================================
  Future<void> createEnvelopeTransaction(
    String docName,
    String envelopeName,
    Map<String, dynamic> data,
    {String ? orderBy, String ? code}
    ) async { 

    final collection = _db
        .collection(code ??_userUid)
        .doc("${code ?? _userUid}+Wall")
        .collection(code ?? _userUid)
        .doc(docName)
        .collection("$docName+Envelope")
        .doc(envelopeName);

    collection.set({
        "envelopeTransaction" : FieldValue.arrayUnion([data])
      }, SetOptions(
        merge: true
      ));
    return;
  }
  
  Stream<Map<String, dynamic>> getEnvelopeTransactions(
      String docName, 
      String envelopeName,
      {String ? orderBy, String ? code}
    ){
      final documentRef = _db
        .collection(code ?? _userUid)
        .doc("${code ?? _userUid}+Wall")
        .collection(code ?? _userUid)
        .doc(docName)
        .collection("$docName+Envelope")
        .doc(envelopeName);

      return documentRef.snapshots().map((snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;

        final transactions = <Map<String, dynamic>>[];
        final categories = <String>[];
        double expenseTotal = 0;
        double incomeTotal = 0;
        final categoryAmounts = <String, double>{};
        final expenseCategoryAmounts = <String, double>{};
        final incomeCategoryAmounts = <String, double>{};


        if (data.containsKey('envelopeTransaction')) {
          final List<dynamic>? envelopeData = data['envelopeTransaction'] as List<dynamic>?;
          if (envelopeData != null) {
            for (final Map<String, dynamic> transactionData in envelopeData){
              transactions.add(transactionData);

              if (transactionData['transactionType'] == "Expense") {
                final expenseAmount = (transactionData['transactionAmount'] as num).toDouble();
                expenseTotal += expenseAmount;

                final category = transactionData['transactionCategory'] as String?;
                if (category != null) {
                  if (!expenseCategoryAmounts.containsKey(category)) {
                    expenseCategoryAmounts[category] = expenseAmount;
                  } else {
                    expenseCategoryAmounts.update(category, (value) => value + expenseAmount);
                  }
                }
              }
              if (transactionData['transactionType'] == "Income") {
                final incomeAmount = (transactionData['transactionAmount'] as num).toDouble();
                incomeTotal += incomeAmount;

                final category = transactionData['transactionCategory'] as String?;
                if (category != null) {
                  if (!incomeCategoryAmounts.containsKey(category)) {
                    incomeCategoryAmounts[category] = incomeAmount;
                  } else {
                    incomeCategoryAmounts.update(category, (value) => value + incomeAmount);
                  }
                }
              }

              final category = transactionData['transactionCategory'] as String?;
              if (category != null) {
                if (!categories.contains(category)) {
                  categories.add(category);
                }
                 final categoryAmount = (transactionData['transactionAmount'] as num).toDouble();
                  categoryAmounts.update(category, (value) => value + categoryAmount, ifAbsent: () => categoryAmount);
                  }
            }
          }
        }
        return {
          'transactions': transactions,
          'expenseTotal': expenseTotal,
          'incomeTotal': incomeTotal,
          'categories': categories,
          'expenseCategoryAmounts': expenseCategoryAmounts,
          'incomeCategoryAmounts': incomeCategoryAmounts,
          };
      });
    }

    Future<void> deleteEnvelopeTransaction(
      String docName,
      String envelopeName,
      int index,
      {String ? orderBy, String ? code}
    ) async { 

    final collection = _db
        .collection(code ??_userUid)
        .doc("${code ?? _userUid}+Wall")
        .collection(code ?? _userUid)
        .doc(docName)
        .collection("$docName+Envelope")
        .doc(envelopeName);


    final snapshot = await collection.get();
    if (!snapshot.exists) {
      return;
    }
    final envelopeData = snapshot.data();
    final transactions = envelopeData?["envelopeTransaction"] as List<dynamic>;

    if (transactions == null || transactions.length <= index) {
      return;
    }

    final valueToRemove = transactions[index];
    collection.update({
        "envelopeTransaction": FieldValue.arrayRemove([valueToRemove])
    });
    return;
  }

  // Envelope Notes ======================================
  Future<void> createEnvelopeNotes(
    String docName, 
    String envelopeName,
    Map<String, dynamic> data, 
    {String ? orderBy, String ? code}
    ) async {  
    final collection = _db
      .collection(code ??_userUid)
      .doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid)
      .doc(docName)
      .collection("$docName+Envelope")
      .doc(envelopeName);
      

     collection.set({
        "envelopeNotes" : FieldValue.arrayUnion([data])
      }, SetOptions(
        merge: true
      ));
    
    return;
  }
    
  Stream<Map<String, dynamic>> getEnvelopeNotes(
      String docName, 
      String envelopeName,
      {String ? orderBy, String ? code}
    ){
    final documentRef = _db
      .collection(code ??_userUid)
      .doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid)
      .doc(docName)
      .collection("$docName+Envelope")
      .doc(envelopeName);

      return documentRef.snapshots().map((snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;

        final notes = <Map<String, dynamic>>[];

        if (data.containsKey('envelopeNotes')) {
          final List<dynamic>? envelopeData = data['envelopeNotes'] as List<dynamic>?;
          if (envelopeData != null) {
            for (final Map<String, dynamic> notesData in envelopeData){
              notes.add(notesData);
            }
          }
        }
        return {
          'notesData': notes,
          };
      });
  }


  Future<void> deleteEnvelopeNote(
      String docName,
      String envelopeName,
      int index, 
      {String ? orderBy, String ? code}
    ) async { 

     final collection = _db
      .collection(code ??_userUid)
      .doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid)
      .doc(docName)
      .collection("$docName+Envelope")
      .doc(envelopeName);


    final snapshot = await collection.get();
    if (!snapshot.exists) {
      return;
    }
    final envelopeData = snapshot.data();
    final notesData = envelopeData?["envelopeNotes"] as List<dynamic>;

    if (notesData == null || notesData.length <= index) {
      return;
    }

    final valueToRemove = notesData[index];
    collection.update({
        "envelopeNotes": FieldValue.arrayRemove([valueToRemove])
    });
    return;
  }

  Future<void> updateEnvelopeNote(
      String docName,
      String envelopeName,
      Map<String,dynamic> newNote,
      int index,
      {String ? orderBy, String ? code}
    ) async { 

       final collection = _db
        .collection(code ??_userUid)
        .doc("${code ?? _userUid}+Wall")
        .collection(code ?? _userUid)
        .doc(docName)
        .collection("$docName+Envelope")
        .doc(envelopeName);

      final snapshot = await collection.get();
      if (!snapshot.exists) {
      print("Failed 2");
        return;
      }
      final envelopeData = snapshot.data();
      final notesData = envelopeData?["envelopeNotes"] as List<dynamic>;

      if (notesData == null || notesData.length <= index) {
      print("Failed 1");
        return;
      }

      final valueToUpdate = notesData[index];
      valueToUpdate.addAll(newNote);
      print("Success");

      collection.update({
        "envelopeNotes": notesData 
      });

      return;
    }


    // Calendar Events =========================
  

}