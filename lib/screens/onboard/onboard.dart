import "package:flutter/material.dart";
import "package:pocket_pal/providers/settings_provider.dart";
import "package:pocket_pal/screens/auth/auth_builder.dart";
import "package:provider/provider.dart";


class OnboardView extends StatelessWidget {
  const OnboardView({ Key ? key }) : super( key : key );

  @override
  Widget build(BuildContext context){
    final wSettings = context.watch<SettingsProvider>();
    final rSettings = context.read<SettingsProvider>();

    return Scaffold(
      body : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
            ElevatedButton(
              child : Text("Click Me"),
              onPressed: (){
                if (wSettings.getShowOnboard){
                  rSettings.setShowOnboard(
                    !wSettings.getShowOnboard
                  );
                }

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder : (context) => const AuthViewBuilder()
                  )
                );
              },
            )
          ]
        ),
      )
    );
  }
}