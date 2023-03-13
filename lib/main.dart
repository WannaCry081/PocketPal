import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/screens/dashboard/dashboard.dart";
import "package:pocket_pal/screens/onboard/onboard.dart";

import "package:pocket_pal/providers/theme_manager.dart";
import "package:pocket_pal/providers/settings_provider.dart";

import "package:pocket_pal/const/dark_theme.dart";
import "package:pocket_pal/const/light_theme.dart";


void main(){

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create : (context) => ThemeManager()
        ),

        ChangeNotifierProvider(
          create : (context) => SettingsProvider()
        ),
      ],

      child : const PocketPalApp()
    )
  );
  
  return;
}

class PocketPalApp extends StatelessWidget{
  const PocketPalApp({ super.key });

  @override
  Widget build(BuildContext context){

    final theme = context.watch<ThemeManager>().getTheme;
    final wSettings = context.watch<SettingsProvider>();

    final bool firstInstall = wSettings.getFirstInstall;
    
    return MaterialApp(
      title : "Pocket Pal",
      debugShowCheckedModeBanner: false,

      theme : lightTheme,
      darkTheme: darkTheme,
      themeMode : theme, 

      home : (firstInstall) ? 
        const OnboardView() : 
        const DashboardView()

      
    );
  }
}