import "package:flutter/material.dart";
import "package:pocket_pal/providers/envelope_provider.dart";
import "package:pocket_pal/providers/user_provider.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/utils/recent_tab_util.dart";
import "package:provider/provider.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";

import "package:pocket_pal/widgets/pocket_pal_folder.dart";
import "package:pocket_pal/widgets/pocket_pal_appbar.dart";

import 'package:pocket_pal/screens/dashboard/widgets/folder_bottom_edit_sheet.dart';
import "package:pocket_pal/screens/content/folder_content.dart";
import 'package:pocket_pal/screens/content/folder_grid.dart';
import "package:pocket_pal/screens/dashboard/widgets/dialog_box.dart";
import "package:pocket_pal/screens/dashboard/widgets/card_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/title_option.dart";

import 'package:pocket_pal/utils/folder_util.dart';
import "package:pocket_pal/providers/folder_provider.dart";


class DashboardView extends StatefulWidget {
  const DashboardView({ Key ? key }) : super(key : key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  final TextEditingController _folderNameController = TextEditingController(text : "");
  final db = PocketPalFirestore();

  @override
  void initState(){
    super.initState();
    Provider.of<FolderProvider>(context, listen : false).fetchFolder();
    Provider.of<UserProvider>(context, listen : false).fetchRecentTab();
  }

  @override
  void dispose(){
    super.dispose();
    _folderNameController.dispose();
    return;
  }

  @override
  Widget build(BuildContext context){
    return Consumer<FolderProvider>(
      builder: (context, folderProvider, child) {

        final List<Folder> folderList = folderProvider.getFolderList;

        return Consumer<EnvelopeProvider>(
          builder: (context, envelopeProvider, child) {

            return Consumer<UserProvider>(
              builder: (context, userProvider, child) {

                final List<Map<String, dynamic>> recentTabs = userProvider.getRecentTab;
                final int recentTabLength = recentTabs.length;

                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => 
                      _dashboardAddFolder(folderProvider),
                    backgroundColor: ColorPalette.crimsonRed,
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
                
                          const PocketPalAppBar(
                            pocketPalSearchButton: true,
                          ),
                
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
                            folderTitleText: "My Folders",
                            folderTitleOnTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder : (context) => const FolderGridPage()
                                )
                              );
                            },
                          ),
                
                          (folderList.isEmpty) ?
                            SizedBox(
                              height : 160.h + 30.w,
                              child : Center(
                                child : titleText(
                                  "No Folders Added",
                                )
                              )
                            ) :
                            _dashboardFolderView( 
                              folderProvider,
                              envelopeProvider,
                              userProvider),
                
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
                                Container(),
                                // GestureDetector(
                                //   onTap : (){},
                                //   child: bodyText(
                                //     "View all",
                                //     bodyWeight: FontWeight.w600,
                                //     bodySize : 14.sp,
                                //     bodyColor : ColorPalette.crimsonRed
                                //   ),
                                // )
                              ]
                            ),
                          ),

                            
                          for (int i = 0 ; i<recentTabLength; i++) ... [
                            ListTile(
                              title : titleText(
                                recentTabs[i]["itemName"]
                              ),
                            )
                          ]
                          
                        ]
                      ),
                    ),
                  )
                );
              }
            );
          }
        );
      }
    );
  }

  void _dashboardAddFolder(FolderProvider folderProvider){
    showDialog(
      context: context,
      builder: (context) {

        return MyDialogBoxWidget(
          controllerName: _folderNameController,
          dialogBoxConfirmMessage : "Create",
          dialogBoxHintText: "Untitled Folder",
          dialogBoxTitle: "Add Folder",
          dialogBoxErrorMessage: "Please enter a name for your Folder",
          dialogBoxOnCancel: (){
            _folderNameController.clear();
            Navigator.of(context).pop();
          },
          dialogBoxOnCreate: (){
            folderProvider.createFolder(
              Folder(
                folderName : _folderNameController.text.trim()
              ).toMap()
            );
            _folderNameController.clear();
            Navigator.of(context).pop();
          },
        );
      }
    );
    return;
  }

  Widget _dashboardFolderView(
    FolderProvider folderProvider, 
    EnvelopeProvider envelopeProvider,
    UserProvider userProvider){

    List<Folder> folderItem = folderProvider.getFolderList;
    int folderItemLength = folderItem.length;

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
                right : (i == ((folderItemLength < 10) ? folderItemLength-1 : 9)) ? 16.w : 0,
              ),
              child: PocketPalFolder(
                folder : folderItem[i],
                folderEditContents: () => _dashboardFolderEdit(
                  folderProvider,
                  folderItem[i]
                ),
                folderOpenContents: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder : (context) => FolderContentPage(
                        folder: folderItem[i]
                      )
                    )
                  ).then((value){
                    envelopeProvider.clearEnvelopeList();
                    userProvider.addTabItem(
                      RecentTabItem(
                        itemCategory: "Folder",
                        itemName: folderItem[i].folderName,
                        itemDocId: "",
                        itemDocName: folderItem[i].folderId,
                      ).toMap()
                    );
                  });
                },
              ),
            )
        ]
      ),
    );
  }

  void _dashboardFolderEdit(FolderProvider folderProvider, Folder folder){
    showModalBottomSheet(
      isDismissible: false,
      context: context, 
      builder: (context){
        return MyFolderBottomEditSheetWidget(
          folder : folder,
          bottomSheetOnDelete: (){
            folderProvider.deleteFolder(folder.folderId);
            Navigator.of(context).pop();
          },
          bottomSheetOnEdit: (){
            Navigator.of(context).pop();
            showDialog(
              context : context,
              builder : (context) {
                return MyDialogBoxWidget(
                  controllerName: _folderNameController,
                  dialogBoxHintText: folder.folderName,
                  dialogBoxConfirmMessage : "Rename",
                  dialogBoxTitle: "Rename Folder",
                  dialogBoxErrorMessage: "Please enter a name for your Folder",
                  dialogBoxOnCancel: (){
                    _folderNameController.clear();
                    Navigator.of(context).pop();
                  },
                  dialogBoxOnCreate: (){
                    folderProvider.updateFolder(
                      { "folderName" : _folderNameController.text.trim() },
                      folder.folderId
                    );
                    _folderNameController.clear();
                    Navigator.of(context).pop();
                  },
                );
              }
            );
          },
        );
      }
    );
  }
}

