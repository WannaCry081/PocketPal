import "dart:async";

import "package:flutter/material.dart";
import "package:pocket_pal/providers/settings_provider.dart";
import "package:provider/provider.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/screens/auth/auth_builder.dart";
import "package:pocket_pal/screens/onboard/widgets/pageview_indicator_widget.dart";

import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/const/color_palette.dart";


class OnboardView extends StatefulWidget {
  const OnboardView({super.key});

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  
  final PageController _pageController = PageController();

  final _onboardItems = [
    [
      "assets/images/onboard_image1.jpg",
      "Track Your Finances\nAnywhere",
      "Track expenses and budgets on-the-go. Gain insights into your spending habits with ease."
    ],
    [
      "assets/images/onboard_image2.jpg",
      "Plan Your Expenses\nTogether",
      "Plan expenses together. Split costs, coordinate budgets and make the most of your money."
    ],
    [
      "assets/images/onboard_image3.jpg",
      "Perfect trip planning\nmade Easy", 
      "Create itineraries, find deals on flights and accommodations, and set budgets - all in one place."
    ],
    [
      "assets/images/onboard_image4.jpg",
      "Budget Your Way to\nAdventure",
      "Track expenses, set savings goals, and gain insights to make your travel dreams into reality."
    ],
  ];
  

  int _currentPage = 0;

  @override
  void initState(){
    super.initState();
    Timer.periodic(const Duration(seconds : 5), (timer) { 
      _pageController.animateToPage(
        ((_currentPage + 1) < _onboardItems.length) ? _currentPage + 1 : 0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linearToEaseOut
      );
    }); 
    return;
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
    return;
  }

  @override
  Widget build(BuildContext context) {
    
    final screenSize = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller : _pageController,
            onPageChanged: _onPageChanged,
            itemCount : _onboardItems.length,
            allowImplicitScrolling: true,
            itemBuilder : (context, index){
              return Stack(
                children : [
                  Image.asset(
                    _onboardItems[index][0],
                    fit: BoxFit.cover,
                    height : screenSize.height,
                  ), 

                  Container(
                    width : screenSize.width,
                    height : screenSize.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin : Alignment.bottomCenter,
                        end : Alignment.topCenter,
                        colors : [
                          Colors.black.withOpacity(.9),
                          Colors.black.withOpacity(.8),
                          Colors.black.withOpacity(.6),
                          Colors.black.withOpacity(.4),
                        ]
                      )
                    ),
                  ),
                ]
              );
            }
          ),


          Positioned(
            bottom : 0,
            child: SizedBox(
              width : screenSize.width, 
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children : [
                          
                    MyPageViewIndicatorWidget(
                      pageViewItemLength: _onboardItems.length, 
                      pageViewCurrentPage: _currentPage
                    ),

                    SizedBox(height : 26.h ),

                    titleText(
                      _onboardItems[_currentPage][1].toUpperCase(),
                      titleSize : 20.sp,
                      titleColor : Colors.white,
                      titleWeight : FontWeight.w700,
                    ),  

                    SizedBox(height : 8.h ), 
                
                    bodyText(
                      _onboardItems[_currentPage][2],
                      bodySize: 14.sp,
                      bodyColor : ColorPalette.grey
                    ),

                    SizedBox( height : 26.h ),
                    _onboardButton(),

                    SizedBox(height : 14.h) 
                  ]
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _onboardButton(){

    final wSettings = context.watch<SettingsProvider>();
    final rSettings = context.read<SettingsProvider>();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children : [
        titleText(
          "Start Saving Now!",
          titleSize : 16.sp,
          titleColor : ColorPalette.white,
          titleWeight : FontWeight.w500
        ),

        GestureDetector(
          onTap : (){

            if (wSettings.getShowOnboard){
              rSettings.setShowOnboard(
                !wSettings.getShowOnboard
              );
            }

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder : (context) =>const AuthViewBuilder()
              )
            );
          },
          child : Container(
            width : 54.w, 
            height : 54.h,
            decoration : BoxDecoration(
              color : ColorPalette.rustic, 
              borderRadius: BorderRadius.circular(20),
              boxShadow : [
                BoxShadow(
                  color : ColorPalette.murky,
                  blurRadius: 6
                )
              ]
            ),
            child : Center(
              child : Icon(
                FeatherIcons.arrowRight, 
                color : ColorPalette.white, 
                size: 26.sp,
              )
            )
          )
        )
      ]
    );
  }

  void _onPageChanged(int value) => setState(() {
    _currentPage = value;
  });
}