import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";


class MyNewTransactionDialogWidget extends StatelessWidget {
   
  final GlobalKey<FormState> formKey;
  final String fieldName; //envelopeName
  final TextEditingController transactionTypeController;
  final TextEditingController transactionNameController;
  final TextEditingController transactionAmountController;
  final Function(String) addTransactionFunction;
  bool isIncome;

  MyNewTransactionDialogWidget({
    required this.fieldName,
    required this.formKey,
    required this.transactionTypeController,
    required this.transactionNameController,
    required this.transactionAmountController,
    required this.addTransactionFunction,
    this.isIncome = false,
    super.key});
    
    @override
    Widget build(BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, setState){
            return 
             AlertDialog(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
              contentPadding: EdgeInsets.all(25),
              content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                children: [
                  Text(
                    "Add New Transaction",
                    style: GoogleFonts.poppins(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
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
                      value: isIncome , 
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.red,
                      activeTrackColor: Colors.green[100],
                      inactiveTrackColor: Colors.red[100],
                      onChanged: (value){
                      setState(() {
                        isIncome = value;
                        transactionTypeController.text = isIncome ? "Income" : "Expense";
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
                const SizedBox( height: 5, ),
              Row(
                  children: [
                    Expanded(
                      child: PocketPalFormField(
                        formHintText: "Amount",
                        formController: transactionAmountController,
                        // formValidator: (value){
                        //   if(value!.isEmpty){
                        //     return "Please enter a transaction amount.";
                        //   }
                        //   if(double.tryParse(value) == null){
                        //     return "Please enter a valid amount.";
                        //   }
                        //   return null;
                        // },
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
                      formController: transactionNameController,
                      formValidator: (value){
                        if(value!.isEmpty){
                          return "Please enter a transaction name.";
                        }
                      },
                    )
                    )
                  ],
                  ),
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
               if (formKey.currentState!.validate()){
                addTransactionFunction(fieldName);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Transaction added!"),
                    duration: Duration(seconds: 1),));
              //   Navigator.push(
              //     context,
              //   MaterialPageRoute(builder: (context) => 
              //       const EnvelopeView()
              //       )
              // );
              }
            }
          ),
        ],

        );
        }
        );
    }
}