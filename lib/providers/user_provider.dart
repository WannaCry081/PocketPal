import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/database_service.dart";

class UserProvider with ChangeNotifier {

  List<Map<String, dynamic>> _userGroupWall = [];
  List<Map<String, dynamic>> get getUserGroupWall => _userGroupWall;

  Future<void> fetchUserCredential() async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await 
      PocketPalFirestore().getUserCredential();


    _userGroupWall = List<Map<String, dynamic>>.from(
      docSnapshot.get("palGroupWall").map(
        (element) => Map<String, dynamic>.from(element)
      )
    );    
    notifyListeners();
    return;
  }

  Future<void> addUserCredential(Map<String, dynamic> data) async {
    await PocketPalFirestore().addUserCredential(
      data,
    );
    fetchUserCredential();  
    return;
  }

  Future<void> updateGroupCode(Map<String, dynamic> data) async {
    await PocketPalFirestore().updateUserCredential(
      data, 
    );
    fetchUserCredential();
    return;
  }  
}