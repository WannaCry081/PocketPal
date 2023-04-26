import "package:flutter/material.dart";
import "package:pocket_pal/providers/settings_provider.dart";
import "package:pocket_pal/screens/auth/auth_builder.dart";
import "package:pocket_pal/services/messaging_service.dart";
import "package:provider/provider.dart";


class OnboardView extends StatefulWidget {
  const OnboardView({ Key ? key }) : super( key : key );

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {

  @override
  void initState(){
    super.initState();

    PocketPalNotification().init();
    return;
  }

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

                  PocketPalNotification().showNotification(
                    title : "Nigana maam", 
                    body : "HAHAHAHAHAHA yehey nigana sha HAHAHAAHAHAH"
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