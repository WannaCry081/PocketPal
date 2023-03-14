import "package:flutter/material.dart";
import "package:pocket_pal/screens/dashboard/widgets/bottom_edit_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/dialog_box_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_widget.dart";

import "package:pocket_pal/screens/dashboard/widgets/search_bar_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/card_widget.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";

import "package:pocket_pal/widgets/pocket_pal_menu_button.dart";

import "package:pocket_pal/const/color_palette.dart";

import "package:pocket_pal/services/dashboard_services.dart";

class DashboardView extends StatefulWidget {
  const DashboardView({ super.key });

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late final TextEditingController folderName;
  late final TextEditingController folderDescription;

  late List personalFolder;


  @override
  void initState(){
    super.initState();
    folderName = TextEditingController(text : "");
    folderDescription = TextEditingController(text : "");
    return; 
  }

  @override
  void dispose(){
    super.dispose();
    folderName.dispose();
    folderDescription.dispose();
    return; 
  } 

  void addFolder(String fieldName){
    final data = Folder(
      folderName: folderName.text.trim(), 
      folderDescription: folderDescription.text.trim()
    ).toMap();

    DashboardFirebaseService().addData(
      "user-wall",
      fieldName,
      data
    );  
    Navigator.of(context).pop();
    clearController();
    return;
  }

  void clearController(){
    folderName.clear();
    folderDescription.clear();
    return;
  }
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
                        fieldName: "Personal",
                        titleController : folderName,
                        descriptionController : folderDescription,
                        addFolderFunction: addFolder,
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
                        fieldName: "Group",
                        addFolderFunction:  addFolder,
                        titleController: folderName,
                        descriptionController: folderDescription,
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


