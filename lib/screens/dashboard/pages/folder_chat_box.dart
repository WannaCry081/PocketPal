import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:image_picker/image_picker.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/screens/dashboard/widgets/bottom_edit_sheet.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/services/storage_service.dart";
import "package:pocket_pal/utils/chatbox_structure_util.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";


class FolderChatBox extends StatefulWidget {

  final Folder folder;

  const FolderChatBox({ 
    Key ? key,
    required this.folder
  }) : super(key : key);

  @override
  State<FolderChatBox> createState() => _FolderChatBoxState();
}

class _FolderChatBoxState extends State<FolderChatBox> {

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController(text : "");
  final _auth = PocketPalAuthentication();
  final _db = PocketPalDatabase();


  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
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
    final db = PocketPalDatabase();
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

      body : Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : [
          Expanded(
            child: _chatBoxConversation(db)
          ),

          _chatBoxTextField()
        ]
      )
    );
  }


  Widget _chatBoxConversation(PocketPalDatabase db){
    return StreamBuilder(
      stream : db.getMessages(widget.folder.folderId),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child : CircularProgressIndicator()
          );
        } else if (snapshot.hasData){
          
          final data = snapshot.data!;
          final itemList = data.map(
            (e) =>_chatBoxMessage(
              chatBoxOnLongPress : () => _showBottomSheet(e),
              chatBox : e
            )
          ).toList();
              
          return ListView.builder(
            controller: _scrollController,
            itemCount: itemList.length,
            itemBuilder: (context, index){
              return itemList[index];
            },
          );
                
        } else {
          return Center(
            child: Text(
              "No Available Conversation",
              style : GoogleFonts.poppins(
                fontSize : 14.sp
              )
            ),
          );
        }
      },
    );
  }
  


  Widget _chatBoxMessage({ required void Function() chatBoxOnLongPress, required ChatBox chatBox}){
    return GestureDetector(
      onLongPress : chatBoxOnLongPress,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 10.h 
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius : 20.r,
              backgroundImage: NetworkImage(
                chatBox.messageUserProfile
              ),
            ),
    
            SizedBox(width : 14.w),
            Expanded(
              child : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  
                  (chatBox.messageIsImage) ? 
                    Image.network(
                      chatBox.message,
                      height : 400.h

                    ): Text(
                    chatBox.message,
                    style : GoogleFonts.poppins()
                  )
                ],
              ) 
            )
          ],
        ),
      ),
    );
  }

  Widget _chatBoxTextField(){
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 10.h
      ),
      child: Row(
        children :[
          GestureDetector(
            onTap: _chatBoxSendImage,
            child: const Center(
              child : Icon(
                FeatherIcons.image
              )
            ),
          ),

          SizedBox(width : 14.w),
          Expanded(
            child: PocketPalFormField(
              // formKeyboardType: TextInputType.multiline,
              // formMaxLines: null,
              formController: _textController,
              formHintText: "Message",
              formSuffixIcon: IconButton(
                icon : const Icon(
                  FeatherIcons.send,
                ),
                onPressed: (){
                  if (_textController.text.isNotEmpty){

                    ChatBox chatBox = ChatBox(
                      messageIsImage: false,
                      messageUserName: _auth.getUserDisplayName, 
                      messageUserProfile: _auth.getUserPhotoUrl, 
                      message: _textController.text.trim()
                    );

                    _db.createMessage(
                      widget.folder.folderId, 
                      chatBox.toMap()
                    );

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

  void _showBottomSheet(ChatBox chatBox){
    showModalBottomSheet(
      context : context, 
      builder :(context) {
        return MyBottomEditSheetWidget(
          removeFunction: (){
            _db.deleteMessage(
              widget.folder.folderId,
              chatBox.messageId
            );
            Navigator.of(context).pop();
          },
        );
      },
    );
    return;
  }

  Future<void> _chatBoxSendImage() async {
    final newPicture = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );  

    if (newPicture != null){

      final storage = PocketPalStorage();

      ChatBox chatBox = ChatBox(
        messageUserName: _auth.getUserDisplayName, 
        messageUserProfile: _auth.getUserPhotoUrl, 
        message: newPicture.path,
        messageIsImage: true
      );

      String messageId = await _db.createMessage(
        widget.folder.folderId, 
        chatBox.toMap()
      );


      await storage.addImageToChatBox(
        File(newPicture.path), 
        widget.folder.folderId,
        messageId
      );

      chatBox.message = await storage.getImageUrlFromChatBox(
        widget.folder.folderId,
        messageId 
      );

      await _db.updateMessage(
        widget.folder.folderId, 
        messageId,
        chatBox.toMap()
      );

      _textController.clear();
    }      
    return;
  }
}