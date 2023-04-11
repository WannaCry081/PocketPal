import "package:firebase_messaging/firebase_messaging.dart";


class PocketPalMessaging {
  final _message = FirebaseMessaging.instance;

  void initialize() {
    _message.requestPermission();
    _message.getToken();
    return;
  }


  
}
