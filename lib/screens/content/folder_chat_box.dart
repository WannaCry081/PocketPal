import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:image_picker/image_picker.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/providers/chatbox_provider.dart";
import "package:pocket_pal/services/authentication_service.dart";
import 'package:pocket_pal/utils/chatbox_util.dart';
import 'package:pocket_pal/utils/folder_util.dart';
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";
import "package:provider/provider.dart";


class FolderChatBox extends StatefulWidget {

  final Folder folder;
  final String ? code;

  const FolderChatBox({ 
    Key ? key,
    required this.folder,
    this.code
  }) : super(key : key);

  @override
  State<FolderChatBox> createState() => _FolderChatBoxState();
}

class _FolderChatBoxState extends State<FolderChatBox> {

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController(text : "");
  final _auth = PocketPalAuthentication();

  @override
  void initState() {
    super.initState();

    Provider.of<ChatBoxProvider>(context, listen : false).fetchConversation(
      widget.folder.folderId,
      code : widget.code
    );
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollListViewToBottom();

    });
    return;
  }

  Future<void> _scrollListViewToBottom() async {
    await Future.delayed(const Duration(milliseconds: 500 ));
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    return;
  }
  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
    _textController.dispose();
    return;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        title : Text(
          "${widget.folder.folderName}'s ChatBox",
          style : GoogleFonts.poppins(
            fontSize : 16.sp
          ),
        ),
        actions: [
          IconButton(
            icon : const Icon(
              FeatherIcons.info,
              color : Colors.black
            ),
            onPressed: (){
            },
          )
        ],
      ),

      body : Consumer<ChatBoxProvider>(
        builder: (context, chatBoxProvider, child) {

          final List<ChatBox> chatBoxItemList = chatBoxProvider.getChatConversation; 
          final int chatBoxItemLength = chatBoxItemList.length;

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount : chatBoxItemLength,
                  itemBuilder : (context, index){

                    if (index != chatBoxItemLength-1){
                      return _chatBoxMessage(
                        chatBoxOnLongPress: (){}, 
                        chatBox: chatBoxItemList[index], 
                        chatBoxIsAppend : (
                        !(
                            index == 0 ||
                            chatBoxItemList[index].messageUserName !=
                            chatBoxItemList[index - 1].messageUserName
                          )
                        )
                      );
                    } else {
                      return SizedBox( height : 22.h );
                    }
                      
                  }
                )
              ),
      
              _chatBoxTextField(
                chatBoxProvider
              )
            ]
          );
        }
      )
    );
  }

  Widget _chatBoxMessage({ 
    required void Function() chatBoxOnLongPress, 
    required ChatBox chatBox,
    required bool chatBoxIsAppend }){

    return GestureDetector(
      onLongPress : chatBoxOnLongPress,
      child: Padding(
        padding: EdgeInsets.only(
          right : 14.w,
          left : 14.w,
          top : (chatBoxIsAppend) ? 0 : 22.h ,
          bottom: 0
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            if (!chatBoxIsAppend) ... [
              SizedBox(
                width : 40.w,
                child: Center(
                  child: CircleAvatar(
                    radius : 20.r,
                    backgroundImage: NetworkImage(
                      chatBox.messageUserProfile
                    ),
                  ),
                ),
              ),
            ],
            
            SizedBox(width : (chatBoxIsAppend) ? 50.w : 10.w),

            Expanded(
              child : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  if (!chatBoxIsAppend) ... [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children : [
                        Text(
                          chatBox.messageUserName,
                          style : GoogleFonts.poppins(
                            fontWeight : FontWeight.w600,
                            fontSize : 16.sp
                          )
                        ),
      
                        SizedBox( width : 10.w),
                        Text(
                          "${chatBox.messageDate.month}/${chatBox.messageDate.day}/${chatBox.messageDate.year}",
                          style : GoogleFonts.poppins(
                            fontSize : 12.sp
                          )
                        )
                      ]
                    ),
                  ],
                  
                  (chatBox.messageIsImage) ? 
                    Image.network(
                      chatBox.message,
                      height : 400.h
                    ) : bodyText(
                    chatBox.message,
                    bodySize: 14.sp
                  )
                ],
              ) 
            )
          ],
        ),
      ),
    );
  }

  Widget _chatBoxTextField(ChatBoxProvider chatBoxProvider){
    return Container(
      color : ColorPalette.pearlWhite,
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 6.h
      ),
      child: Row(
        children :[
          GestureDetector(
            // onTap: _chatBoxSendImage,
            child: const Center(
              child : Icon(
                FeatherIcons.image
              )
            ),
          ),

          SizedBox(width : 14.w),
          Expanded(
            child: PocketPalFormField(
              formOnTap: _scrollListViewToBottom,

              formKeyboardType: TextInputType.multiline,
              formMaxLines: null,
              formController: _textController,
              formHintText: "Message",
              formSuffixIcon: IconButton(
                icon : const Icon(
                  FeatherIcons.send,
                ),
                onPressed: () async {
                  if (_textController.text.isNotEmpty) {
            
                    ChatBox chatBox = ChatBox(
                      messageIsImage: false,
                      messageUserName: _auth.getUserDisplayName, 
                      messageUserProfile: _auth.getUserPhotoUrl, 
                      message: _textController.text.trim()
                    );
            
                    await chatBoxProvider.sendMessage(
                      chatBox.toMap(), 
                      widget.folder.folderId,
                      code : widget.code
                    );
            
                    _scrollListViewToBottom();
                    _textController.clear();
                  }
                },
              ),
            )
          ),
        ]
      ),
    );
  }



  // Future<void> _chatBoxSendImage() async {
  //   final newPicture = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //   );  

  //   if (newPicture != null){

  //     final storage = PocketPalStorage();

  //     ChatBox chatBox = ChatBox(
  //       messageUserName: _auth.getUserDisplayName, 
  //       messageUserProfile: _auth.getUserPhotoUrl, 
  //       message: newPicture.path,
  //       messageIsImage: true
  //     );

  //     String messageId = await _db.createMessage(
  //       widget.folder.folderId, 
  //       chatBox.toMap()
  //     );


  //     await storage.addImageToChatBox(
  //       File(newPicture.path), 
  //       widget.folder.folderId,
  //       messageId
  //     );

  //     chatBox.message = await storage.getImageUrlFromChatBox(
  //       widget.folder.folderId,
  //       messageId 
  //     );

  //     await _db.updateMessage(
  //       widget.folder.folderId, 
  //       messageId,
  //       chatBox.toMap()
  //     );

  //     _textController.clear();
  //   }      
  //   return;
  // }
}