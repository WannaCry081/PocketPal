import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:pocket_pal/providers/chatbox_provider.dart";
import "package:pocket_pal/screens/auth/pages/error_page.dart";
import "package:provider/provider.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:timezone/data/latest.dart" as tz;

import "package:pocket_pal/providers/envelope_provider.dart";
import "package:pocket_pal/providers/user_provider.dart";
import "package:pocket_pal/providers/wall_provider.dart";
import "package:pocket_pal/providers/settings_provider.dart";
import "package:pocket_pal/providers/folder_provider.dart";
import "package:pocket_pal/providers/event_provider.dart";

import "package:pocket_pal/screens/auth/pages/loading_dart.dart";
import "package:pocket_pal/screens/onboard/onboard.dart";
import "package:pocket_pal/screens/auth/auth_builder.dart";
import "package:pocket_pal/screens/auth/pages/no_wifi_page.dart";


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
          create : (context) => SettingsProvider()
        ),


        ChangeNotifierProvider(
          create : (context) => WallProvider()
        ), 

        ChangeNotifierProvider(
          create : (context) => FolderProvider()
        ),

        ChangeNotifierProvider(
          create : (context) => EnvelopeProvider()
        ),

        ChangeNotifierProvider(
          create : (context) => EventProvider()
        ),
        
        ChangeNotifierProvider(
          create : (context) => UserProvider() 
        ),

        ChangeNotifierProvider(
          create : (context) => ChatBoxProvider()
        )

      ],
      child : const PocketPalApp()
    )
  );
  
  return;
}

class PocketPalApp extends StatefulWidget {
  const PocketPalApp({Key? key}) : super(key: key);

  @override
  State<PocketPalApp> createState() => _PocketPalAppState();
}

class _PocketPalAppState extends State<PocketPalApp> {
  ConnectivityResult ? _connectivityResult; // Initialize the field

  @override
  void initState() {
    super.initState();
    _initializeConnectivity();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() => _connectivityResult = result );
    });
  }

  Future<void> _initializeConnectivity() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() => _connectivityResult = result );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) {
        return Consumer<SettingsProvider>(
          builder: (context, settingsProvider, child) {
            return MaterialApp(
              title: "Pocket Pal",
              debugShowCheckedModeBanner: false,

              theme: lightTheme,
              darkTheme: darkTheme,

              themeMode: settingsProvider.getIsLightMode? 
                ThemeMode.light : 
                ThemeMode.dark,

              home: _pocketPalAppHome(settingsProvider),
            );
          },
        );
      },
    );
  }

  Widget _pocketPalAppHome(SettingsProvider settingsProvider) {
    if (_connectivityResult == ConnectivityResult.none) {
      return const NoWifiPage();
    } else {
      return StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        initialData: _connectivityResult,

        builder: (context, snapshot) {
          final connectivityResult = snapshot.data;

          if (connectivityResult == ConnectivityResult.none) {
            return const NoWifiPage();

          } else if (snapshot.hasError){
            return const ErrorPage();
            
          } else if (snapshot.hasData) {

            return FutureBuilder(
              future: Firebase.initializeApp(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (settingsProvider.getIsFirstInstall) {
                    return const OnboardView();
                  } else {
                    return const AuthViewBuilder();
                  }
                } else {
                  return const LoadingPage();
                }
              },
            );
          } else {
            return const LoadingPage();
          }
        },
      );
    }
  }
}