import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/providers/settings_provider.dart";

import "package:pocket_pal/screens/auth/pages/signin_page.dart";
import "package:pocket_pal/screens/auth/pages/signup_page.dart";


class AuthView extends StatefulWidget {
  const AuthView({ Key ? key }) : super(key : key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>{

  bool _isFirstInstall = true;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _isFirstInstall = Provider.of<SettingsProvider>(
      context,
      listen : true
    ).getIsFirstInstall;
    return;
  }

  @override 
  Widget build(BuildContext context){
    
    if (_isFirstInstall){
      return SignUpPage(
        changeStateIsFirstInstall : _changeStateIsFirstInstall
      ); 
    } else {
      return SignInPage(
        changeStateIsFirstInstall : _changeStateIsFirstInstall
      );
    }
  }

  void _changeStateIsFirstInstall() => setState((){
    _isFirstInstall = !_isFirstInstall;
  }); 
}