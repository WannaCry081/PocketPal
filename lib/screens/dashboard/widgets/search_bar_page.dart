import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/dashboard/pages/folder_content.dart';
import 'package:pocket_pal/screens/dashboard/widgets/folder_widget.dart';
import 'package:pocket_pal/screens/dashboard/widgets/search_items_tile.dart';
import 'package:pocket_pal/screens/envelope/envelope.dart';
import 'package:pocket_pal/services/authentication_service.dart';
import 'package:pocket_pal/services/database_service.dart';
import 'package:pocket_pal/utils/envelope_structure_util.dart';
import 'package:pocket_pal/utils/folder_structure_util.dart';

class MySearchBarPage extends StatefulWidget {
  final Folder ? folder;

  const MySearchBarPage({
    this.folder,
    super.key});

  @override
  State<MySearchBarPage> createState() => _MySearchBarPageState();
}

class _MySearchBarPageState extends State<MySearchBarPage> {
  @override
  Widget build(BuildContext context) {
    
    String keyword = "";
    final db = PocketPalDatabase();
    final screenWidth = MediaQuery.of(context).size.width;
    final userUid = PocketPalAuthentication().getUserUID;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                 contentPadding: EdgeInsets.symmetric(
                horizontal: 14.w,
                vertical : 16.h
              ),
              prefixIcon: Padding(
                padding:  EdgeInsets.only( left : 12.w),
                child: const Icon(
                  FeatherIcons.search
                ),
              ),
              suffixIcon: IconButton(
                icon: Icon(FeatherIcons.x),
                onPressed: (){
                   Navigator.pop(context);
                }
              ),
              filled: true,
              fillColor: ColorPalette.white,
              hintText: "Search Group | Wall | Envelope",
              hintStyle: GoogleFonts.poppins(
                fontSize : 14.sp,
                fontWeight: FontWeight.w500
              ),
              ),
              onChanged:(value) {
                setState(() {
                  keyword = value;
                });
              },
            ),

            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 20.h
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "FOLDERS", 
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        color: ColorPalette.grey,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    SizedBox(
                      width: screenWidth,
                      height: 500,
                      child: _dashboardFolderView(db)),
            
                  ],
                ),
              ),
            )

          ]
        )
      )
    );
  }

  Widget _dashboardFolderView(PocketPalDatabase db){
    return StreamBuilder(
      stream: db.getFolder(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child : CircularProgressIndicator()
          );
        } else if (snapshot.hasData){
          
          final data = snapshot.data!;
          final itemList = data.map(
            (e) => MySearchItemTile(
              folder: e,
              folderOnTap : () =>   
                _dashboardNavigateToFolder(e)
            )
          ).toList();
              
          return ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index){
              return itemList[index];
            },
          );
                
        } else {
          return Center(
            child: Text(
              "No Available Folder",
              style : GoogleFonts.poppins(
                fontSize : 14.sp
              )
            ),
          );
        }
      }
    );
  }

   void _dashboardNavigateToFolder(Folder folder){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (context) => FolderContentPage(
          folder : folder
        )
      )
    );
    return;
  }

  Widget _dashboardEnvelopeView(PocketPalDatabase db){
    return StreamBuilder(
      stream : db.getEnvelope(widget.folder!.folderId),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child : CircularProgressIndicator()
          );
        } else if (snapshot.hasData){
          
          final data = snapshot.data!;
          final itemList = data.map(
            (e) => MySearchItemTile(
              envelope: e,
              envelopeOnTap: () => 
                _dashboardNavigateToEnvelope(e),
            )
          ).toList();
              
          return ListView.builder(
            itemCount: itemList.length,
            itemBuilder: (context, index){
              return itemList[index];
            },
          );
                
        } else {
          return Center(
            child: Text(
              "No Available Envelope",
              style : GoogleFonts.poppins(
                fontSize : 14.sp
              )
            ),
          );
        }
      },
    );
  }

  void _dashboardNavigateToEnvelope(Envelope envelope){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (context) => EnvelopeContentPage(
          folder: widget.folder!,
          envelope : envelope
        )
      )
    );
    return;
  }
}