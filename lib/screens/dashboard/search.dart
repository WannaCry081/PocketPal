import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
  const SearchView({
    super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String searchText = "";
  FocusNode _textFieldFocus = FocusNode();
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState(){
    _textEditingController = TextEditingController(text: ""); 
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _textFieldFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final FolderProvider folderProvider = context.watch<FolderProvider>();
    // final List<Folder> folderItem = folderProvider.getFolderList;

    final EnvelopeProvider envelopeProvider = context.watch<EnvelopeProvider>();
    // final List<Envelope> envelopeItem = envelopeProvider.getEnvelopeList;


    return Scaffold();
  //     appBar: AppBar(
  //       title: Card(
  //         child: TextField(
  //           controller: _textEditingController,
  //           decoration:  InputDecoration(
  //             border: InputBorder.none,
  //             fillColor: ColorPalette.pearlWhite,
  //             filled: true,
  //             enabledBorder: OutlineInputBorder(
  //                 borderSide: BorderSide.none, 
  //                 borderRadius: BorderRadius.circular(12.0),
  //             ),
  //             focusedBorder: OutlineInputBorder(
  //                 borderSide: BorderSide.none, 
  //                 borderRadius: BorderRadius.circular(12.0),
  //             ),
  //             prefixIcon: Icon(
  //               FeatherIcons.search,
  //               color: ColorPalette.grey
  //               ),
  //             hintText: "Search",
  //             hintStyle: GoogleFonts.lato(
  //               color: ColorPalette.grey
  //             ),
  //             suffix: GestureDetector(
  //               child: Icon(FeatherIcons.x),
  //               onTap: (){
  //                 setState(() {
  //                    _textFieldFocus.unfocus();
  //                   _textEditingController.clear();
  //                   searchText = "";
  //                 });
  //               },
  //               )
  //           ),
  //           onChanged: (value){
  //             setState(() {
  //               searchText = value;
  //             });
  //           },
  //         ),
  //       )
  //     ),

  //     body: Padding(
  //       padding: EdgeInsets.symmetric( horizontal: 14.w),
  //       child: 
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox( height: 20.h),
  //           titleText(
  //             "FOLDERS",
  //             titleColor: ColorPalette.salmonPink,
  //             titleSize: 16.sp,
  //             titleWeight: FontWeight.w400
  //           ),
  //           Flexible(
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: folderItem.length,
  //               itemBuilder: (context, index){
  //                 Folder folder = folderItem[index];
                  
  //                 if(searchText.isEmpty){
  //                   return folderListTile(folder);
  //                 }
  //                 if(folder.folderName.toString().toLowerCase().contains(searchText.toLowerCase())){
  //                   return folderListTile(folder);
  //                 }
  //                 return Container();
  //               }),
  //           ),
            
  //           Divider(
  //             height: 20.h,
  //             color: ColorPalette.lightGrey,
  //             thickness: 1,
  //           ),
  //           SizedBox( height: 15.h),
  //           titleText(
  //             "ENVELOPES",
  //             titleColor: ColorPalette.salmonPink,
  //             titleSize: 16.sp,
  //             titleWeight: FontWeight.w400
  //           ),
  //           Flexible(
  //             child: ListView.builder(
  //               shrinkWrap: true,
  //               itemCount: envelopeItem.length,
  //               itemBuilder: (context, index){
  //                 Envelope envelope =  envelopeProvider.getEnvelopeList[index];
  //                  if(searchText.isEmpty){
  //                   return envelopeListTile(envelope, folderItem[index]);
  //                 }
  //                 if(envelope.envelopeName.toString().toLowerCase().contains(searchText.toLowerCase())){
  //                   return envelopeListTile(envelope, folderItem[index]);
  //                 }
  //                 return Container();
  //           }))
  //         ],
  //       ),
  //     ),
  //   );
  // }


  // Widget folderListTile(Folder folder){
  //   return ListTile(
  //     leading: const Icon(FeatherIcons.folder),
  //     title: bodyText(
  //       folder.folderName,
  //       bodySize: 16.sp
  //     ),
  //     onTap:  (){
  //     Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder : (context) => FolderContentPage(
  //           folder: folder,
  //         )
  //       )
  //     );
  //   },
  // );
  }

  Widget envelopeListTile(Envelope envelope, Folder folder){
    // return ListTile(
    //   onTap:  (){
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder : (context) => EnvelopeContentPage(
    //         folder: folder,
    //         envelope: envelope,

    //       )
    //     )
    //   );
    // },
    //   leading: const Icon(FeatherIcons.fileMinus),
    //   title: bodyText(
    //     envelope.envelopeName,
    //     bodySize: 16.sp
    //   ),
    // ); 
    return Container();
  }
}