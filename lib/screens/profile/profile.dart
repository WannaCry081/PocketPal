import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/screens/profile/widgets/overview_widget.dart";
import "package:pocket_pal/screens/profile/widgets/profile_widget.dart";
import "package:pocket_pal/widgets/pocket_pal_menu_button.dart";


class ProfileView extends StatelessWidget {
  const ProfileView({ super.key });

  @override
  Widget build(BuildContext context){

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF9F8FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const PocketPalMenuButton(),
        title: const Text("Profile")
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -20,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/svg/profile_page_bg.svg",
              fit: BoxFit.fitHeight),
          ),

          Align(
            child: Container(
                width: screenWidth - 80,
                height: 375,
                decoration: BoxDecoration(
                  color: ColorPalette.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(1, 4),
                        spreadRadius: 0,
                        blurRadius: 4,
                        color: ColorPalette.black!.withOpacity(0.25),
                    )
                  ]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyProfileWidget(
                      profileName: "Shiela Mae Lepon",
                      nickname: "shielamae_",
                      imagePath: "assets/images/Splash.png",
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    const MyProfileOverview(
                      folderNumber: 0, 
                      envelopeNumber: 0, 
                      groupNumber: 0),
                  ]
                )
            ),
          ),

          GestureDetector(
            onTap: (){},
            child: Positioned(
              bottom: (screenHeight / 2) - 250,
              child: Row(
                children: [
                  Icon(
                    FeatherIcons.edit3,
                    color: ColorPalette.rustic ),
                  const SizedBox (width: 10),
                  Text(
                    "Edit profile avatar",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: ColorPalette.rustic,
                      fontWeight: FontWeight.w600
                    )
                  ),
                ],
              )
            ),
          )
        ],
      )
    );
  }
}