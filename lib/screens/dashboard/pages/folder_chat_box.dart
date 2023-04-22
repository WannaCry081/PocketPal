import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";


class FolderChatBox extends StatelessWidget {

  final String folderChatBoxName;

  const FolderChatBox({ 
    Key ? key,
    required this.folderChatBoxName
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        title : Text(
          "$folderChatBoxName's ChatBox",
          style : GoogleFonts.poppins(
            fontSize : 16.sp
          ),
        ),
        actions: [
          IconButton(
            icon : Icon(
              FeatherIcons.info,
              color : Colors.black
            ),
            onPressed: (){
            },
          )
        ],
      ),

      body : Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : [
          Expanded(
            child: SingleChildScrollView(
              child : Column(
                children : [
                  _chatBoxMessage(),
                  _chatBoxMessage(),
                  _chatBoxMessage(),
                  _chatBoxMessage(),
                  _chatBoxMessage(),
                  _chatBoxMessage(),
                ]
              )
            ),
          ),

          _chatBoxTextField()
        ]
      )
    );
  }

  Widget _chatBoxMessage(){
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 10.h 
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(),

          SizedBox(width : 14.w),
          Expanded(
            child : Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children : [
                    Text(
                      "Lirae Que Data",
                      style : GoogleFonts.poppins(
                        fontWeight : FontWeight.w600,
                        fontSize : 16.sp
                      )
                    ),

                    SizedBox( width : 10.w),
                    Text(
                      "01/29/2023 10:22PM",
                      style : GoogleFonts.poppins(
                        fontSize : 12.sp
                      )
                    )
                  ]
                ),

                Text(
                  "A quick brown fox jumps over the lazy dog, a quick brown fox jumps over the lazy dog" + 
                  "A quick brown fox jumps over the lazy dog, a quick brown fox jumps over the lazy dog" + 
                  "A quick brown fox jumps over the lazy dog, a quick brown fox jumps over the lazy dog" 
                ),
              ],
            ) 
          )
        ],
      ),
    );
  }
  Widget _chatBoxTextField(){
    return Container(
      color : Color.fromARGB(255, 241, 241, 241),
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 10.h
      ),
      child: Row(
        children :[
          Container(
            child : Center(
              child : Icon(Icons.add_rounded)
            )
          ),

          SizedBox(width : 14.w),
          Expanded(
            child: TextField()
          )
        ]
      ),
    );
  }
}