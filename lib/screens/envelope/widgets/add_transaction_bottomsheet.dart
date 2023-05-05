import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
  List<String> categories; 

  AddNewTransaction({
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
    bool isExpenseClicked = false;
    bool isIncomeClicked = false;

    String dropdownValue = "School";
    final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();


  @override 
  void initState(){
    super.initState();
    isExpenseClicked = true;
  }  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: ColorPalette.white,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isExpenseClicked = !isExpenseClicked;
                            isIncomeClicked = false;
                            widget.transactionTypeController.text = "Expense";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          width: (screenWidth * .50) - 35,
                          decoration: BoxDecoration( 
                            color: isExpenseClicked ? ColorPalette.crimsonRed : Colors.transparent,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: titleText(
                            "Expense",
                            titleSize: 14.sp,
                            titleAlignment: TextAlign.center,
                            titleColor: !isExpenseClicked ?
                             ColorPalette.grey : ColorPalette.white
                          )
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            isIncomeClicked = !isIncomeClicked;
                            isExpenseClicked = false;
                            widget.transactionTypeController.text = "Income";
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          width: (screenWidth * .50) - 40,
                          decoration: BoxDecoration(  
                            color: isIncomeClicked ? ColorPalette.crimsonRed : Colors.transparent,
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: titleText(
                            "Income ",
                            titleSize: 14.sp,
                            titleAlignment: TextAlign.center,
                            titleColor: !isIncomeClicked ?
                             ColorPalette.grey : ColorPalette.white
                          )
                        ),
                      ),
                    ]),
                ),
                SizedBox( height: 5.h),  
                PocketPalFormField(
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
          
                SizedBox( height: 10.h),
          
                PocketPalFormField(
                  formHintText: "Transaction Name",
                  formController: widget.transactionNameController,
                  formValidator: (value){
                    if(value!.isEmpty){
                      return "Please enter a transaction name.";
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
                    }
                  },
                  onChanged: (value){
                    if (value == 'User-defined') {
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
}