import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:pocket_pal/const/color_palette.dart";


class MyFolderWidget extends StatelessWidget {
  final int? folderLength;
  final List? folderItems;
  final void Function() ? folderAddOnTap;
  final void Function() ? folderOnTap;
  final void Function() ? folderOnLongPress;

  const MyFolderWidget({ 
    super.key, 
    this.folderLength,
    this.folderItems,

    this.folderOnLongPress,
    this.folderOnTap,
    this.folderAddOnTap
  });

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding : EdgeInsets.symmetric(
          horizontal: 7.w
        ),
        child: Row(
          children: [
            for (int i=0; i<folderLength!+1;i++)
              GestureDetector(
                onTap : (i == (folderLength!-1)) ? 
                  folderOnTap :
                  folderAddOnTap,
                onLongPress: (i == (folderLength!-1)) ?
                  folderOnLongPress : 
                  null,
                child: Stack(
                  alignment : Alignment.center,
                  children : [  
                    SvgPicture.asset(
                      "assets/icon/Folder.svg",
                      width : 160.w,
                      height : 160.h
                    ),
                    
                    (i == (folderLength!-1))?
                      Positioned(
                        bottom : 30,
                        left : 25,
                        child : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children : [
                            Text(
                              "Title", 
                              style : GoogleFonts.montserrat(
                                fontSize : 14.sp,
                                fontWeight: FontWeight.w600
                              )
                            ),
                            Text(
                              "Description", 
                              style : GoogleFonts.montserrat(
                                fontSize : 12.sp,
                                fontWeight: FontWeight.w600,
                                color : ColorPalette.grey
                              )
                            ),
                          ]
                        )
                      )
                    : const Icon(
                      FeatherIcons.plusCircle,
                      size : 50
                    )
                    
                  ]
                ),
              )
          ]
        ),
      ),
    );
  }
}