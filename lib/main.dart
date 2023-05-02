import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:pocket_pal/providers/envelope_provider.dart";
import "package:pocket_pal/screens/auth/pages/error_page.dart";
import "package:provider/provider.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:timezone/data/latest.dart" as tz;

import "package:pocket_pal/screens/auth/auth_builder.dart";
import "package:pocket_pal/screens/onboard/onboard.dart";

import "package:pocket_pal/providers/settings_provider.dart";
import "package:pocket_pal/providers/folder_provider.dart";

import "package:pocket_pal/const/dark_theme.dart";
import "package:pocket_pal/const/light_theme.dart";


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  await Firebase.initializeApp();
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

    final wSettings = context.watch<SettingsProvider>();

    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder : (context, child) {
        return MaterialApp(
          title : "Pocket Pal",
          debugShowCheckedModeBanner: false,

          theme : lightTheme,
          darkTheme : darkTheme,

          themeMode : (wSettings.getIsLight) ? 
            ThemeMode.light : 
            ThemeMode.dark,
          
          home :  FutureBuilder(
            future : Firebase.initializeApp(),
            builder : (context, snapshot) {
              if (snapshot.hasData){
                return (wSettings.getShowOnboard) ?
                  const OnboardView() :
                  const AuthViewBuilder();
              } else {
                return const ErrorPage();
              }
            }
          )
        );
      }
    );
  }
}