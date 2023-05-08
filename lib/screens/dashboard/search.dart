import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/providers/envelope_provider.dart';
import 'package:pocket_pal/providers/folder_provider.dart';
import 'package:pocket_pal/screens/content/folder_content.dart';
import 'package:pocket_pal/screens/envelope/envelope.dart';
import 'package:pocket_pal/utils/envelope_util.dart';
import 'package:pocket_pal/utils/folder_util.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {

    final FolderProvider folderProvider = context.watch<FolderProvider>();
    final List<Folder> folderItem = folderProvider.getFolderList;
    final int folderItemLength = folderItem.length;

    final EnvelopeProvider envelopeProvider = context.watch<EnvelopeProvider>();
    final List<Envelope> envelopeItem = envelopeProvider.getEnvelopeList;
    final int envelopeItemLength = envelopeItem.length;

    return Scaffold(
      appBar: AppBar(
        title: Card(
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(FeatherIcons.search),
              hintText: "Search"
            ),
            onChanged: (value){
              setState(() {
                searchText = value;
              });
            },
          ),
        )
      ),

      body: Padding(
        padding: EdgeInsets.symmetric( horizontal: 14.w),
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox( height: 20.h),
            titleText(
              "FOLDERS",
              titleColor: ColorPalette.salmonPink,
              titleSize: 16.sp,
              titleWeight: FontWeight.w400
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: folderItemLength,
                itemBuilder: (context, index){
                  Folder folder = folderItem[index];
                  
                  if(searchText.isEmpty){
                    return ListTile(
                      leading: const Icon(FeatherIcons.folder),
                      title: bodyText(
                        folder.folderName,
                        bodySize: 16.sp
                      ),
                      onTap:  (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder : (context) => FolderContentPage(
                            folder: folder,
                          )
                        )
                      );
                    },
                    );
                  }
                  if(folder.folderName.toString().toLowerCase().contains(searchText.toLowerCase())){
                    return ListTile(
                      leading: const Icon(FeatherIcons.folder),
                      title: bodyText(
                        folder.folderName,
                        bodySize: 16.sp
                      ),
                       onTap:  (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder : (context) => FolderContentPage(
                            folder: folder,
                          )
                        )
                      );
                    },
                    );
                  }
                  return Container();
                }),
            ),
            
            Divider(
              height: 20.h,
              color: ColorPalette.lightGrey,
              thickness: 1,
            ),
            SizedBox( height: 15.h),
            titleText(
              "ENVELOPES",
              titleColor: ColorPalette.salmonPink,
              titleSize: 16.sp,
              titleWeight: FontWeight.w400
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: envelopeItemLength,
                itemBuilder: (context, index){
                  Envelope envelope =  envelopeItem[index];
                   Folder folder = folderItem[index];
                   if(searchText.isEmpty){
                    return ListTile(
                      onTap:  (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder : (context) => EnvelopeContentPage(
                            folder: folder,
                            envelope: envelope,

                          )
                        )
                      );
                    },
                      leading: const Icon(FeatherIcons.fileMinus),
                      title: bodyText(
                        envelope.envelopeName,
                        bodySize: 16.sp
                      ),
                    ); 
                  }
                  if(envelope.envelopeName.toString().toLowerCase().contains(searchText.toLowerCase())){
                    return ListTile(
                      leading: const Icon(FeatherIcons.fileMinus),
                      title: bodyText(
                        envelope.envelopeName,
                        bodySize: 16.sp
                      ),
                    ); 
                  }
                  return Container();
                }))
          ],
        ),
      ),
    );
  }
}