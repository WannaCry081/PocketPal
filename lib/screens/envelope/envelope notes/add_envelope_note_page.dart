import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:intl/intl.dart';


// ignore: must_be_immutable
class AddEnvelopeNote extends StatefulWidget {
    final GlobalKey<FormState> formKey;
    final String fieldName; 
    final String dateTime ;
    final String envelopeNoteUsername;
     TextEditingController envelopeNoteNameController;
     TextEditingController envelopeNoteContentController;
    final Function(String) addNotesFunction;
    void Function(String)? updateNoteFunction;
    void Function()? deleteNoteFunction;
    final bool isEnabled;
    final bool showDeleteIcon;
    bool editIsClicked;
    final int? noteIndex;
  
   AddEnvelopeNote({
    required this.formKey,
    required this.fieldName,
    required this.dateTime ,
    required this.envelopeNoteUsername,
    required this.envelopeNoteNameController,
    required this.envelopeNoteContentController,
    required this.addNotesFunction,
    this.updateNoteFunction,
    this.deleteNoteFunction,
    this.isEnabled = false,
    this.showDeleteIcon = false,
    this.editIsClicked = false,
    this.noteIndex,
    super.key});

  @override
  State<AddEnvelopeNote> createState() => _AddEnvelopeNoteState();
}

class _AddEnvelopeNoteState extends State<AddEnvelopeNote> {
  bool _isTextFieldClicked = false;
   final _focusNode = FocusNode();

  @override 
  void dispose(){
     _focusNode.dispose();
     super.dispose(); 
  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          actions: [
            Visibility(
              visible: widget.showDeleteIcon,
              child: IconButton(
                icon: const Icon(FeatherIcons.trash),
                onPressed: widget.deleteNoteFunction,
              ),
            ),
          if(_isTextFieldClicked ||  widget.showDeleteIcon != true)
          Padding(
            padding: EdgeInsets.only(right: 7.w),
            child: GestureDetector(
              child: IconButton(
                icon: Icon(FeatherIcons.check,
                color: ColorPalette.crimsonRed,
                size: 26,),
                onPressed: (){
                  if (widget.formKey.currentState!.validate()){
                    if(widget.showDeleteIcon){
                      widget.updateNoteFunction;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:Text("Notes updated!"),
                          duration: Duration(seconds: 1),),);
                      Navigator.of(context).pop();
                    } else {
                       widget.addNotesFunction(widget.fieldName);
                       _focusNode.unfocus();
                       ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:Text("Notes added!"),
                          duration: Duration(seconds: 1),),);
                    }
                    }
                },
              ),
            ),
          ) 
        ],
      ),
      body: Form(
        key: widget.formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox( height: 5.h,),
                TextFormField(
                   onTap: () {
                    setState(() {
                      _isTextFieldClicked = true;
                    });
                  },
                  enabled: widget.isEnabled,
                  controller: widget.envelopeNoteNameController,
                  style: GoogleFonts.poppins(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.grey
                  ),
                  decoration: InputDecoration(
                    hintText: "Title",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.grey
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      )
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent
                      )
                    )
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.4,
                      child: TextFormField(
                        enabled: false ,
                        decoration: InputDecoration(
                          hintText: widget.dateTime ,
                          hintStyle: GoogleFonts.lato(
                            fontSize: 14.sp
                          ),
                          disabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent
                            )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 22.h,
                      child: VerticalDivider(
                        thickness: 2,
                        color: ColorPalette.crimsonRed,
                        width: 22.w,
                        indent: 2,
                        endIndent: 2,
                      ),
                    ),
                    Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h
                      ),
                    decoration: BoxDecoration(
                      color: ColorPalette.midnightBlue,
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Text(
                      widget.envelopeNoteUsername,
                      style: GoogleFonts.poppins(
                        color: ColorPalette.white,
                        fontSize: 12.sp
                      ),
                     ),
                    )
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    enabled: widget.isEnabled,
                    controller: widget.envelopeNoteContentController,
                    style: GoogleFonts.lato(
                      fontSize: 14.sp,
                    ),
                    onTap: () {
                      setState(() {
                        _isTextFieldClicked = true;
                      });
                    },
                    scrollPadding: EdgeInsets.all(20),
                    keyboardType: TextInputType.multiline,
                    maxLines : null,
                    decoration: const InputDecoration(
                      enabledBorder:  UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent,
                      )
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.transparent
                      )
                    )
                    )
                  )
                )
            ],
          ),
        ),
      ),
    );
  }
}
