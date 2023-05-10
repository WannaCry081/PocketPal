import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:pocket_pal/services/database_service.dart";

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

    final currentUser = newUser.user!;
    
    await currentUser.updateDisplayName(userName);
    await currentUser.updatePhotoURL(
      await PocketPalStorage().getDefaultImage()
    );

    await currentUser.reload();
    return;
  }

  Future<List<String>> authenticationGoogle() async { 
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth?.idToken,
      accessToken: googleAuth?.accessToken
    );

    await _auth.signInWithCredential(credential);
    return [
      googleUser?.displayName ?? "",
      googleUser?.email ?? ""
    ];
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

  Future<void> authenticationUpdateProfile(String newPicture) async {  
    final currentUser = _auth.currentUser!;
    await currentUser.updatePhotoURL(newPicture);
    return;
  }

  Future<void> authenticationUpdateDisplayName(String newDisplayName) async {
    final currentUser = _auth.currentUser!;
    await currentUser.updateDisplayName(newDisplayName);
    return;
  }

  Future<void> authenticationDeleteAccount() async {
    final user = _auth.currentUser!;
    // final db = PocketPalDatabase();
    await user.delete();
    return;
  }


  String get getUserDisplayName => _auth.currentUser?.displayName ?? "";
  String get getUserEmail => _auth.currentUser?.email ?? "";
  String get getUserPhotoUrl => _auth.currentUser?.photoURL ?? "";
  String get getUserUID => _auth.currentUser!.uid;

  Future<void> authenticationChangePassword(
    String oldPassword,
    String newPassword
  ) async {

    final currentUser = _auth.currentUser!;

    final credential = EmailAuthProvider.credential(
      email : currentUser.email!, 
      password: oldPassword
    );

    await currentUser.reauthenticateWithCredential(credential);
    await currentUser.updatePassword(newPassword);

    return;
  }
}

