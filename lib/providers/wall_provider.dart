import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/database_service.dart";

class WallProvider with ChangeNotifier{
  
  late String _groupWallName;
  String get getGroupWallName => _groupWallName;

  List<Map<String, dynamic>> _wallList = [];
  List<Map<String, dynamic>> get getWallList => _wallList;

  // Group Wall Manipulation
  Future<void> fetchGroupWall(String code) async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await PocketPalFirestore()
      .getGroupCollecton(code);

    _wallList = List<Map<String, dynamic>>.from(
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
  //   fetchGroupWall(code);
  //   return;
  // }

  Future<void> createGroupWall(Map<String, dynamic> data, String code, ) async{
    await PocketPalFirestore().createGroupCollection(
      code,
      data
    );
    fetchGroupWall(code);
    return;
  }
  Future<void> updateGroupWall(Map<String, dynamic> data, String code) async {
    await PocketPalFirestore().updateGroupCollection(
      code,
      data
    );  
    fetchGroupWall(code);
    return;
  }

  void clearWallList(){
    _wallList.clear();
    notifyListeners();
    return;
  }
}