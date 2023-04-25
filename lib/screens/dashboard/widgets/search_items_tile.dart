import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/utils/envelope_structure_util.dart';
import 'package:pocket_pal/utils/folder_structure_util.dart';

class MySearchItemTile extends StatelessWidget {
  final Envelope ? envelope;
  final Folder ? folder;
  final void Function() ? folderOnTap;
  final void Function() ? envelopeOnTap;

  const MySearchItemTile({
    this.envelope,
    this.folder,
    this.folderOnTap,
    this.envelopeOnTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    if (envelope != null){
      return ListTile(
      onTap: envelopeOnTap,
      leading: Icon(Icons.folder),
      title: Text(
        (envelope!.envelopeName.length > 14) ? 
          "${envelope!.envelopeName.substring(0, 14)}..." : 
          envelope!.envelopeName,
        style : GoogleFonts.montserrat(
          fontSize : 14.sp,
          fontWeight: FontWeight.w600
        )
      )
    );
    } 

    if ( folder != null ){
      return ListTile(
      onTap: folderOnTap,
      leading: Icon(Icons.folder),
      title: Text(
        (folder!.folderName.length > 12) ? 
          "${folder!.folderName.substring(0, 12)}..." : 
          folder!.folderName, 
        style : GoogleFonts.montserrat(
          fontSize : 14.sp,
          fontWeight: FontWeight.w600
        )
      ),
    );
    }

    return Center(
      child: Text(
        "No Data Available"
      )
    );
    
  }
}