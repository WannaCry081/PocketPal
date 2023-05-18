import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/screens/envelope/widgets/drop_down_menu.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';

class AddNewTransaction extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String fieldName; 
  final TextEditingController transactionTypeController;
  final TextEditingController transactionNameController;
  final TextEditingController transactionAmountController;
  final TextEditingController transactionCategoryController;
  final Function(String) addTransactionFunction;
  final List<String> categories; 

  const AddNewTransaction({
    required this.fieldName,
    required this.formKey,
    required this.transactionTypeController,
    required this.transactionNameController,
    required this.transactionAmountController,
    required this.transactionCategoryController,
    required this.addTransactionFunction,
    required this.categories,
    super.key});

  @override
  State<AddNewTransaction> createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {

    bool _buttonState = true;

    String dropdownValue = "School";
    final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();


  @override 
  void initState(){
    super.initState();
    widget.transactionTypeController.text = "Expense";
  }  
  
  @override
  Widget build(BuildContext context) {

    return Padding(
       padding : EdgeInsets.only(
        top : 10.h,
        right : 7.w,
        left : 7.w,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom,),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                titleText(
                 "ADD TRANSACTION",
                 titleColor: ColorPalette.black,
                 titleAlignment: TextAlign.center,
                 titleSize: 18.sp,
                 titleWeight: FontWeight.w500
                ),
                SizedBox( height: 10.h),
                _customSwitchButton(context),
                SizedBox( height: 5.h),  
                Row(
                  children: [
                    bodyText(
                      "Php",
                      bodyWeight : FontWeight.w600,
                      bodySize : 15.sp,
                      bodyColor: ColorPalette.grey
                    ),
                    SizedBox( width: 5.w,),
                    Expanded(
                      child: PocketPalFormField(
                        formHintText: "Amount",
                        formKeyboardType: TextInputType.number,
                        formController: widget.transactionAmountController,
                        formValidator: (value){
                          if(value!.isEmpty){
                            return "Please enter a transaction amount.";
                          }
                          if(int.tryParse(value) == null){
                            return "Please enter a valid amount.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
          
                SizedBox( height: 10.h),
          
                PocketPalFormField(
                  formHintText: "Transaction Name",
                  formController: widget.transactionNameController,
                  formValidator: (value){
                    if(value!.isEmpty){
                      return "Please enter a transaction name.";
                    } else {
                      return null;
                    }
                  },
                ),
          
                SizedBox( height: 20.h),
          
                MyDropDownMenuWidget(
                  formKey: formKey1,
                  dropdownValue: dropdownValue,
                  categories: widget.categories,
                  categoryColors: categoryColors,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a category';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value){
                    if (value == 'Custom') {
                      String newCategory = '';
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, setState){
                              return AlertDialog(
                              title: titleText(
                                'Add new category',),
                                content: PocketPalFormField(
                                  formHintText: "Enter a new category",
                                  formOnChange: (value) {
                                    setState((){
                                      newCategory = value;
                                    }); 
                                  },
                                ),
                              actions: [
                                GestureDetector(
                                  child: bodyText (
                                    'Cancel',
                                    bodyColor: ColorPalette.black,
                                    bodySize : 14.sp,
                                    bodyWeight: FontWeight.w500
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: bodyText (
                                    'Add',
                                    bodyColor: ColorPalette.crimsonRed,
                                    bodySize : 14.sp,
                                    bodyWeight: FontWeight.w500
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.categories.add(newCategory);
                                      dropdownValue = newCategory;
                                      widget.transactionCategoryController.text = newCategory;
                                    });
                                    widget.transactionCategoryController.clear();
                                    Navigator.of(context).pop();
                                    setState((){});
                                  },
                                ),
                              ],
                            );
                            }
                          );
                        },
                      );
                    } else {
                    setState(() {
                        dropdownValue = value!;
                        widget.transactionCategoryController.text = dropdownValue;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 60.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: bodyText (
                          'Cancel',
                          bodyColor: ColorPalette.black,
                          bodySize : 14.sp,
                          bodyWeight: FontWeight.w500
                        ),
                        onTap: (){
                          Navigator.of(context).pop();
                          widget.transactionNameController.clear();
                          widget.transactionAmountController.clear();
                          widget.transactionTypeController.clear();
                          widget.transactionCategoryController.clear();
                        }, 
                      ),
                      SizedBox( width: 15.w,),
                      GestureDetector(
                      child: bodyText (
                          'Save',
                          bodyColor: ColorPalette.crimsonRed,
                          bodySize : 14.sp,
                          bodyWeight: FontWeight.w500
                        ),
                        onTap: (){
                          if (widget.formKey.currentState!.validate()){
                            widget.addTransactionFunction(widget.fieldName);
                              ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Transaction added!"),
                                duration: Duration(seconds: 1),));
                            Navigator.of(context).pop;
                          }
                        }
                      ),
                    ],
                  ),
                )
                      
              ],
            ),
          ),
        ),
      ),
    );
  }

  final List<Color> categoryColors = [
      ColorPalette.crimsonRed,
      ColorPalette.midnightBlue.shade500,
    Colors.red.shade200,
    Colors.orange.shade200,
    Color.fromARGB(255, 216, 195, 89),
    Colors.green.shade200,
    Colors.blue.shade200,
    Colors.purple.shade200,
  ];


    Widget _customSwitchButton(BuildContext context){
    final double switchWidth = (MediaQuery.of(context).size.width/2) - 26.w;
    return Container(
      height : 50.h,
      decoration : BoxDecoration(
        color : ColorPalette.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child : Stack(
        alignment : Alignment.center,
        children : [
          AnimatedPositioned(
            left : (_buttonState) ? 5.w : (switchWidth+4.w), 
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastLinearToSlowEaseIn,
            child : Container(
              height : 42.h, 
              width : switchWidth,
              decoration: BoxDecoration(
                color : ColorPalette.crimsonRed, 
                borderRadius: BorderRadius.circular(14)
              ),
            )
          ),

          Row(
            children : [
              Expanded(
                child: GestureDetector(
                  onTap :() => _updateButtonState(true),
                  child: Center(
                    child: titleText(
                      "Expense",
                      titleSize : 14.sp,
                      titleColor: (_buttonState) ? 
                        ColorPalette.white: 
                        ColorPalette.grey,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () => _updateButtonState(false),
                  child: Center(
                    child: titleText(
                      "Income",
                      titleSize : 14.sp,
                       titleColor: (_buttonState) ? 
                        ColorPalette.grey: 
                        ColorPalette.white,
                    ),
                  ),
                ),
              )
            ]
          ),

        ]
      )
    );
  }

  void _updateButtonState(bool value){
    setState((){
      _buttonState = value;
    }); 
    _buttonState ? widget.transactionTypeController.text = "Expense" :  widget.transactionTypeController.text = "Income";
    //widget.transactionTypeController.clear();
    return;
  }

}