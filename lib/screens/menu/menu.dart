import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/services/authentication_service.dart";

import "package:pocket_pal/screens/menu/widgets/logout_button_widget.dart";
import "package:pocket_pal/screens/menu/widgets/profile_widget.dart";

import "package:pocket_pal/utils/menu_item_util.dart";


import "package:pocket_pal/const/color_palette.dart";

class MenuItems {
  static const home = MenuItem(
      "Dashboard", 
      FeatherIcons.home
  );
  static const profile = MenuItem(
      "Profile", 
      FeatherIcons.user,
  );
  static const settings =  MenuItem(
      "Settings",
      FeatherIcons.settings,
  );

  static const all = <MenuItem>[
    home, 
    profile,
    settings
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

    //final menuItems = context.read<MenuScreenProvider>().getPocketPalMenuItems;

    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;

    return Scaffold(
      backgroundColor: ColorPalette.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.08),
              
              // MyProfileWidget(
              //   imagePath: FirebaseAuth.instance.currentUser!.photoURL!, 
              //   profileName: FirebaseAuth.instance.currentUser!.email!, 
              //   nickname: FirebaseAuth.instance.currentUser!.displayName!, 
              // ),
            
              SizedBox(
                height: screenHeight * 0.08,
                child: Divider(
                  color: ColorPalette.lightGrey,
                  thickness: 0.8,
                ),
              ),
            
              ...MenuItems.all.map(buildMenuItem).toList(),

              const Spacer(),
              GestureDetector(
                onTap : _userLogout,
                child: const MyLogoutButtonWidget()
              ),
              SizedBox(height: screenHeight * 0.05,),
            ],
          ),
        ),  
      )
    );

  }
  Future<void> _userLogout() async {
    await PocketPalAuthentication()
      .authenticationLogout(); 
    return;
  }

  Widget buildMenuItem(MenuItem item) => ListTileTheme(
    child: ListTile(
      leading: Icon(item.icon,
          color: ColorPalette.white,
          size: 26),
      title: Text(item.title,
        style: GoogleFonts.poppins(
            fontSize: 18,
            color: ColorPalette.white,
            fontWeight: FontWeight.w600
          ),),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      selectedTileColor: ColorPalette.rustic,
      minLeadingWidth: 35,
      selected: currentItem == item,
      onTap: () => onSelectedItem(item),
    ),
    );
}