import "package:flutter/material.dart"; 
import "package:firebase_auth/firebase_auth.dart";

import "package:pocket_pal/screens/auth/auth_builder.dart";
import "package:pocket_pal/screens/menu/menu_drawer.dart";

class AuthView extends StatelessWidget {
  const AuthView({ super.key });

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body : StreamBuilder<User?>(
        stream : FirebaseAuth.instance.authStateChanges(),
        builder : (context, snapshot){

          if (snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData){
            // return const MenuDrawerView();
            return const MenuDrawerView();

          } else {
            return const AuthViewBuilder();
          }
          
        }
      )
    );
  }
}