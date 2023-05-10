import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/providers/folder_provider.dart";
import "package:pocket_pal/providers/user_provider.dart";
import "package:pocket_pal/services/authentication_service.dart";

import "package:pocket_pal/screens/menu/widgets/logout_button_widget.dart";
import "package:pocket_pal/screens/menu/widgets/profile_widget.dart";

import "package:pocket_pal/utils/menu_item_util.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/widgets/pocket_pal_dialog_box.dart";
import "package:provider/provider.dart";


class MenuItems {
  static const home = MenuItem(
      "Dashboard", 
      FeatherIcons.home
  );
  static const sharedFolders = MenuItem(
      "Shared Wall", 
      FeatherIcons.folderPlus
  );
  static const profile = MenuItem(
      "Profile", 
      FeatherIcons.user
  );
  static const calendar =  MenuItem(
      "Calendar",
      FeatherIcons.calendar
  );
  static const calculator =  MenuItem(
    "Calculator",
    FeatherIcons.plusSquare,
  );
  static const notifications = MenuItem(
    "Notifications",
    FeatherIcons.bell
  );
  static const settings =  MenuItem(
      "Settings",
      FeatherIcons.settings,
  );

  static const all = <MenuItem>[
    home, 
    sharedFolders,
    profile,
    calendar,
    calculator,
    notifications,
    settings,
  ];
}

class MenuView extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuView({
    super.key,
    required this.currentItem,
    required this.onSelectedItem
    });

  @override
  Widget build(BuildContext context) {
    final auth = PocketPalAuthentication();

    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        
        return Consumer<FolderProvider>(
          builder: (context, folderProvider, child) {

            return Scaffold(
              backgroundColor: ColorPalette.pearlWhite,
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 30.h
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyProfileWidget(
                        profilePicture: auth.getUserPhotoUrl,
                        profileName: auth.getUserDisplayName,
                        profileEmail: auth.getUserEmail,
                      ),
                    
                      SizedBox(
                        height: 40.h,
                        child: Divider(
                          color: ColorPalette.black,
                          thickness: 0.8,
                        ),
                      ),
                    
                      ...MenuItems.all.map(buildMenuItem).toList(),
            
                      const Spacer(),
                      GestureDetector(
                        onTap : (){
            
                          showDialog(
                            context : context, 
                            builder : (context) {
                              return PocketPalDialogBox(
                                pocketPalDialogTitle: "Confirm Logout", 
                                pocketPalDialogContent: bodyText(
                                  "Are you sure you want to Logout?",
                                  bodySize : 14.sp
                                ), 
                                pocketPalDialogOption1: "No", 
                                pocketPalDialogOption2: "Yes", 
                                pocketPalDialogOption1OnTap: (){
                                  Navigator.of(context).pop();
                                },
                                pocketPalDialogOption2OnTap: (){
                                  userProvider.clearUserWall();
                                  userProvider.clearRecentTab();
                                  folderProvider.clearFolderList();
                                  
                                  PocketPalAuthentication().authenticationLogout();
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          );
                        },
                        child: const MyLogoutButtonWidget()
                      ),
                    ],
                  ),
                ),  
              )
            );
          }
        );
      }
    );

  }

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
    child: ListTile(
      leading: Icon(item.icon,
          color: (currentItem != item)? 
               ColorPalette.black :
               ColorPalette.white,
          size: 20.w
        ),
      title: Text(item.title,
        style: GoogleFonts.poppins(
            fontSize: 14.sp,
            color: (currentItem != item)? 
               ColorPalette.black :
               ColorPalette.white,
            fontWeight: FontWeight.w600
          ),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      selectedTileColor: ColorPalette.crimsonRed,
      minLeadingWidth: 10.w,
      selected: currentItem == item,
      onTap: () => onSelectedItem(item),
    ),
  );
}