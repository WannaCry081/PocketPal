import "package:cloud_firestore/cloud_firestore.dart";


class DashboardFirebaseService {

  final FirebaseFirestore _db = FirebaseFirestore.instance; 

  Future<void> addData(String collectionName, Map<String, dynamic> data) async {
    try {
      await _db.collection(collectionName).add(data);
    } catch (e) {
      print(e); 
    }
    return;
  }

  Stream<QuerySnapshot> getData(String collectionName) {
    return _db.collection(collectionName).snapshots();
  }

  Future<void> updateData(
    String collectionName, 
    String documentID, 
    Map<String, dynamic> data) async {

    try {
      await _db.collection(collectionName).doc(documentID).update(data);
    } catch (e) {
      print(e);
    }

    return;
  }

  Future<void> deleteData(String collectionName, String documentID) async {
    try {
      await _db.collection(collectionName).doc(documentID).delete();
    } catch (e) {
      print(e);
    }
    return;
  }



  
}