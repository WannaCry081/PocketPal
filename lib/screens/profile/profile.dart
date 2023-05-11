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
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/providers/folder_provider.dart";
import "package:pocket_pal/providers/user_provider.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/services/storage_service.dart";
import "package:pocket_pal/widgets/pocket_pal_appbar.dart";
import "package:provider/provider.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ProfileView extends StatefulWidget {

  const ProfileView({ 
    super.key });

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final db = PocketPalFirestore();

  @override
  void initState(){
    db.getTotalNumberOfEnvelopes();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context){

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final FolderProvider folderProvider = context.watch<FolderProvider>();
    final UserProvider userProvider = context.watch<UserProvider>();
    final auth = PocketPalAuthentication();

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFC8C2),
                Color.fromARGB(255, 255, 249, 249),
                ColorPalette.white!
              ]
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                SizedBox(
                  width : MediaQuery.of(context).size.width,
                  height : 50.h,
                  child: const PocketPalAppBar(
                    pocketPalTitle: "Profile",
                  )
                ),
                SizedBox(height: screenHeight*0.09.h,),
                Container(
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
                        myProfileContent(
                          auth.getUserPhotoUrl,
                          auth.getUserDisplayName, 
                          auth.getUserEmail,
                        ),
                        SizedBox(height: 10.h,),
                        SizedBox(
                          height: 60.h,
                          child: FutureBuilder<int>(
                            future: getTotalNumberOfEnvelopes(),
                            builder: (context, snapshot) {
                               final totalEnvelopes = snapshot.data ?? 0; 
                               if(snapshot.connectionState == ConnectionState.waiting){
                                return SpinKitThreeBounce(
                                  size: 40,
                                  color: ColorPalette.salmonPink,
                                );
                               }
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  overviewCountWidget(
                                    folderProvider.getFolderList.length,
                                    (folderProvider.getFolderList.length <=1 ) ? "folder" : "folders"),
                                  VerticalDivider(
                                    thickness: 2.5,
                                    color: ColorPalette.lightGrey,
                                    indent: 5,
                                    endIndent: 5,
                                    width: 45,
                                  ),
                                  overviewCountWidget("$totalEnvelopes", 
                                  (totalEnvelopes <= 1) ? "envelope":"envelopes"),
                                  VerticalDivider(
                                    thickness: 2.5,
                                    color: ColorPalette.lightGrey,
                                    indent: 5,
                                    endIndent: 5,
                                    width: 45,
                                  ),
                                  overviewCountWidget( 
                                    userProvider.getUserGroupWall.length,  
                                    (userProvider.getUserGroupWall.length <=1 )?"group" :"groups",),
                                ]
                              );
                            }
                          ),
                        )
                      ]
                    )
                ),
                 SizedBox( height: 30.h,),
                 GestureDetector(
                   onTap: _profilePageUpdateProfilePicture,
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(
                         FeatherIcons.edit3,
                         color: ColorPalette.crimsonRed ),
                       SizedBox (width: 10.w),
                       titleText(
                         "Edit profile avatar",
                         titleColor: ColorPalette.crimsonRed,
                         titleSize: 16.sp,
                         titleWeight: FontWeight.w600,
                       ),
                     ],
                   ),
                 ),
                ],
              ),
            ),
          )
        ),

        ],
      )
    );
  }

  Widget myProfileContent (
    profilePicture, profileName, profileEmail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: ColorPalette.midnightBlue,
          backgroundImage: NetworkImage(profilePicture),
        ),
        SizedBox(height: 20.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "$profileName\n",
                style: GoogleFonts.poppins(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.black,
                ),
              ),
              TextSpan(text: profileEmail)
            ],
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorPalette.grey,
              height: 1.5
            )
          ),
        ),
        SizedBox(height: 10.h,),
    ],
  );
}

  Widget overviewCountWidget (count, countTitle) =>
    RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "$count\n",
              style: GoogleFonts.poppins(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: ColorPalette.crimsonRed,
              )
            ),
            TextSpan(
              text: countTitle,
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: ColorPalette.grey
              )
            )
          ]
        ),
      );
  

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

  Future<int> getTotalNumberOfEnvelopes() async {
    final _db = FirebaseFirestore.instance;
    final String _userUid = PocketPalAuthentication().getUserUID;
    final folderDocs = _db.collection(_userUid).doc("$_userUid+Wall").collection(_userUid);

    num totalNumberOfEnvelopes = 0;
    final documentsSnapshot = await folderDocs.get();
    for (final docSnapshot in documentsSnapshot.docs) {
      final folderDoc = await docSnapshot.reference.get();
      final folderNumberOfEnvelopes = folderDoc.data()?["folderNumberOfEnvelopes"] ?? 0;
      totalNumberOfEnvelopes  += folderNumberOfEnvelopes;
    }
    return totalNumberOfEnvelopes.toInt();
  }

 
}