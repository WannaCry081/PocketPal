import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
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
        backgroundColor: Color(0xFFF9F8FD),
        leading: const PocketPalMenuButton(),
        title: const Text("Settings")
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SettingsContainerWidget(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
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
                  
                        const SizedBox( width: 15),
                  
                        Text(
                          "Dark Mode",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
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
        )
      )
    );
  }
}