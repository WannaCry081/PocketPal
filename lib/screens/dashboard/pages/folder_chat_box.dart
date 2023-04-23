import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_local_notifications/flutter_local_notifications.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/services/database_service.dart";
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
  


  Widget _chatBoxMessage({ required ChatBox chatBox}){
    return Padding(
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
                      "${chatBox.messageDate.month} ${chatBox.messageDate.day} ${chatBox.messageDate.year}",
                      style : GoogleFonts.poppins(
                        fontSize : 12.sp
                      )
                    )
                  ]
                ),

                Text(
                  chatBox.message
                ),
              ],
            ) 
          )
        ],
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
          Container(
            child : Center(
              child : Icon(
                FeatherIcons.image
              )
            )
          ),

          SizedBox(width : 14.w),
          Expanded(
            child: PocketPalFormField(
              formController: _textController,
              formHintText: "Message",
            )
          ),

           GestureDetector(
            onTap: (){
              if (_textController.text.isNotEmpty){
                final auth = PocketPalAuthentication();

                ChatBox chatBox = ChatBox(
                  messageUserName: auth.getUserDisplayName, 
                  messageUserProfile: auth.getUserPhotoUrl, 
                  message: _textController.text.trim()
                );

                PocketPalDatabase().createMessage(
                  widget.folder.folderId, 
                  chatBox.toMap()
                );

                _textController.clear();
              }
            },
             child: Container(
              child : Center(
                child : Icon(
                  FeatherIcons.send
                )
              )
            ),
           ),

        ]
      ),
    );
  }
}