import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";


class DashboardFirebaseService {

  final FirebaseFirestore _db = FirebaseFirestore.instance; 
  final userEmail = FirebaseAuth.instance.currentUser!.email!;

  Future<void> addData(
    String collectionName, 
    String fieldName,
    Map<String, dynamic> data,
  ) async {
    try {

      final collection = _db.collection(collectionName).doc(userEmail);

      collection.set({
        fieldName : FieldValue.arrayUnion([data])
      }, SetOptions(
        merge: true
      ));

    } catch (e) {
      print(e); 
    }
    return;
  }

  Stream<DocumentSnapshot> getDataStream(String collectionName  ) {
    return FirebaseFirestore.instance.collection(collectionName).doc(userEmail).snapshots();
  }


  Future<List<dynamic>> getSpecificArrayField(String collectionName, String fieldName) async {
    DocumentSnapshot documentSnapshot = await _db.collection(collectionName).doc(userEmail).get();

    if (documentSnapshot.exists) {
      List<dynamic> specificArrayField = documentSnapshot.data()! as List;
      return specificArrayField;
    } else {
      return [];
    }
  }


  Future<void> updateData( String collectionName, Map<String, dynamic> data) async {
    try {

      final userEmail = FirebaseAuth.instance.currentUser!.email!;
      final collection = _db.collection(collectionName).doc(userEmail);
      
      collection.update({
        "Personal" : data
      });

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