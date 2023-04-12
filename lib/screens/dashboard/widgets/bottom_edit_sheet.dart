import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";


class MyBottomEditSheetWidget extends StatelessWidget { 
  const MyBottomEditSheetWidget({ super.key });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding : EdgeInsets.only(
        top : 20.h,
        right : 26.w,
        left : 26.w,
        bottom : MediaQuery.of(context).viewInsets.bottom
      ),
      child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _bottomEditBarItem(
            icon : FeatherIcons.info,
            title : "Details"
          ),

          SizedBox(height : 16.h),

          _bottomEditBarItem(
            icon : FeatherIcons.edit,
            title : "Edit"
          ),

          SizedBox(height : 16.h),
          
          _bottomEditBarItem(
            icon : FeatherIcons.trash,
            title : "Delete",
            function : (){}
          ),

          SizedBox(height : 10.h)
        ],
      )
    );
  }

  Widget _bottomEditBarItem({icon, title, function}){
    return GestureDetector(
      onTap : (){},
      child : Row(
        crossAxisAlignment : CrossAxisAlignment.center,
        children : [
          Icon(
            icon
          ),

          SizedBox( width : 16.w),

          Text(
            title,
            style : GoogleFonts.montserrat(
              fontSize : 14.sp,
              fontWeight : FontWeight.w500
            )
          )
        ]
      )
    );
  }
}