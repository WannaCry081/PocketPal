import "package:cloud_firestore/cloud_firestore.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/utils/chatbox_structure_util.dart";
import "package:pocket_pal/utils/envelope_structure_util.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";


class PocketPalDatabase {

  final _db = FirebaseFirestore.instance;
  final _userUid = PocketPalAuthentication().getUserUID;

  Future<void> addFolder(Map<String, dynamic> data) async {
    final collection = _db.collection(_userUid).doc();
    data["folderId"] = collection.id;
    await collection.set(data);
     
    return;
  }

  Stream<List<Folder>> getFolder(){
    final collection = _db.collection(_userUid);
    return collection.snapshots().map(
      (snapshot) => snapshot.docs.map(
        (doc) => Folder.fromMap(doc.data())
      ).toList()
    );
  }
  
  Future<void> deleteFolder(String docName) async {
    final document = _db.collection(_userUid).doc(docName);

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


  Future<void> deleteEnvelope(String docId, String docName ) async {
    final document = _db.collection(_userUid)
      .doc(docId).collection("$docId+Envelope").doc(docName);
    await document.delete();
    return;
  }

  Future<void> createEnvelope(String docName, Map<String, dynamic> data) async {  
    final collection = _db.collection(_userUid).doc(
      docName).collection("$docName+Envelope").doc();

    data["envelopeId"] = collection.id;
    await collection.set(data);
    
    return;
  }

   
  Future<void> createEnvelopeTransaction(
    String docName,
    String envelopeName,
    Map<String, dynamic> data) async { 
    final collection = _db.collection(_userUid).doc(
      docName).collection("$docName+Envelope").doc(envelopeName);

    collection.set({
        "envelopeTransaction" : FieldValue.arrayUnion([data])
      }, SetOptions(
        merge: true
      ));
    return;
  }

   Future<void> createEnvelopeNotes(
    String docName, 
    String envelopeName,
    Map<String, dynamic> data) async {  
    final collection = _db.collection(_userUid).doc(
      docName).collection("$docName+Envelope").doc(envelopeName);

     collection.set({
        "envelopeNotes" : FieldValue.arrayUnion([data])
      }, SetOptions(
        merge: true
      ));
    
    return;
  }


  Stream<List<Envelope>> getEnvelope(String docName){
    final collection = _db.collection(_userUid).doc(docName).collection("$docName+Envelope");

    return collection.snapshots().map(
      (snapshot) => snapshot.docs.map(
        (doc) => Envelope.fromMap(doc.data())
      ).toList()
    );
  }

  Stream<Map<String, dynamic>> getEnvelopeTransactions(
      String docName, 
      String envelopeName,
  ) {
      final documentRef = FirebaseFirestore.instance
        .collection(_userUid)
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
          'categoryAmounts': categoryAmounts,
          'expenseCategoryAmounts': expenseCategoryAmounts,
          'incomeCategoryAmounts': incomeCategoryAmounts,
          };
      });
    }
    
  Stream<Map<String, dynamic>> getEnvelopeNotes(
      String docName, 
      String envelopeName,
    ){
      final documentRef = FirebaseFirestore.instance
        .collection(_userUid)
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

  Future<void> deleteEnvelopeTransaction(
      String docName,
      String envelopeName,
      int index) async { 
    final collection = _db.collection(_userUid)
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

  Future<void> deleteEnvelopeNote(
      String docName,
      String envelopeName,
      int index) async { 
    final collection = _db.collection(_userUid)
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

  Future<void> createMessage(String docName, Map<String, dynamic> data) async {
    final collection = _db.collection(_userUid).doc(docName)
      .collection("$docName+ChatBox").doc();

    data["messageId"] = collection.id;
    collection.set(data);
    return;
  }

  Stream<List<ChatBox>> getMessages(String docName){
    final collection = _db.collection(_userUid).doc(docName)
      .collection("$docName+ChatBox");

    return collection.snapshots().map(
      (snapshot) => snapshot.docs.map(
        (doc) => ChatBox.fromMap(doc.data())
      ).toList()
    );
  }

  Future<void> deleteMessage(String docName, String docId) async {
    final collection = _db.collection(_userUid).doc(docName)
      .collection("$docName+ChatBox").doc(docId);

    await collection.delete();
    return;
  }

}