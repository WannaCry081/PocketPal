import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:pocket_pal/screens/auth/pages/loading_dart.dart";
import "package:provider/provider.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:firebase_messaging/firebase_messaging.dart";

import "package:pocket_pal/screens/auth/auth_builder.dart";
import "package:pocket_pal/screens/onboard/onboard.dart";

import "package:pocket_pal/providers/settings_provider.dart";

import "package:pocket_pal/const/dark_theme.dart";
import "package:pocket_pal/const/light_theme.dart";


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert  : true, 
          badge : true,
          sound : true
  );
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  );  

  runApp(
    MultiProvider(
      providers: [
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

    final wSettings = context.watch<SettingsProvider>();

    final bool firstInstall = wSettings.getFirstInstall;
    final bool isDark = wSettings.getIsDarkTheme;
    
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder : (context, child) => MaterialApp(
        title : "Pocket Pal",
        debugShowCheckedModeBanner: false,
    
        theme : lightTheme,
        darkTheme: darkTheme,

        themeMode : (isDark) ? 
          ThemeMode.dark : 
          ThemeMode.light, 
    
        home : (firstInstall) ? 
          const OnboardView() : 
          const AuthViewBuilder()
      ),
    );
  }
}