// import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:google_sign_in/google_sign_in.dart";


class AuthFirebaseService {
  Future<void> signUpUser(String email, String password) async {

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );

    // final database = FirebaseFirestore.instance.collection("users");
    // await database.add({
    //   "full name" : _name.text.trim(),
    //   "email" : _email.text.trim()
    // });
    return;
  }

  Future<void> signInUser(String email, String password) async {

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
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