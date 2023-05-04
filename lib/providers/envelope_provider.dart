import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/utils/envelope_util.dart";


class EnvelopeProvider with ChangeNotifier {

  String ? _orderBy;

  set setOrderBy(String ? orderBy){
    _orderBy = orderBy;
    notifyListeners();
  }

  String ? _groupCode;
  String get getGroupCode => _groupCode ?? "";

  List<Envelope> _envelopeList = [];
  List<Envelope> get getEnvelopeList => _envelopeList;

  Future<void> fetchEnvelope(String docName, { String ? code }) async {
    QuerySnapshot querySnapshot = await PocketPalFirestore()
      .getEnvelopeSnapshot(
        docName,
        orderBy: _orderBy ,
        code : code
      );

    _envelopeList = querySnapshot.docs.map(
      (doc) => Envelope.fromMap(doc.data() as Map<String, dynamic>)
    ).toList();
    notifyListeners();
    return; 
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