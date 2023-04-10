import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/screens/dashboard/widgets/card_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_title_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/search_bar_widget.dart";
import "package:pocket_pal/widgets/pocket_pal_menu_button.dart";


class DashboardView extends StatelessWidget {
  const DashboardView({ super.key });

  @override
  Widget build(BuildContext context){
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

              MyFolderWidget(
                folderLength: 1,
              ),

              MyFolderTitleWidget(
                folderTitleTopSize : 16.h, 
                folderTitleText: "Group Folder",
                folderTitleOnTap: _dashboardNavigateToGroup,
              ),
              MyFolderWidget(
                folderLength: 1,
              ),

              SizedBox( height : 20.h ),
            ]
          )
        )
      )
    );
  }

  void _dashboardNavigateToPersonal(){

    return;
  }


  void _dashboardNavigateToGroup(){

    return;
  }
}

