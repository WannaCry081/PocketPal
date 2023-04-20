import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";



class MyBottomEditSheetWidget extends StatelessWidget { 
  
  final void Function() ? shareFunction;
  final void Function() ? renameFunction;
  final void Function() ? detailsFunction;
  final void Function() ? removeFunction;

  const MyBottomEditSheetWidget({ 
    super.key,
    this.shareFunction,
    this.renameFunction,
    this.detailsFunction,
    this.removeFunction,
  });

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
        mainAxisSize: MainAxisSize.min,
        children: [ 
          _bottomEditBarItem(
            title : "Share",
            icon : FeatherIcons.userPlus,
            function : shareFunction,
          ),
          _bottomEditBarItem(
            title : "Rename",
            icon : FeatherIcons.edit,
            function : renameFunction
          ),
          _bottomEditBarItem(
            title : "Details and activity",
            icon : FeatherIcons.info,
            function : detailsFunction
          ),
          _bottomEditBarItem(
            title : "Remove",
            icon : FeatherIcons.trash2,
            function : removeFunction 
          ),

          SizedBox (height : 10.h )
        ],
      ) 
    );
  }

  Widget _bottomEditBarItem({icon, title, void Function() ? function}){
    return Column(
      children: [
        GestureDetector(
          onTap : function,
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
        ),

        SizedBox( height : 14.h)
      ],
    );
  }
}