import "package:cloud_firestore/cloud_firestore.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/utils/chatbox_structure_util.dart";


class PocketPalFirestore {

  final _db = FirebaseFirestore.instance;
  final String _userUid = PocketPalAuthentication().getUserUID;
  final String _email = PocketPalAuthentication().getUserEmail;

  // Folders ======================================================
  Future<QuerySnapshot> getFolderSnapshot({String ? orderBy, String ? code}) async {
    final collectionSnapshot = _db.collection(code ??_userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).orderBy(
      orderBy ?? "folderDate", descending: true
    );
    return await collectionSnapshot.get();
  } 

   Future<void> addFolder(Map<String, dynamic> data, {String ? code}) async {
    final collection = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc();
    data["folderId"] = collection.id;
    await collection.set(data);
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
    final collection = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName);
    await collection.update(data);
    return;
  }

  //Events =================
  Future<void> addEvent (
      Map<String, dynamic> data, 
      {String ? orderBy}
    ) async{

      final collection = _db
        .collection(_userUid)
        .doc("$_userUid+Event")
        .collection(_userUid)
        .doc();

      data["eventId"] = collection.id;
      await collection.set(data);
      getEventSnapshot();
      return;
    }

  Future<QuerySnapshot> getEventSnapshot({String ? orderBy,}) async {
    final collectionSnapshot = _db
        .collection(_userUid)
        .doc("$_userUid+Event")
        .collection(_userUid).orderBy(
      orderBy ?? "eventDate", descending: false
    );
    return await collectionSnapshot.get();
  }  

  // Envelope ======================================================
  Future<void> addEnvelope(Map<String, dynamic> data, String docName, {String ? code}) async {
    final collection = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+Envelope").doc();

    data["envelopeId"] = collection.id;
    await collection.set(data);
    return;
  }

  Future<QuerySnapshot> getEnvelopeSnapshot(String docName, { String ? orderBy, String ? code}) async {
    final collectionSnapshot = _db.collection(code ??_userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+Envelope").orderBy(
        orderBy ?? "envelopeDate",
        descending: true
      );
    return await collectionSnapshot.get();
  } 


  Future<void> updateEnvelope(String docName, String docId, Map<String, dynamic> data, {String ? code}) async {
    final collection = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+Envelope").doc(docId);

    await collection.update(data);
    return;
  }

  Future<void> deleteEnvelope(String docName, String docId, {String ? code}) async {
     final document = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+Envelope").doc(docId);
    await document.delete();
    return;
  }

  // ChatBox ======================================================
  Future<QuerySnapshot> getMessage(String docName, {String ? code}) async {
    final collectionSnapshot = _db.collection(code ??_userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+ChatBox")
      .orderBy(
        "messageDate",
        descending: false
      );

    return await collectionSnapshot.get();
  }

  Future<void> addMessage(Map<String, dynamic> data, String docName, {String ?  code}) async {
    final collection = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+ChatBox").doc();
    
    data["messageId"] = collection.id;
    await collection.set(data); 
    return;
  }

  Future<void> updateMessage() async {
    return;
  }

  Future<void> deleteMessage(String docName, String docId, {String ? code}) async {  
    final collection = _db.collection(code ?? _userUid).doc("${code ?? _userUid}+Wall")
      .collection(code ?? _userUid).doc(docName).collection("$docName+ChatBox").doc(docId);
    await collection.delete();
    return;
  }

  // User ======================================================
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserCredential() async {
    final collectionSnapshot = _db.collection(_userUid).doc("$_userUid+$_email");
    return await collectionSnapshot.get();
  } 

  Future<void> addUserCredential(Map<String, dynamic> data) async {
    final collection = _db.collection(_userUid).doc("$_userUid+$_email");
    await collection.set(data);
    return;
  }

  Future<void> updateUserCredential(Map<String, dynamic> data) async {
    final collection = _db.collection(_userUid).doc("$_userUid+$_email");
    await collection.update(data);
    return;
  }


  // Wall Manipulation ==========================================
  Future<DocumentSnapshot<Map<String, dynamic>>> getGroupCollecton(String code) async {
    final collectionSnapshot = _db.collection(code).doc("$code+Information");
    return await collectionSnapshot.get();
  } 

  Future<void> createGroupCollection(String code, Map<String, dynamic> data) async{
    final collection = _db.collection(code).doc("$code+Information");
    await collection.set(data);
    return;
  }
  
  Future<void> deleteGroupCollection(String code) async{
    
    return;
  }
  Future<void> updateGroupCollection(String code, Map<String, dynamic> data) async {
    final collection = _db.collection(code).doc("$code+Information");
    await collection.update(data);
    return;
  }
  
}

class PocketPalDatabase {

  final _db = FirebaseFirestore.instance;
  final _userUid = PocketPalAuthentication().getUserUID;

  
  Future<String> createMessage(String docName, Map<String, dynamic> data) async {
    final collection = _db.collection(_userUid).doc(docName)
      .collection("$docName+ChatBox").doc();

    data["messageId"] = collection.id;
    collection.set(data);
    return data["messageId"];
  }

  // Stream<List<ChatBox>> getMessages(String docName){
  //   final collection = _db.collection(_userUid).doc(docName)
  //     .collection("$docName+ChatBox");

  //   return collection.snapshots().map(
  //     (snapshot) => snapshot.docs.map(
  //       (doc) => ChatBox.fromMap(doc.data())
  //     ).toList()
  //   );
  // }

  // Future<void> deleteMessage(String docName, String docId) async {
  //   final collection = _db.collection(_userUid).doc(docName)
  //     .collection("$docName+ChatBox").doc(docId);

  //   await collection.delete();
  //   return; 
  // }

  // Future<void> updateMessage(
  //   String docName, 
  //   String docId, 
  //   Map<String, dynamic> newData ) async{

  //   final collection = _db.collection(_userUid).doc(docName)
  //     .collection("$docName+ChatBox").doc(docId);
  //   await collection.update(newData);
  //   return;
  // }
   

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
      final documentRef = FirebaseFirestore.instance
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
      final userUid = PocketPalAuthentication().getUserUID;

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

      final valueToUpdate = notesData[index];
      valueToUpdate.addAll(newNote);

      collection.update({
        "envelopeNotes": notesData 
      });

      return;
    }


    // Calendar Events =========================
  

}