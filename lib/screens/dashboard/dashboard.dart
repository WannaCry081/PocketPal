import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/screens/dashboard/widgets/card_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/dialog_box.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_add_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_title_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/search_bar_widget.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";
import "package:pocket_pal/widgets/pocket_pal_menu_button.dart";


class DashboardView extends StatefulWidget {
  const DashboardView({ super.key });

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {

  
  final TextEditingController _folderName = TextEditingController(text : "");
  @override
  void dispose(){
    super.dispose();
    _folderName.dispose();
    return;
  }

  @override
  Widget build(BuildContext context){

    final db = PocketPalDatabase();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const PocketPalMenuButton(),
      ),
      body : SafeArea(
        child : SingleChildScrollView(
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children : [
              
              const MySearchBarWidget(),
              const MyCardWidget(),

              MyFolderTitleWidget(
                folderTitleTopSize: 28.h,
                folderTitleText: "Personal Folder",
                folderTitleOnTap: _dashboardNavigateToPersonal,
              ),

              _dashboardFolderView(db, false), 

              MyFolderTitleWidget(
                folderTitleTopSize : 16.h, 
                folderTitleText: "Group Folder",
                folderTitleOnTap: _dashboardNavigateToGroup,
              ),

              _dashboardFolderView(db, true), 

              SizedBox( height : 20.h ),
            ]
          )
        )
      )
    );
  }



  void _dashboardEditPersonalFolder() {
    
    return;
  }

  void _dashboardAddFolder(bool isShared){
    showDialog(
      context: context,
      builder: (context) {
        return MyDialogBoxWidget(
          folderName: _folderName,
          dialogBoxTitle: "Add Folder",
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

  void _dashboardNavigateSpecificPersonalFolder(){
    
    return;
  }

  void _dashboardEditGroupFolder() {

    return;
  }

  void _dashboardNavigateSpecificGroupFolder(){
    
    return;
  }

  void _dashboardNavigateToPersonal(){

    return;
  }

  void _dashboardNavigateToGroup(){

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
                  folderOnLongPress: _dashboardEditPersonalFolder,
                  folderOnTap : _dashboardNavigateSpecificPersonalFolder
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

