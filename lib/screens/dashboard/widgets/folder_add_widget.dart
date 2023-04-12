import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";


class MyFolderAddWidget extends StatelessWidget {
  final void Function() ? folderOnTap;

  const MyFolderAddWidget({ 
    super.key, 
    this.folderOnTap,
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap : folderOnTap, 
      child: Stack(
        alignment : Alignment.center,
        children : [  
          SvgPicture.asset(
            "assets/icon/Folder.svg",
            width : 70.w + 70.h,
            height : 70.h + 70.w
          ),
          
          Icon(
            FeatherIcons.plusCircle,
            size : 30.h + 30.w
          )
        ]
      ),  
    );
  }
}