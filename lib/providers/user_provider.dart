import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/database_service.dart";

class UserProvider with ChangeNotifier {

  List<Map<String, dynamic>> _userWall = [];
  List<Map<String, dynamic>> get getUserWall => _userWall;

  Future<void> fetchUserCredential() async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await 
      PocketPalFirestore().getUserCredential();

    _userWall = List<Map<String, dynamic>>.from(
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

  void clearUserWall(){
    _userWall.clear();
    notifyListeners();
    return;
  }


  List<Map<String, dynamic>> _recentTab = [];
  List<Map<String, dynamic>> get getRecentTab => _recentTab;

  Future<void> fetchRecentTab() async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot = await 
      PocketPalFirestore().getRecentTab();

    _recentTab = List<Map<String, dynamic>>.from(
      docSnapshot.get("RecentTabItems").map(
        (element) => Map<String, dynamic>.from(element)
      )
    ); 
    notifyListeners();
    return;
  }

  Future<void> addTabItem(Map<String, dynamic> data) async {

    if (_recentTab.length > 10){
      _recentTab.removeLast();
    }
    _recentTab.insert(0, data); 

    await PocketPalFirestore().updateRecentTab(
      {"RecentTabItems" : _recentTab}
    );
    fetchRecentTab();
    return;
  } 

  void clearRecentTab(){
    _recentTab.clear();
    notifyListeners();
    return; 
  }
}