import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/utils/envelope_util.dart";


class EnvelopeProvider with ChangeNotifier {

  String ? _orderBy;
  String get getOrderBy => _orderBy ?? "envelopeDate";
  set setOrderBy(String orderBy){
    _orderBy = orderBy;
    notifyListeners();
  }

  String ? _groupCode;
  String get getGroupCode => _groupCode ?? "";
  set setGroupCode(String value){
    _groupCode = value;
    notifyListeners();
    return;
  }

  List<Envelope> _envelopeList = [];
  List<Envelope> get getEnvelopeList => _envelopeList;

  Future<void> fetchEnvelope(String docName, { String ? code }) async {
    QuerySnapshot querySnapshot = await PocketPalFirestore()
      .getEnvelopeSnapshot(
        docName,
        orderBy: _orderBy ?? "envelopeDate",
        code : code
      );

    _envelopeList = querySnapshot.docs.map(
      (doc) => Envelope.fromMap(doc.data() as Map<String, dynamic>)
    ).toList();
    
    notifyListeners();
    return; 
  }  

   Future<List<Map<String, dynamic>>> getAllEnvelopes(String docName, {String? code}) 
   async {
      final String _userUid = PocketPalAuthentication().getUserUID;
      final String _email = PocketPalAuthentication().getUserEmail;
      
      final collectionPath =  FirebaseFirestore.instance
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
      print(envelopesList);
      return envelopesList;
    }

  Future<void> addEnvelope(Map<String, dynamic> data, String docName, {String ? code}) async {
    await PocketPalFirestore().addEnvelope(
      data,
      docName,
      code : code
    );
    fetchEnvelope(docName, code : code);
    return;
  }

  Future<void> updateEnvelope(
    Map<String, dynamic> data, 
    String docName, 
    String docId, {
      String ? code
  }) async {
    await PocketPalFirestore().updateEnvelope(
      docName,
      docId,
      data,
      code : code
    );
    fetchEnvelope(docName, code : code);
    return;
  }

  Future<void> deleteEnvelope(String docName, String docId, {String ? code}) async {
    await PocketPalFirestore().deleteEnvelope(
      docName,
      docId, 
      code : code
    );
    fetchEnvelope(docName, code : code);
    return;
  }
}