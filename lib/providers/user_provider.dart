import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/utils/wall_util.dart";

class UserProvider with ChangeNotifier {

  String ? _orderBy;
  String get getOrderBy => _orderBy ?? "folderDate"; 
  set setOrderBy(String ? orderBy){
    _orderBy = orderBy;
    notifyListeners();
  }

  List<Map<String, dynamic>> _groupWall = [];
  List<Map<String, dynamic>> get getGroupWall => _groupWall;

  Future<void> fetchGroupWall() async {
    DocumentSnapshot docSnapshot = await PocketPalFirestore()
      .getUserCredential();

    _groupWall = List<Map<String, dynamic>>.from(
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
    fetchGroupWall();  
    return;
  }

  Future<void> updateGroupCode(Map<String, dynamic> data) async {
    await PocketPalFirestore().updateUserCredential(
      data, 
    );
    fetchGroupWall();
    return;
  }

  Future<void> createGroupWall(String code, Map<String, dynamic> data) async{
    await PocketPalFirestore().createGroupCollection(
      code,
      data
    );
    return;
  }
}