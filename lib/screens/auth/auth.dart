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

  late bool _isFirstInstall;

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _isFirstInstall = Provider.of<SettingsProvider>(
      context,
      listen: true
    ).getBoolPreference("isFirstInstall");
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