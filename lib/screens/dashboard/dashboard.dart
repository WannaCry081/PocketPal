import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/providers/folder_provider.dart";
import "package:pocket_pal/screens/dashboard/pages/folder_grid.dart";
import "package:pocket_pal/screens/dashboard/widgets/bottom_edit_sheet.dart";
import "package:pocket_pal/screens/dashboard/widgets/dialog_box.dart";
import "package:pocket_pal/screens/dashboard/widgets/card_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/title_option.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_widget.dart";

import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";
import "package:pocket_pal/widgets/pocket_pal_menu_button.dart";


class DashboardView extends StatefulWidget {
  const DashboardView({ 
    super.key });

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  final TextEditingController _folderNameController = TextEditingController(text : "");

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    Provider.of<FolderProvider>(
      context, 
      listen : true
    ).fetchFolder();
  } 

  @override
  void dispose(){
    super.dispose();
    _folderNameController.dispose();
    return;
  }

  @override
  Widget build(BuildContext context){

    final folderProvider = Provider.of<FolderProvider>(context);
    final List<Folder> folderItem = folderProvider.getFolderList;
    final int folderItemLength = folderItem.length;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _dashboardAddFolder,
        backgroundColor: ColorPalette.rustic,
        shape: const CircleBorder(),
        child : Icon(
          FeatherIcons.plus, 
          color : ColorPalette.white
        ),
      ),
      body : SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children : [
              
              _dashboardCustomAppBar(),
        
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 14.h
                ),
                child: titleText(
                  "Manage\nall your Expenses",
                  titleSize : 24.sp,
                  titleWeight: FontWeight.w600
                ),
              ),

              const MyCardWidget(),

              SizedBox( height : 10.h), 
              
              MyTitleOptionWidget(
                folderTitleText: "My Wall",
                folderTitleOnTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder : (context) => FolderGridPage(
                        folderNameController : _folderNameController,
                        folderAddOnTap : _dashboardAddFolder,
                      )
                    )
                  );
                },
              ),

              (folderItem.isEmpty) ?
                SizedBox(
                  height : 160.h + 20.w,
                  child : Center(
                    child : titleText(
                      "No Wall Added",
                    )
                  )
                ) :
                _dashboardFolderView(
                  folderItem: folderItem,
                  folderItemLength: folderItemLength
                ),

              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 10.h
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [
                    titleText(
                      "Recents",
                      titleWeight: FontWeight.w600,
                      titleSize : 16.sp
                    ),

                    GestureDetector(
                      onTap : (){},
                      child: bodyText(
                        "View all",
                        bodyWeight: FontWeight.w600,
                        bodySize : 14.sp,
                        bodyColor : ColorPalette.rustic
                      ),
                    )
                  ]
                ),
              ),
              
            ]
          ),
        ),
      )
    );
  }

  void _dashboardAddFolder(){
    showDialog(
      context: context,
      builder: (context) {
        return MyDialogBoxWidget(
          controllerName: _folderNameController,
          dialogBoxHintText: "Untitled Wall",
          dialogBoxTitle: "Add Wall",
          dialogBoxErrorMessage: "Please enter a name for your Wall",
          dialogBoxOnTap: (){
            Folder folder = Folder(
              folderName: _folderNameController.text.trim(),
            );

            PocketPalDatabase().addFolder(
              folder.toMap()
            );

            _folderNameController.clear();
            Navigator.of(context).pop();
          },
        );
      }
    );
    return;
  }

  Widget _dashboardCustomAppBar(){
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 6.h
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : [
          const PocketPalMenuButton(),

          GestureDetector(
            onTap : (){},
            child : CircleAvatar(
              radius: 20.r,
              backgroundColor: ColorPalette.lightGrey,
              child: Icon(
                FeatherIcons.search,
                color : ColorPalette.black
              ),
            )
          )         
        ]
      ),
    );
  }

  Widget _dashboardFolderView({ 
    required int folderItemLength,
    required List<Folder> folderItem
  }){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children : [
          for (int i=0; i<((folderItemLength > 10) ? 10 : folderItemLength); i++)
            Padding(
              padding : EdgeInsets.only(
                left : 16.w,
                top : 5.h,
                bottom : 5.h,
                right : (i == 2) ? 16.w : 0,
              ),
              child: MyFolderWidget(
                folder : folderItem[i] 
              ),
            )
        ]
      ),
    );
  }

  void _dashboardEditFolder(Folder folder) {
    showModalBottomSheet(
      context: context, 
      builder: (context){
        return MyBottomEditSheetWidget(
          removeFunction: (){
            PocketPalDatabase().deleteFolder(
              folder.folderId
            );
            Navigator.of(context).pop();
          },
        );
      }
    );
    return;
  }
}

