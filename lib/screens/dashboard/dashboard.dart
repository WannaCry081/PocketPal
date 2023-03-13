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
      body : SafeArea(
        child : NestedScrollView(
          headerSliverBuilder :(context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                surfaceTintColor: ColorPalette.white,
                backgroundColor: ColorPalette.white,
                floating: false,
                pinned: true,

                title: const Padding(
                  padding:  EdgeInsets.all(10),
                  child: PocketPalMenuButton(),
                ),
                
                expandedHeight: 360,

                flexibleSpace: FlexibleSpaceBar(
                  background : Padding(
                    padding : EdgeInsets.only(
                      top : kToolbarHeight,
                      left : screenWidth * 0.06,
                      right : screenWidth * 0.06,
                    ),
                    child: Column(
                      children : [

                        const MySearchBarWidget(),

                        SizedBox( height : screenHeight * 0.03 ),

                        MyCardWidget(
                          screenHeight : screenHeight,
                          screenWidth : screenWidth
                        ),

                      ]
                    ),
                  )
                  
                ),
              )
            ];
          },
          body: Container(),
        )
      )
    );
  }
}


