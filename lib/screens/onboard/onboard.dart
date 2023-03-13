import "package:flutter/material.dart";
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

  late final PageController _pageController;

  final List _onboardItems = [
    [
      "assets/svg/screen_1.svg",
      "Manage finances \nconveniently",
      "Map out and organize your finances \nsmoohtly and easily."
    ],
    [
      "assets/svg/screen_2.svg",
      "Collaborate with \nyour peers",
      "Peer collaboration reinforces brainstorming \nof ideas for budget management."
    ],
    [
      "assets/svg/screen_3.svg",
      "Brainstorm and \nStrategize",
      "Collect ideas and assess financial \nstrategies together.",
    ]
  ];
  int _currentPage = 0;

  @override
  void initState(){
    super.initState();
    _pageController = PageController();
    return;
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
    return;
  }

  void onPageChanged(int value) => setState((){
    _currentPage = value;
  }); 

  @override
  Widget build(BuildContext context){

    final rSettings = context.read<SettingsProvider>();
    
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      body : SafeArea(
        child: Stack(
          alignment : Alignment.center,
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: onPageChanged,
              itemCount : _onboardItems.length,
              itemBuilder: (context, index){
                return Stack(
                  children: [
                    Positioned(
                      width : screenWidth,
                      height : screenHeight-(screenHeight * .18),
                      child: MyPageViewTileWidget(
                        pageViewTileImage: _onboardItems[index][0], 
                        pageViewTileTitle: _onboardItems[index][1], 
                        pageViewTileDescription: _onboardItems[index][2], 
                        screenHeight: screenHeight, 
                        screenWidth: screenWidth
                      ),
                    ),
                  ],
                );
              },
            ),
      
            Positioned(
              top : screenHeight * 0.02,
              right : (screenWidth * .06),
              height : screenHeight,
              child : GestureDetector(
                onTap: (){
                  rSettings.setFirstInstall = false;

                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder : (context) => const AuthView()
                    )
                  ); 
                },
                child : Text(
                  "skip",
                  textAlign : TextAlign.left,
                  style : GoogleFonts.poppins(
                    color : ColorPalette.grey,
                    fontSize : 18,
                    fontWeight : FontWeight.w500
                  )
                )
              )
            ),
        
            Positioned(
              bottom : 0,
              child: Column(
                children: [
                  PocketPalButton(
                    buttonWidth : screenWidth - (screenWidth * .1),
                    buttonHeight : screenHeight * .075,
                    buttonVerticalMargin: screenHeight * .04,
                    buttonHorizontalMargin: 20,
                    buttonColor: (_currentPage == 2) ? ColorPalette.rustic : ColorPalette.lightGrey,
                    buttonBorderRadius: 10,
                    buttonOnTap: (){
                      if (_currentPage == 2){
                        rSettings.setFirstInstall = false;
                        
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
                    buttonChild: Text(
                      (_currentPage == 2) ? "Get Started!" : "Next",
                      style : GoogleFonts.poppins(
                        color : (_currentPage == 2) ? ColorPalette.white : ColorPalette.black,
                        fontSize : 18,
                        fontWeight: FontWeight.w600
                      )
                    ),
                  ),
                  
                  SizedBox(
                    width : 66,
                    height : 12,
                    child: MyPageViewIndicatorWidget(
                      pageViewItemLength: _onboardItems.length,
                      pageViewCurrentPage : _currentPage,
                    ),
                  ),
                  SizedBox( height : screenHeight * .04)
                ],
              )
            )
          ],
        ),
      )
    );
  }


}