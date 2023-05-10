import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/utils/folder_util.dart";


class FolderProvider with ChangeNotifier {

  String ? _orderBy;
  String get getOrderBy => _orderBy ?? "folderDate"; 
  set setOrderBy(String ? orderBy){
    _orderBy = orderBy;
    notifyListeners();
  }

  List<Folder> _folderList = [];
  List<Folder> get getFolderList => _folderList;

  Future<void> fetchFolder({ String ? code }) async {
    QuerySnapshot querySnapshot = await PocketPalFirestore()
      .getFolderSnapshot(
        orderBy: _orderBy ?? "folderDate",
        code : code
      );

    _folderList = querySnapshot.docs.map(
      (doc) => Folder.fromMap(doc.data() as Map<String, dynamic>)
    ).toList();
    notifyListeners();
    return; 
  } 

  Future<void> createFolder(
    Map<String, dynamic> data, { 
      String ? code 
  }) async {
    await PocketPalFirestore().addFolder(data, code : code);
    fetchFolder(code : code);
    return;
  }

  Future<void> updateFolder(
    Map<String, dynamic> data,
    String docName, { 
      String ? code 
  }) async {
    await PocketPalFirestore().updateFolder(
      docName,
      data, 
      code : code
    );
    fetchFolder(code : code);
    return;
  }

  Future<void> deleteFolder(String docName, { String ? code }) async {
    await PocketPalFirestore().deleteFolder(docName, code : code);
    fetchFolder(code : code);
    return;
  }

  void clearFolderList(){
    _folderList.clear();
    notifyListeners();
    return;
  }
}