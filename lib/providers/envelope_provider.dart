import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/utils/Envelope_structure_util.dart";


class EnvelopeProvider with ChangeNotifier {

  String ? _groupCode;
  String get getGroupCode => _groupCode ?? "";

  List<Envelope> _envelopeList = [];
  List<Envelope> get getEnvelopeList => _envelopeList;

  Future<void> fetchEnvelope({ String ? code }) async {
    
    return; 
  } 

  Future<void> addEnvelope(Map<String, dynamic> data) async {
    
    return;
  }

  Future<void> updateEnvelope() async {

    return;
  }

  Future<void> deleteEnvelope(String docName) async {

    return;
  }
}