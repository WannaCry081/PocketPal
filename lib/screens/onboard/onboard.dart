import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/const/color_palette.dart";
import 'package:pocket_pal/screens/onboard/widgets/pageview_indicator_widget.dart';
import "package:pocket_pal/screens/auth/auth.dart";

import "package:pocket_pal/providers/settings_provider.dart";

import "package:pocket_pal/widgets/pocket_pal_button.dart";

import "package:pocket_pal/screens/onboard/widgets/pageview_tile_widget.dart";


class OnboardView extends StatefulWidget {
  const OnboardView({ super.key });

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {

  final PageController _pageController = PageController();

  final List _onboardItems = [
    [
      "assets/svg/screen_1.svg",
      "Manage finances \nconveniently",
      "Map out and organize your finances\nsmoohtly and easily."
    ],
    [
      "assets/svg/screen_2.svg",
      "Collaborate with \nyour peers",
      "Peer collaboration improves budget\nmanagement brainstorming."
    ],
    [
      "assets/svg/screen_3.svg",
      "Brainstorm and \nStrategize",
      "Collect ideas and assess financial\nstrategies together.",
    ]
  ];

  int _currentPage = 0;

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
    return;
  }

  @override
  Widget build(BuildContext context){

    final rSettings = context.read<SettingsProvider>();
    
    return Scaffold(
      body : SafeArea(
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children : [
            Expanded(
              flex: 7,
              child : PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount : _onboardItems.length,
                itemBuilder : (context, index){
                  return MyPageViewTileWidget(
                    pageViewTileImage: _onboardItems[index][0], 
                    pageViewTileTitle: _onboardItems[index][1], 
                    pageViewTileDescription: _onboardItems[index][2], 
                  );
                }
              )
            ),

            Flexible(
              flex: 2,
              child : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w, 
                  vertical: 20.h
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    PocketPalButton(
                      buttonOnTap: (){
                        if (_currentPage == 2){
                          rSettings.setFirstInstall = false;
                          rSettings.setDefaultSettings();
                          
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder : (context) => const AuthView()
                            )
                          );
                        }
                    
                        _pageController.animateToPage(
                          _currentPage + 1, 
                          duration: const Duration( milliseconds: 300 ), 
                          curve: Curves.easeOutCubic
                        );
                      }, 
                      buttonWidth: double.infinity, 
                      buttonHeight: 55.h, 

                      buttonColor: (_currentPage == 2) ? 
                        ColorPalette.rustic : 
                        ColorPalette.lightGrey, 

                      buttonBorderRadius: 10, 
                      buttonChild: Text(
                        (_currentPage == 2) ? 
                          "Get Started!" : 
                          "Next",
                        style : GoogleFonts.poppins(
                          fontSize : 16.sp,
                          color : (_currentPage == 2) ? 
                            ColorPalette.white : 
                            ColorPalette.black,
                          fontWeight : FontWeight.w600
                        )
                      ),
                    ),

                    SizedBox( height : 16.h ), 
                    MyPageViewIndicatorWidget(
                      pageViewItemLength: _onboardItems.length, 
                      pageViewCurrentPage: _currentPage
                    )
                  ]
                ),
              )
            )
          ]
        )
      )
    );                  
  }

  void _onPageChanged(int value) => setState((){
    _currentPage = value;
  }); 
}