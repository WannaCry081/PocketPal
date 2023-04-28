import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:provider/provider.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/providers/folder_provider.dart";
import "package:pocket_pal/screens/dashboard/pages/folder_content.dart";
import "package:pocket_pal/screens/dashboard/pages/folder_grid.dart";
import "package:pocket_pal/screens/dashboard/widgets/bottom_edit_sheet.dart";
import "package:pocket_pal/screens/dashboard/widgets/dialog_box.dart";
import "package:pocket_pal/screens/dashboard/widgets/card_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_add_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/title_option.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/search_bar_widget.dart";

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

  final TextEditingController _folderName = TextEditingController(text : "");


  @override 
  void initState(){
    super.initState();
    Provider.of<FolderProvider>(
      context, 
      listen : false
    ).fetchFolder();
  }

  @override
  void dispose(){
    super.dispose();
    _folderName.dispose();
    return;
  }

  @override
  Widget build(BuildContext context){

    final folderProvider = Provider.of<FolderProvider>(context);
    final List<Folder> folderItem = folderProvider.getFolderList;
    final int folderItemLength = folderItem.length;

    return Scaffold(
      
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
        
              _dashboardCustomCardWidget(),

              SizedBox( height : 10.h), 
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 10.h
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [
                    titleText(
                      "My Wall",
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

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children : [
                    for (int i=0; i< 3; i++)
                      Container(
                        width : 140.w,
                        height : 180.h + 20.w,
                        margin : EdgeInsets.only(
                          left : 16.w,
                          top : 5.h,
                          bottom : 5.h,
                          right : (i == 2) ? 16.w : 0,
                        ),
                        decoration : BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r),
                          color : ColorPalette.rustic[50]
                        ),
                        child : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children : [

                            SvgPicture.asset(
                              "assets/icon/Folder.svg",
                              width : 90.h,
                              height : 90.h
                            ),

                            SizedBox( height : 8.h ), 

                            titleText(
                              "Design",
                              titleWeight: FontWeight.w600,
                              titleSize : 14.sp
                            ),

                            SizedBox( height : 2.h ), 
                            bodyText( 
                              "72 Envelopes",
                              bodySize : 12.sp,
                              bodyColor: ColorPalette.grey

                            )
                          ]
                        )
                      ),
                  ]
                ),
              ),

              SizedBox( height : 10.h), 
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


  Widget _dashboardCustomCardWidget() {
    return Container(
      height : 160.h,
      width : double.infinity,
      margin : EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color : ColorPalette.rustic
      ),
    );
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

  // =====================================================
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

 

  void _dashboardAddFolder(bool isShared){
    showDialog(
      context: context,
      builder: (context) {
        return MyDialogBoxWidget(
          controllerName: _folderName,
          dialogBoxHintText: "Untitled Wall",
          dialogBoxTitle: "Add Wall",
          dialogBoxErrorMessage: "Please enter a name for your Wall",
          dialogBoxOnTap: (){
 
            Folder folder = Folder(
              folderName: _folderName.text.trim(),
              folderIsShared: isShared
            );

            PocketPalDatabase().addFolder(
              folder.toMap()
            );

            _folderName.clear();
            Navigator.of(context).pop();
          },
        );
      }
    );
    return;
  }

  void _dashboardNavigateToFolder(Folder folder){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (context) => FolderContentPage(
          folder : folder
        )
      )
    );
    return;
  }

  void _dashboardNavigateToFolders(bool isShared){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (create) => FolderGridPage(
          isShared : isShared,
        )
      )
    );
    return;
  }


  Widget _dashboardFolderView(PocketPalDatabase db, bool isShared){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 7.w 
        ),
        child: StreamBuilder(
          stream: db.getFolder(),
          builder: (context, snapshot) {
            
            if (snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child : CircularProgressIndicator()
              );
            } else if (snapshot.hasData){
              
              final data = snapshot.data!;
              final itemList = data.where(
                (e) => e.folderIsShared == isShared
              ).map(
                (e) => MyFolderWidget(
                  folder: e,
                  folderOnLongPress: () => 
                    _dashboardEditFolder(e),
                  folderOnTap : () =>
                    _dashboardNavigateToFolder(e)
                )
              ).toList();
                    
              final itemLength = (itemList.length >= 10) ?
                10 : itemList.length;
                    
              return Row(
                children : [
                  for (int i=0; i<itemLength; i++)  
                    itemList[i],
                  
                  MyFolderAddWidget(
                    folderOnTap: () => 
                      _dashboardAddFolder(isShared),
                  )
                ]
              );
                    
            } else {
              return Row(
                children: [
                  MyFolderAddWidget(
                    folderOnTap: () => 
                      _dashboardAddFolder(isShared),
                  ),
                ],
              );
            }
          }
        ),
      ),
    );
  }
}

