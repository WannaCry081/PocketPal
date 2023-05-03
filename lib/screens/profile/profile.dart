import "dart:async";
import "dart:io";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:image_picker/image_picker.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/screens/profile/widgets/overview_widget.dart";
import "package:pocket_pal/screens/profile/widgets/profile_widget.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/services/storage_service.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";
import "package:pocket_pal/widgets/pocket_pal_menu_button.dart";


class ProfileView extends StatefulWidget {

  const ProfileView({ 
    super.key });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  
  
  @override
  Widget build(BuildContext context){

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final auth = PocketPalAuthentication();

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFFF9F8FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const PocketPalMenuButton(),
        title:  Text(
          "Profile",
           style: GoogleFonts.poppins(
              fontSize : 18.sp,
              color: ColorPalette.black,
          ),
        )
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: -50,
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
                    MyProfileWidget(
                      profilePicture: auth.getUserPhotoUrl, 
                      profileName: auth.getUserDisplayName, 
                      profileEmail: auth.getUserEmail, 
                    ),
                    SizedBox(height: screenHeight * 0.03),
                     MyProfileOverview(
                      folderNumber: 0, 
                      envelopeNumber: 0, 
                      groupNumber: 0)
                  ]
                )
            ),
          ),
          Positioned(
            bottom: (screenHeight / 2) - 250,
            child: GestureDetector(
              onTap: _profilePageUpdateProfilePicture,
              child: Row(
                children: [
                  Icon(
                    FeatherIcons.edit3,
                    color: ColorPalette.crimsonRed ),
                  SizedBox (width: 10.w),
                  Text(
                    "Edit profile avatar",
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      color: ColorPalette.crimsonRed,
                      fontWeight: FontWeight.w600
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Future<void> _profilePageUpdateProfilePicture() async {
    final newPicture = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );  

    if (newPicture != null){
      final storage = PocketPalStorage();

      await storage.addImageToStorage(
        File(newPicture.path)
      );
      
      await PocketPalAuthentication().authenticationUpdateProfile(
        await storage.getImageUrl()
      );
      setState((){});
    }      
    return;
  }
  





}

 
