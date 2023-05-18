import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:provider/provider.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:timezone/data/latest.dart" as tz;

import "package:pocket_pal/providers/chatbox_provider.dart";
import "package:pocket_pal/providers/envelope_provider.dart";
import "package:pocket_pal/providers/user_provider.dart";
import "package:pocket_pal/providers/wall_provider.dart";
import "package:pocket_pal/providers/settings_provider.dart";
import "package:pocket_pal/providers/folder_provider.dart";
import "package:pocket_pal/providers/event_provider.dart";

import "package:pocket_pal/screens/auth/pages/error_page.dart";
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

class PocketPalApp extends StatelessWidget {
  const PocketPalApp({ Key ? key }) : super(key : key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 640),
    );

    return MultiProvider(
      providers: [
        Consumer<SettingsProvider>(
          builder: (context, settingsProvider, child) => child!,
        ),
        Consumer<WallProvider>(
          builder: (context, wallProvider, child) => child!,
        ),
        Consumer<FolderProvider>(
          builder: (context, folderProvider, child) => child!,
        ),
        Consumer<EnvelopeProvider>(
          builder: (context, envelopeProvider, child) => child!,
        ),
        Consumer<EventProvider>(
          builder: (context, eventProvider, child) => child!,
        ),
        Consumer<UserProvider>(
          builder: (context, userProvider, child) => child!,
        ),
        Consumer<ChatBoxProvider>(
          builder: (context, chatBoxProvider, child) => child!,
        ),
      ],
      child : _appBuilder(context)
    );
  }

  Widget _appBuilder(BuildContext context){
    final SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title : "Pocket Pal",
      debugShowCheckedModeBanner: false,

      theme : lightTheme,
      darkTheme : darkTheme,

      themeMode : (settingsProvider.getBoolPreference("isLight")) ?  
        ThemeMode.light : 
        ThemeMode.dark,

      home : (settingsProvider.getHasWifi()) ? 
        const NoWifiPage() : 
        _homeBuilder(
          settingsProvider : settingsProvider
        )
    );
  }

  Widget _homeBuilder({ 
    required SettingsProvider settingsProvider
  }){
    return StreamBuilder<ConnectivityResult>(
      stream : settingsProvider.getConnectivityResult(),
      builder :(context, snapshot) {
        
        if (snapshot.data == ConnectivityResult.none){
          return const NoWifiPage();
        }

        else if (snapshot.hasError){
          return const ErrorPage();
        }

        else if (snapshot.hasData){
          return FutureBuilder(
            future : Firebase.initializeApp(),
            builder : (context, snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
                if (settingsProvider.getBoolPreference("isFirstInstall")) {
                  return const OnboardView();
                } else {
                  return const AuthViewBuilder();
                }
              } else {
                return const LoadingPage();
              }
            }
          );
        }
        
        else {
          return const LoadingPage();
        }
      },
    ); 
  }
}