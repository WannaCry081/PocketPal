import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";

import "package:pocket_pal/services/storage_service.dart";


class PocketPalAuthentication {

  final _auth = FirebaseAuth.instance;

  Future<void> authenticationSignInEmailAndPassword(
    String userEmail, String userPassword
  ) async {
    await _auth.signInWithEmailAndPassword(
      email: userEmail, 
      password: userPassword
    );
    return;
  }

  Future<void> authenticationSignUpEmailAndPassword(
    String userName, String userEmail, String userPassword
  ) async {
    
    final newUser = await _auth.createUserWithEmailAndPassword(
      email: userEmail, 
      password: userPassword
    );

    final currentUser = newUser.user;
    if (currentUser != null){
      currentUser.updateDisplayName(userName);
      currentUser.updatePhotoURL(
        await PocketPalStorage().getImageUrl(null)
      );
    }
    return;
  }

  Future<void> authenticationGoogle() async { 
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken
    );

    await _auth.signInWithCredential(credential);
    return;
  }

  Future<void> authenticationLogout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
    return;
  }

  Future<void> authenticationResetPassword(
    String userEmail
  ) async {
    await _auth.sendPasswordResetEmail(
      email : userEmail
    );
    return;
  }


  String get getUserDisplayName => _auth.currentUser!.displayName ?? "";
  String get getUserEmail => _auth.currentUser!.email ?? "";
  String get getUserPhotoUrl => _auth.currentUser!.photoURL ?? "";
  String get getUserUID => _auth.currentUser!.uid;
}

