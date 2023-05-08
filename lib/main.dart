import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:pocket_pal/providers/envelope_provider.dart";
import "package:pocket_pal/providers/user_provider.dart";
import "package:pocket_pal/screens/auth/pages/loading_dart.dart";
import "package:pocket_pal/screens/onboard/onboard.dart";
import "package:provider/provider.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:timezone/data/latest.dart" as tz;

import "package:pocket_pal/screens/auth/auth_builder.dart";

import "package:pocket_pal/providers/settings_provider.dart";
import "package:pocket_pal/providers/folder_provider.dart";
import "package:pocket_pal/providers/event_provider.dart";

import "package:pocket_pal/const/dark_theme.dart";
import "package:pocket_pal/const/light_theme.dart";


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  );  

  runApp(
    MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create : (context) => EnvelopeProvider()
        ),

        ChangeNotifierProvider(
          create : (context) => FolderProvider()
        ),
        
        ChangeNotifierProvider(
          create : (context) => SettingsProvider()
        ),

        ChangeNotifierProvider(
          create : (context) => EventProvider()
        ),
        
        ChangeNotifierProvider(
          create : (context) => UserProvider() 
        )
      ],
      child : const PocketPalApp()
    )
  );
  
  return;
}
  
class PocketPalApp extends StatelessWidget {
  const PocketPalApp({ Key ? key }) : super(key : key);

  @override
  Widget build(BuildContext context){

    final SettingsProvider wSettings = context.watch<SettingsProvider>();
    final bool isLightMode = wSettings.getIsLightMode;
    final bool isFirstInstall = wSettings.getIsFirstInstall;

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder : (context, child) {
        return MaterialApp(
          title : "Pocket Pal",
          debugShowCheckedModeBanner: false,

          theme : lightTheme,
          darkTheme : darkTheme,

          themeMode : (isLightMode) ? 
            ThemeMode.light : 
            ThemeMode.dark,

          home : FutureBuilder(
            future : Firebase.initializeApp(),
            builder : (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (isFirstInstall) {
                  return const OnboardView();
                } else {
                  return const AuthViewBuilder();
                }
              } else {
                return const LoadingPage();
              }
            }
          )
        );
      }
    );
  }
}