import "package:flutter/material.dart";
import "package:pocket_pal/screens/dashboard/widgets/bottom_edit_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/dialog_box_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_widget.dart";

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
              

              SizedBox(height : screenHeight * 0.06),
              MyFolderWidget(
                folderName: "Personal Folder", 
                screenHeight: screenHeight, 
                screenWidth: screenWidth, 
                folderLength: 4, 
                folderItem: [
                  ["Title", "Description"],
                  ["Title", "Description"],
                  ["Title", "Description"],
                  ["Title", "Description"]
                ], 
                folderAdd: (){
                  showDialog(
                    context : context,
                    builder : (context){
                      return MyDialogBoxWidget(
                        screenHeight : screenHeight,
                        screenWidth : screenWidth
                      );
                    }
                  );

                  
                }, 
                folderEdit: (){
                  showModalBottomSheet(
                    context: context, 
                    builder: (context){
                      return MyBottomEditWidget(
                        screenHeight : screenHeight,
                        screenWidth : screenWidth
                      );
                    }
                  );
                }, 
                folderOpen: (){
                  
                }
              ),

              SizedBox(height : screenHeight * 0.02),
              MyFolderWidget(
                folderName: "Group Folder", 
                screenHeight: screenHeight, 
                screenWidth: screenWidth, 
                folderLength: 4, 
                folderItem: [
                  ["Title", "Description"],
                  ["Title", "Description"],
                  ["Title", "Description"],
                  ["Title", "Description"]
                ], 
                folderAdd: (){
                  showDialog(
                    context : context,
                    builder : (context){
                      return MyDialogBoxWidget(
                        screenHeight : screenHeight,
                        screenWidth : screenWidth
                      );
                    }
                  );
                }, 
                folderEdit: (){
                  showModalBottomSheet(
                    context: context, 
                    builder: (context){
                      return MyBottomEditWidget(
                        screenHeight : screenHeight,
                        screenWidth : screenWidth
                      );
                    }
                  );
                }, 
                folderOpen: (){


                }
              )

            ]
          ),
        ),
      )
    );
  }
}


