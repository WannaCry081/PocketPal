import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/providers/settings.dart";


class OnboardView extends StatelessWidget{
  const OnboardView({ super.key });

  @override
  Widget build(BuildContext context){

    final rSettings = context.read<SettingsProvider>();

    return Scaffold(
      body : Center(
        child : ElevatedButton(
          onPressed: (){
            rSettings.setFirstInstall = false;
          },
          child : Text("Hi")
        )
      )
    );
  }
}