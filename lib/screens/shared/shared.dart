import "package:flutter/material.dart";
import 'package:pocket_pal/screens/content/folder_grid.dart';
import "package:pocket_pal/screens/shared/widgets/bottom_sheet_widget.dart";
import "package:pocket_pal/utils/wall_util.dart";
import "package:provider/provider.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";

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
  void didChangeDependencies(){
    super.didChangeDependencies();
    Provider.of<UserProvider>(
      context,
      listen: true
    ).fetchGroupWall();
    return;
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
    final userProvider = Provider.of<UserProvider>(context);
    final List<Map<String, dynamic>> userWall = userProvider.getGroupWall;
    final int userWallLength = userWall.length;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _sharedWallCreateGroup, 
        shape :  const CircleBorder(),
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
                pocketPalTitle: "Shared Walls",
              ),

              for (int i=0; i<userWallLength ; i++)
                MyListTileWidget(
                  listTileName : userWall[i]["wallName"],
                  listTileWallNavigation: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder : (context) => FolderGridPage(
                          code : userWall[i]["wallId"],
                          wallName: userWall[i]["wallName"],
                        )
                      )
                    );
                  },
                )

            ]
          ),
        ),
      )
    );
  }

  void _sharedWallCreateGroup(){
    final userProvider = Provider.of<UserProvider>(context, listen : false);
    final List<Map<String, dynamic>> userWall = userProvider.getGroupWall;
    
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
            if (_formKey.currentState!.validate()){
              _formKey.currentState!.save();

              final String code = _codeController.text.trim();
              final String name = _nameController.text.trim();

              final Map<String, dynamic> data = Wall(
                wallId : code,
                wallName: name,
              ).toMap();

              userWall.add(data);
              userProvider.updateGroupCode(
                {"palGroupWall" : userWall}
              );

              userProvider.createGroupWall(
                code,
                data
              );
              _codeController.clear();
              _nameController.clear();
              Navigator.of(context).pop();
            }
          },

          bottomSheetOnJoin : (){
            if (_formKey.currentState!.validate()){
              _formKey.currentState!.save();

              final String code = _codeController.text.trim();
              final String name = _nameController.text.trim();

              final Map<String, dynamic> data = Wall(
                wallId : code,
                wallName: name,
              ).toMap();

              userWall.add(data);
              userProvider.updateGroupCode(
                {"palGroupWall" : userWall}
              );

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