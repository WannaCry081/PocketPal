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
        "envelopTransaction" : FieldValue.arrayUnion([data])
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

  


}