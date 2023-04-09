import "dart:io";

import "package:firebase_storage/firebase_storage.dart";
import "package:pocket_pal/services/authentication_service.dart";


class PocketPalStorage {

  final _storage = FirebaseStorage.instance;

  Future<void> addImageToStorage(File image) async{
    String userUid = PocketPalAuthentication().getUserUID;
    String fileName = "${userUid}_profile.png";

    Reference ref = _storage.ref().child("Profile/$fileName");
    await ref.putFile(image);
    return;
  }

  Future<String> getImageUrl(bool ? isDefualt) async {
    String fileName = "Profile.png";
    
    if (isDefualt != null) {
      String userUid = PocketPalAuthentication().getUserUID;
      fileName = "${userUid}_profile.png";
    }

    Reference ref = _storage.ref().child("Profile/$fileName");
    String url = await ref.getDownloadURL();
    
    return url;
  }
}