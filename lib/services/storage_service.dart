import "dart:io";

import "package:firebase_storage/firebase_storage.dart";
import "package:pocket_pal/services/authentication_service.dart";


class PocketPalStorage {

  final _storage = FirebaseStorage.instance;
  final _userUid = PocketPalAuthentication().getUserUID;

  Future<void> addImageToStorage(File image) async{
    String fileName = "${_userUid}_profile.png";

    Reference ref = _storage.ref().child("Profile/$fileName");
    await ref.putFile(image);
    return;
  }

  Future<String> getImageUrl() async {
    String fileName = "${_userUid}_profile.png";

    Reference ref = _storage.ref().child("Profile/$fileName");
    String url = await ref.getDownloadURL();
    
    return url;
  }

  Future<String> getDefaultImage() async {
    String fileName = "Profile.png";
    Reference ref = _storage.ref().child("Profile/$fileName");
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<void> addImageToChatBox(File image, String storageName, String messageId) async {
    String fileName = "$messageId.png";

    Reference ref = _storage.ref().child("$storageName/$fileName");
    await ref.putFile(image);
    return;
  }

  Future<String> getImageUrlFromChatBox(String storageName, String messageId) async {
    String fileName = "$messageId.png";

    Reference ref = _storage.ref().child("$storageName/$fileName");
    String url = await ref.getDownloadURL();
    
    return url;
  }
}