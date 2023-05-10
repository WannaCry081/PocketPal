import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/database_service.dart";

class WallProvider with ChangeNotifier{
  
  late String _groupWallName;
  String get getGroupWallName => _groupWallName;

  List<Map<String, dynamic>> _groupCollection = [];
  List<Map<String, dynamic>> get getGroupCollection => _groupCollection;

  // Group Wall Manipulation
  Future<void> fetchGroupWall(String code) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await PocketPalFirestore()
      .getGroupCollecton(code);

    _groupCollection = List<Map<String, dynamic>>.from(
      docSnapshot.get("wallMembers").map(
        (element) => Map<String, dynamic>.from(element)
      )
    );    
    notifyListeners();
    return;
  }
  Future<void> fetchGroupWallName(String code) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await PocketPalFirestore()
      .getGroupCollecton(code);

    _groupWallName =  docSnapshot.get("wallName");
    notifyListeners();
    return;
  }

  // Future<void> deleteGroupWall(String code) async{
  //   fetchGroupWall();
  //   return;
  // }

  Future<void> createGroupWall(String code, Map<String, dynamic> data) async{
    await PocketPalFirestore().createGroupCollection(
      code,
      data
    );
    fetchGroupWall(code);
    return;
  }
  Future<void> updateGroupWall(String code, Map<String, dynamic> data) async {
    await PocketPalFirestore().updateGroupCollection(
      code,
      data
    );  
    fetchGroupWall(code);
    return;
  }
}