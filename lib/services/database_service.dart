import "package:cloud_firestore/cloud_firestore.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";


class PocketPalDatabase {

  final _db = FirebaseFirestore.instance;

  Future<void> addFolder(Map<String, dynamic> data) async {
    final userUid = PocketPalAuthentication().getUserUID;

    final collection = _db.collection(userUid).doc();
    data["id"] = collection.id;
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
}