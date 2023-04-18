import "package:cloud_firestore/cloud_firestore.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/utils/envelope_structure_util.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";


class PocketPalDatabase {

  final _db = FirebaseFirestore.instance;

  Future<void> addFolder(Map<String, dynamic> data) async {
    final userUid = PocketPalAuthentication().getUserUID;

    final collection = _db.collection(userUid).doc();
    data["folderId"] = collection.id;
    await collection.set(data);
     
    return;
  }

  Stream<List<Folder>> getFolder(){
    final userUid = PocketPalAuthentication().getUserUID;

    final collection = _db.collection(userUid);
    return collection.snapshots().map(
      (snapshot) => snapshot.docs.map(
        (doc) => Folder.fromMap(doc.data())
      ).toList()
    );
  }

  Future<void> createEnvelope(String docName, Map<String, dynamic> data) async {  
    final userUid = PocketPalAuthentication().getUserUID;

    final collection = _db.collection(userUid).doc(
      docName).collection("$docName+Envelope").doc();

    data["envelopeId"] = collection.id;
    await collection.set(data);
    
    return;
  }

   
  Future<void> createEnvelopeTransaction(
    String docName,
    String envelopeName,
    Map<String, dynamic> data) async { 

    final userUid = PocketPalAuthentication().getUserUID;

    final collection = _db.collection(userUid).doc(
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
    final userUid = PocketPalAuthentication().getUserUID;

    final collection = _db.collection(userUid).doc(
      docName).collection("$docName+Envelope").doc(envelopeName);

     collection.set({
        "envelopeNotes" : FieldValue.arrayUnion([data])
      }, SetOptions(
        merge: true
      ));
    
    return;
  }


  Stream<List<Envelope>> getEnvelope(String docName){
    final userUid = PocketPalAuthentication().getUserUID;

    final collection = _db.collection(userUid).doc(docName).collection("$docName+Envelope");

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
      final userUid = PocketPalAuthentication().getUserUID;
      final documentRef = FirebaseFirestore.instance
        .collection(userUid)
        .doc(docName)
        .collection("$docName+Envelope")
        .doc(envelopeName);

      return documentRef.snapshots().map((snapshot) {
        final data = snapshot.data() as Map<String, dynamic>;

        final transactions = <Map<String, dynamic>>[];
        double expenseTotal = 0;
        double incomeTotal = 0;

        if (data.containsKey('envelopeTransaction')) {
          final List<dynamic>? envelopeData = data['envelopeTransaction'] as List<dynamic>?;
          if (envelopeData != null) {
            for (final Map<String, dynamic> transactionData in envelopeData){
              transactions.add(transactionData);

              if (transactionData['transactionType'] == "Expense") {
                final expenseAmount = (transactionData['transactionAmount'] as num).toDouble();
                expenseTotal += expenseAmount;
              }
              if (transactionData['transactionType'] == "Income") {
                final incomeAmount = (transactionData['transactionAmount'] as num).toDouble();
                incomeTotal += incomeAmount;
              }
            }
          }
        }
        return {
          'transactions': transactions,
          'expenseTotal': expenseTotal,
          'incomeTotal': incomeTotal,
          };
      });
    }
    
  Stream<Map<String, dynamic>> getEnvelopeNotes(
      String docName, 
      String envelopeName,
    ){
      final userUid = PocketPalAuthentication().getUserUID;
      final documentRef = FirebaseFirestore.instance
        .collection(userUid)
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

  void deleteEnvelopeTransaction(
    String docName, 
    String envelopeName, 
    int index) {
      final userUid = PocketPalAuthentication().getUserUID;
      FirebaseFirestore.instance
          .collection(userUid)
          .doc(docName)
          .collection("$docName+Envelope")
          .doc(envelopeName)
          .update({
            'envelopeTransaction.${index}': FieldValue.delete(),
      });
}
}