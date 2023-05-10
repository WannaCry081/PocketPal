import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/utils/chatbox_structure_util.dart";


class ChatBoxProvider with ChangeNotifier{

  List<ChatBox> _chatList = [];
  List<ChatBox> get getChatList => _chatList; 

  Future<void> fetchConversation(String docName, { String ? code }) async {
    QuerySnapshot querySnapshot = await PocketPalFirestore()
      .getMessage(docName, code : code); 

    _chatList = querySnapshot.docs.map(
      (doc) => ChatBox.fromMap(doc.data() as Map<String, dynamic>)
    ).toList();
    notifyListeners();
    return;
  }

  Future<void> sendMessage(Map<String, dynamic> data, String docName, {String ? code}) async {
    await PocketPalFirestore().addMessage(
      data,
      docName,
      code : code,
    );
    fetchConversation(docName, code : code);
    return;
  }
}
