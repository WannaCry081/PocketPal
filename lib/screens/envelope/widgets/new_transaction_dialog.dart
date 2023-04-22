import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/screens/envelope/widgets/drop_down_menu.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";


class MyNewTransactionDialogWidget extends StatefulWidget {
   
  final GlobalKey<FormState> formKey;
  final String fieldName; //envelopeName
  final TextEditingController transactionTypeController;
  final TextEditingController transactionNameController;
  final TextEditingController transactionAmountController;
  final TextEditingController transactionCategoryController;
  final Function(String) addTransactionFunction;
  List<String> categories;

  bool isIncome = false;

  MyNewTransactionDialogWidget({
    required this.fieldName,
    required this.formKey,
    required this.transactionTypeController,
    required this.transactionNameController,
    required this.transactionAmountController,
    required this.transactionCategoryController,
    required this.addTransactionFunction,
    required this.categories,
    this.isIncome = false,
    super.key});

  @override
  State<MyNewTransactionDialogWidget> createState() => _MyNewTransactionDialogWidgetState();
}

class _MyNewTransactionDialogWidgetState extends State<MyNewTransactionDialogWidget> {
    String dropdownValue = "School";
    final GlobalKey<FormState> formKey1 = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, setState1){
            return 
             AlertDialog(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
              contentPadding: EdgeInsets.all(25),
              content: SingleChildScrollView(
              child: Form(
                key: widget.formKey,
                child: Column(
                children: [
                  Text(
                    "Add New Transaction",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    )
                  ),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Expense",
                    style: GoogleFonts.poppins(
                      fontSize: 18.sp
                    ),
                  ),
                  SizedBox( width: 10.w,),
                  Transform.scale(
                    scale: 1.2,
                    child: Switch(
                      value: widget.isIncome , 
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      activeTrackColor: Colors.green[100],
                      inactiveTrackColor: Colors.red[100],
                      onChanged: (value){
                      setState1(() {
                        widget.isIncome = value;
                        widget.transactionTypeController.text = widget.isIncome ? "Income" : "Expense";
                      });
                    }
                    ),
                  ),
                  SizedBox( width: 10.w,),
                  Text(
                      "Income",
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp
                      ),
                    ),
                ],
              ),
              Row(
                  children: [
                    Expanded(
                      child: PocketPalFormField(
                        formHintText: "Amount",
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
                      )
                    )
                  ],
              ),
              SizedBox( height : 10.h),
              Row(
                children: [
                  Expanded(
                    child: PocketPalFormField(
                      formHintText: "Transaction Name",
                      formController: widget.transactionNameController,
                      formValidator: (value){
                        if(value!.isEmpty){
                          return "Please enter a transaction name.";
                        }
                      },
                    )
                    )
                  ],
              ),
              SizedBox( height : 15.h),
              Row(
                children: [
                  Expanded(
                    child: MyDropDownMenuWidget(
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
                                  title: Text(
                                    'Add new category',
                                    style: GoogleFonts.poppins()),
                                    content: TextFormField(
                                      //controller: transactionCategoryController,
                                      decoration: const InputDecoration(
                                        hintText: 'Enter a new category',
                                      ),
                                      onChanged: (value) {
                                        setState((){
                                          newCategory = value;
                                        });
                                      },
                                    ),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel',
                                        style: GoogleFonts.poppins(
                                          color: ColorPalette.black
                                        ),
                                        ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Add',
                                        style: GoogleFonts.poppins()),
                                      onPressed: () {
                                        setState1(() {
                                          widget.categories.add(newCategory);
                                          dropdownValue = newCategory;
                                          widget.transactionCategoryController.text = newCategory;
                                        });
                                        widget.transactionCategoryController.clear();
                                        Navigator.of(context).pop();
                                        setState1((){});
                                      },
                                    ),
                                  ],
                                );
                                }
                                
                              );
                            },
                          );
                        } else {
                        setState1(() {
                            dropdownValue = value!;
                            widget.transactionCategoryController.text = dropdownValue;
                          });
                        }
                      },
                    )
                  )
                ],
              )
            ],
          ),
         )
      ),

      actions: [
          MaterialButton(
            color: ColorPalette.lightGrey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Cancel",
              style:GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              )
              ),
            onPressed: (){
              Navigator.of(context).pop();
               widget.transactionNameController.clear();
               widget.transactionAmountController.clear();
               widget.transactionTypeController.clear();
               widget.transactionCategoryController.clear();
            },
          ),
          MaterialButton(
            color: ColorPalette.rustic,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Save",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp
              )
            ),
            onPressed: (){
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
        );
      }
    );
  }

    final List<Color> categoryColors = [
      ColorPalette.rustic.shade200,
      ColorPalette.navy.shade500,
    Colors.red.shade200,
    Colors.orange.shade200,
    Color.fromARGB(255, 216, 195, 89),
    Colors.green.shade200,
     Colors.blue.shade200,
     Colors.purple.shade200,
  ];
}