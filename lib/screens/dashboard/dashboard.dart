import "package:flutter/material.dart";

import "package:pocket_pal/screens/dashboard/widgets/search_bar_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/card_widget.dart";

import "package:pocket_pal/widgets/pocket_pal_menu_button.dart";

import "package:pocket_pal/const/color_palette.dart";


class DashboardView extends StatelessWidget {
  const DashboardView({ super.key });

  @override
  Widget build(BuildContext context){

    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const PocketPalMenuButton(),
        title: const Text("")
      ),

      body : Padding(
        padding: EdgeInsets.symmetric(
          horizontal: (screenWidth * .1) /2 
        ),
        child: SingleChildScrollView(
          child: Column(
            children : [
              const MySearchBarWidget(),

              SizedBox(height : screenHeight * 0.04),
              MyCardWidget(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
              
            ]
          ),
        ),
      )
    );
  }
}


