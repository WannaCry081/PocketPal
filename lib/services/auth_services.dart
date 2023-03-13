// import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:google_sign_in/google_sign_in.dart";


class AuthFirebaseService {

  Future<void> signUpUser(String name, String email, String password) async {

    // final database = FirebaseFirestore.instance.collection("users");
    // await database.add({
    //   "full name" : _name.text.trim(),
    //   "email" : _email.text.trim()
    // });


    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Set display name
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.updatePhotoURL("assets/images/Profile.png");

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return;
  }

  Future<void> signInUser(String email, String password) async {

    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //   email: email, 
    //   password: password
    // );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
          // Generate code here after successfully creating the user.
        } on FirebaseAuthException catch (e) {
          // Handle any errors that occur while creating the user.
        }
      } else {
        // Handle any other errors that occur while signing in.
      }
    }
    return;
  }

  Future<void> forgotPassword(String email) async {

    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email
    );
    return;
  }

  Future<void> signInWithGoogle() async{
    
    GoogleSignInAccount ? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication ? googleAuth = await googleUser!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );
    
    await FirebaseAuth.instance.signInWithCredential(
      credential
    );
    return;
  }
}