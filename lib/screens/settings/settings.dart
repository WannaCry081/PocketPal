import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/providers/settings_provider.dart";

import "package:pocket_pal/const/color_palette.dart";

import "package:pocket_pal/widgets/pocket_pal_menu_button.dart";
import "package:pocket_pal/screens/settings/widgets/container_widget.dart";
import "package:pocket_pal/screens/settings/widgets/settings_items_widget.dart";
import "package:pocket_pal/screens/settings/widgets/settings_header_widget.dart";


class SettingsView extends StatelessWidget {
  const SettingsView({ super.key });

  @override
  Widget build(BuildContext context){

    final rSettings = context.read<SettingsProvider>();
    final wSettings = context.watch<SettingsProvider>();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF9F8FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const PocketPalMenuButton(),
        title:  Text(
          "Settings",
          style: GoogleFonts.poppins(
            fontSize : 16.sp,
            color: ColorPalette.black,
          ),
        )
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox( height: 40.h,),
              SettingsContainerWidget(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.h, 
                    horizontal: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SettingsHeaderWidget(
                        headerName: "PROFILE"
                      ),
                        
                      SettingsItemsWidget(
                        prefixIcon: FeatherIcons.user,
                        itemName: "Change display name",
                        onTap: (){}
                      ),
                        
                      SizedBox( height: screenHeight * 0.035),
                        
                      const SettingsHeaderWidget(
                        headerName: "ACCOUNTS"
                      ),
                        
                      SettingsItemsWidget(
                        prefixIcon: FeatherIcons.lock,
                        itemName: "Change password",
                        onTap: (){}
                      ),
                      SettingsItemsWidget(
                        prefixIcon: FeatherIcons.trash2,
                        itemName: "Delete Account",
                        onTap: (){}
                      ),
                        
                      SizedBox( height: screenHeight * 0.035),
                        
                      const SettingsHeaderWidget(
                        headerName: "APP SETTINGS"
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children:[
                            const Icon(FeatherIcons.moon,
                              size: 26),
                            SizedBox( width: 15.w ),
                            Text(
                              "Dark Mode",
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                      
                            const Spacer(),
                      
                            Switch(
                              value: wSettings.getIsDarkTheme,
                              activeColor: ColorPalette.rustic,
                              onChanged: (value) => rSettings.setDarkTheme = value
                            )
                          ]
                        ),
                      ),
                        
                     SettingsItemsWidget(
                        prefixIcon: FeatherIcons.bell,
                        itemName: "Push Notifications",
                        onTap: (){}
                      ),
                    ],
                  ),
                )
              ),
            ],
          ),
        )
      )
    );
  }
}