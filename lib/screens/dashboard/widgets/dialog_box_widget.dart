import "package:flutter/material.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";


class MyDialogBoxWidget extends StatelessWidget {
  
  final double screenWidth;
  final double screenHeight;

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  final void Function(String) addFolderFunction;

  final String fieldName;

  const MyDialogBoxWidget({ 
    super.key,
    required this.fieldName,
    required this.titleController,
    required this.descriptionController,
    required this.addFolderFunction,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width : screenWidth,
        height : 200,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color : ColorPalette.white
        ),
        child : Column(
          children : [

            PocketPalFormField(
              formController: titleController,
              formHintText: "Folder Name"
            ),

            PocketPalFormField(
              formController: descriptionController,
              formHintText: "Folder Description"
            ),

            ElevatedButton(
              child : Text("Submit"),
              onPressed: (){
                addFolderFunction(fieldName);
              }
            )
          ]
        )
      ),
    );
  }
}