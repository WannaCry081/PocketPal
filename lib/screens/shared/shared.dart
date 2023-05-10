import "package:flutter/material.dart";
import "package:pocket_pal/providers/folder_provider.dart";
import "package:pocket_pal/providers/wall_provider.dart";
import "package:provider/provider.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";

import 'package:pocket_pal/screens/content/folder_grid.dart';
import "package:pocket_pal/screens/shared/widgets/bottom_sheet_widget.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/utils/wall_util.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/widgets/pocket_pal_appbar.dart";

import "package:pocket_pal/providers/user_provider.dart";
import "package:pocket_pal/screens/shared/widgets/list_tile_widget.dart";


class SharedWallView extends StatefulWidget {
  const SharedWallView({ Key ? key}) : super(key : key);

  @override
  State<SharedWallView> createState() => _SharedWallViewState();
}

class _SharedWallViewState extends State<SharedWallView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController(text : "");
  final TextEditingController _nameController = TextEditingController(text : "");

  @override
  void initState(){
    super.initState();
    Provider.of<UserProvider>(context,listen: false).fetchUserCredential();
  }
  @override
  void dispose(){
    super.dispose();
    _codeController.dispose();
    _nameController.dispose();
    return;
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Consumer<WallProvider>(
          builder: (context, wallProvider, child) {
            return Consumer<FolderProvider>(
              builder: (context, folderProvider, child) {
                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => _sharedWallCreateGroup(
                      userProvider,
                      wallProvider
                    ), 
                    backgroundColor: ColorPalette.crimsonRed,
                    child : Icon(
                      FeatherIcons.plus,
                      color : ColorPalette.white
                    )
                  ),
                
                  body : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children : [
                          
                          const PocketPalAppBar(
                            pocketPalTitle: "Shared Wall",
                          ),
                
                          for (int i=0; i<userProvider.getUserWall.length ; i++)
                            MyListTileWidget(
                              listTileName : userProvider.getUserWall[i]["wallName"],
                              listTileCode : userProvider.getUserWall[i]["wallId"],
                              listTileWallOnDelete: (){
                                
                              },
                              listTileWallNavigation: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder : (context) => FolderGridPage(
                                      code : userProvider.getUserWall[i]["wallId"],
                                      wallName: userProvider.getUserWall[i]["wallName"],
                                    )
                                  )
                                ).then((value){
                                  folderProvider.clearFolderList();
                                });
                              },
                            )
                
                        ]
                      ),
                    ),
                  )
                );
              }
            );
          }
        );
      }
    );
  }

  void _sharedWallCreateGroup(UserProvider userProvider, WallProvider wallProvider){    
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      isDismissible: false,
      builder: (context){
        return MyBottomSheetWidget(
          formKey : _formKey, 
          nameController : _nameController,
          codeController : _codeController,
          bottomSheetOnCancel: (){
            _codeController.clear();
            _nameController.clear();
            Navigator.of(context).pop();
          },
          bottomSheetOnCreate: (){
            final auth = PocketPalAuthentication();
            if (_formKey.currentState!.validate()){
              _formKey.currentState!.save();

              final String code = _codeController.text.trim();
              final String name = _nameController.text.trim();

              final WallUser newMember = WallUser(
                wallUserName: auth.getUserDisplayName,
                wallUserEmail: auth.getUserEmail,
                wallUserProfile: auth.getUserPhotoUrl,
                wallUserAuthorizationKey: 1
              );

              final Wall data = Wall(
                wallId : code,
                wallName: name,
              );

              userProvider.getUserWall.add(data.toMap());
              userProvider.updateGroupCode( {"palGroupWall" : userProvider.getUserWall} );
              wallProvider.createGroupWall(
                data.toMap(), 
                code,
              );  

              wallProvider.getWallList.add(newMember.toMap());
              wallProvider.updateGroupWall(
                {"wallMembers" : wallProvider.getWallList},
                code, 
              );

              _codeController.clear();
              _nameController.clear();
              Navigator.of(context).pop();
            }
          },

          bottomSheetOnJoin : () {
            final auth = PocketPalAuthentication();

            if (_formKey.currentState!.validate()){
              _formKey.currentState!.save();

              final String code = _codeController.text.trim();
              final String name = _nameController.text.trim();
              
              wallProvider.fetchGroupWall(code);
              wallProvider.fetchGroupWallName(code);

              final WallUser newMember = WallUser(
                wallUserName: auth.getUserDisplayName,
                wallUserEmail: auth.getUserEmail,
                wallUserProfile: auth.getUserPhotoUrl,
              );

              final Wall data = Wall(
                wallId : code,
                wallName: (name.isNotEmpty) ? 
                  name :
                  wallProvider.getGroupWallName 
              );

              wallProvider.getWallList.add(newMember.toMap());
              wallProvider.updateGroupWall(
                {"wallMembers" : wallProvider.getWallList},
                code, 
              );
              userProvider.getUserWall.add(data.toMap());
              userProvider.updateGroupCode( {"palGroupWall" : userProvider.getUserWall} );

              _codeController.clear();
              _nameController.clear();
              Navigator.of(context).pop();
            }
          }
        );
      }
    );
    return;
  }

 
}