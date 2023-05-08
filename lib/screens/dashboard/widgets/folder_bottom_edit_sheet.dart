import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_svg/flutter_svg.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/utils/folder_util.dart";


class MyFolderBottomEditSheetWidget extends StatelessWidget { 

  final Folder folder;
  final void Function() ? bottomSheetOnEdit;
  final void Function() ? bottomSheetOnDelete;

  const MyFolderBottomEditSheetWidget({ 
    Key ? key,
    required this.folder,
    this.bottomSheetOnEdit,
    this.bottomSheetOnDelete
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding : EdgeInsets.only(
        top : 4.h,
        right : 10.w,
        left : 10.w,
        bottom : MediaQuery.of(context).viewInsets.bottom
      ),
      child : Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 20.h
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [ 
            _bottomSheetAppBar(context),

            SizedBox( height : 10.h), 
            Divider(
              color : ColorPalette.midnightBlue
            ),
            SizedBox( height : 16.h), 
            _bottomSheetDetails(context),
            SizedBox( height : 16.h), 
            Divider(
              color : ColorPalette.midnightBlue
            ),
            _bottomSheetItem(
              context,
              FeatherIcons.edit,
              ColorPalette.black!,
              "Rename Folder",
              bottomSheetOnEdit
            ),
            _bottomSheetItem(
              context,
              FeatherIcons.trash2,
              ColorPalette.crimsonRed, 
              "Delete Folder",
              bottomSheetOnDelete
            ),
          ],
        ),
      ) 
    );
  }
  
  Widget _bottomSheetAppBar(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children : [
        titleText(
          "${folder.folderName} Folder",
          titleSize : 14.sp,
          titleWeight: FontWeight.w600,
        ),

        GestureDetector(
          onTap : () => Navigator.of(context).pop(),
          child : const Center(
            child: Icon(
              FeatherIcons.x
            ),
          )
        )
      ]
    );
  }

  Widget _bottomSheetDetails(BuildContext context){
    return Row(
      children: [
        Expanded(
          flex : 4,
          child : SvgPicture.asset(
            "assets/icon/Folder.svg",
          )
        ),

        Flexible(
          flex : 5,
          child : Padding(
            padding: EdgeInsets.only( left : 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children :[

                titleText(
                  "ID",
                  titleColor : ColorPalette.grey,
                  titleWeight : FontWeight.w600
                ),
                SizedBox(
                  width : 128.w,
                  child: bodyText(
                    folder.folderId,
                    bodySize : 12.sp 
                  ),
                ),

                SizedBox(height : 10.h ),
                titleText(
                  "Date Created",
                  titleColor : ColorPalette.grey,
                  titleWeight : FontWeight.w600
                ),
                bodyText(
                  "${folder.folderDate.month}/${folder.folderDate.day}/${folder.folderDate.year}",
                  bodySize : 12.sp
                ),

                SizedBox(height : 10.h ),
                titleText(
                  "Number of Envelope",
                  titleColor : ColorPalette.grey,
                  titleWeight : FontWeight.w600
                ),
                bodyText(
                  "${folder.folderNumberOfEnvelopes}",
                  bodySize : 12.sp
                ),
              ]
            ),
          )
        )
      ],
    );
  }

  Widget _bottomSheetItem(
    BuildContext context, 
    IconData icon, 
    Color colorChoice,
    String text,
    void Function() ? onTap
  ){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.h,
        horizontal: 16.w
      ),
      child: GestureDetector(
        onTap : onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children : [
            Icon(
              icon,
              color : colorChoice
            ),
    
            SizedBox( width : 14.w ),
            bodyText(
              text,
              bodySize : 16.sp,
              bodyColor : colorChoice
            )
          ]
        ),
      ),
    );
  }
}