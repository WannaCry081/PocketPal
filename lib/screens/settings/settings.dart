import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/screens/auth/auth_builder.dart";
import "package:pocket_pal/screens/settings/pages/change_display_name.dart";
import "package:pocket_pal/screens/settings/pages/change_password.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/widgets/pocket_pal_dialog_box.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/providers/settings_provider.dart";

import "package:pocket_pal/const/color_palette.dart";

import "package:pocket_pal/widgets/pocket_pal_menu_button.dart";


class SettingsView extends StatefulWidget {
  const SettingsView({ super.key });

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context){

    final auth = PocketPalAuthentication();

    final rSettings = context.read<SettingsProvider>();
    final wSettings = context.watch<SettingsProvider>();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const PocketPalMenuButton(),
        title:  titleText(
          "Settings",
          titleSize: 18.sp,
        )
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox( height: screenHeight * 0.05),
                Container(height: 500, 
                    width: screenWidth - (screenWidth * 0.10),
                    padding: EdgeInsets.only(
                      top : 10.h,
                      left: 14.w,
                      right: 14.w
                    ),
                    //margin: const EdgeInsets.only (top: 45.0),
                    decoration: BoxDecoration(
                      color: ColorPalette.white,
                      border: Border.all(
                        color: ColorPalette.lightGrey!,
                        width: 0.5
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                            blurRadius: 4,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                        )
                      ]
                    ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h, 
                      horizontal: 14.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        settingsHeader("PROFILE"),
                        settingsItem(
                          FeatherIcons.user, 
                        "Change display name", 
                        (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder : (context) => const ChangeDisplayNameView()
                              )
                            );
                          }
                        ),
                        SizedBox( height: screenHeight * 0.035),
                        settingsHeader("ACCOUNTS"),
                        settingsItem(
                          FeatherIcons.lock, 
                          "Change password", 
                          (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder : (context) => const ChangePasswordView()
                              )
                            );
                          }
                        ),
                        settingsItem(
                          FeatherIcons.trash2, 
                          "Delete account", 
                          (){
                            showDialog(
                              context: context, 
                              builder: (context){
                                return PocketPalDialogBox(
                                pocketPalDialogTitle: "Confirm Deletion",
                                pocketPalDialogContent: bodyText(
                                  "Are you sure you want to delete your account?",
                                  bodySize: 15.sp
                                ),
                                pocketPalDialogOption1: "No",
                                pocketPalDialogOption2: "Yes",
                                pocketPalDialogOption1OnTap: (){
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder : (context) => const AuthViewBuilder() 
                                    )
                                  );
                                }
                              );
                            });
                          }
                        ),
                        SizedBox( height: screenHeight * 0.035),
                        
                        settingsHeader("APP SETTINGS"),
                        settingsItemSwitch(
                          FeatherIcons.moon, 
                          "Dark Mode", 
                          wSettings.getIsLightMode, 
                          rSettings.setIsLightMode),
                        settingsItemSwitch(
                          FeatherIcons.bell, 
                          "Push notifications", 
                          false, 
                          rSettings.setIsLightMode //temp
                          ),
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        )
      )
    );
  }

  Widget settingsHeader (headerName) => 
  Column(
    children: [
      titleText(
        headerName,
        titleSize: 16.sp,
        titleColor: ColorPalette.grey,
        titleWeight: FontWeight.w500
      ),
    ],
  );

  Widget settingsItem (prefixIcon, itemName, onTap) =>
  Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children:[
            Icon(prefixIcon,
              size: 26),
            SizedBox( width: 15.w),
            titleText(
              itemName,
              titleSize: 16.sp,
              titleWeight: FontWeight.w500
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded,
              size: 24,
              color: ColorPalette.grey)
          ]
        ),
      ),
  );

  Widget settingsItemSwitch (prefixIcon, itemName, value, onChanged) =>
  Row(
    children:[
      Icon(
        prefixIcon,
        size: 26),
      SizedBox( width: 15.w ),
      titleText(
        itemName,
        titleSize: 16.sp,
        titleWeight: FontWeight.w500
      ),
      const Spacer(),
      Switch(
        value: value,
        activeColor: ColorPalette.crimsonRed,
        onChanged: onChanged,
      )
    ]
  );
}