import "package:flutter/material.dart"; 
import "package:firebase_auth/firebase_auth.dart";

import "package:pocket_pal/screens/auth/pages/loading_dart.dart";
import "package:pocket_pal/screens/auth/pages/error_page.dart";
import "package:pocket_pal/screens/menu/menu_drawer.dart";
import "package:pocket_pal/screens/auth/auth.dart";

class AuthViewBuilder extends StatelessWidget {

  const AuthViewBuilder({ Key ? key }) : super(key : key);

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body : StreamBuilder<User?>(
        stream : FirebaseAuth.instance.authStateChanges(),
        builder : (context, snapshot){

          if (snapshot.connectionState == ConnectionState.waiting){
            return const LoadingPage();
          } 

          else if (snapshot.hasData){
            return const MenuDrawerView();
          } 
          
          else if (snapshot.hasError){
            return const ErrorPage();
          }
          
          else {
            return const AuthView();          
          }
        }
      )
    );
  }
}