import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/calculator/widgets/budget_allocation.dart';
import 'package:pocket_pal/screens/calculator/widgets/calculator_graph.dart';
import 'package:pocket_pal/screens/calculator/widgets/textfield_widget.dart';
import 'package:pocket_pal/widgets/pocket_pal_button.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {

  TextEditingController _incomeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   Map<String, double> dataMap = {
    "Necessities": 50,
    "Wants": 30,
    "Savings": 20,
    };
  
  final colorList = <Color>[
      ColorPalette.rustic.shade500,
      ColorPalette.navy.shade500,
      ColorPalette.murky.shade500,
    ];
  
  String _buttonText = "Calculate";
  double _needs = 0.0;
  double _wants = 0.0;
  double _savings = 0.0;
  bool showAllocation = false;

  void calculateBudget(){
    double income = double.parse(_incomeController.text);
     _needs = income * 0.50;
     _wants = income * 0.30;
     _savings = income * 0.20;

      if (_needs == _needs.toInt()) {
       _needs = _needs.toInt().toDouble();
     } 
     if (_wants == _wants.toInt()) {
       _wants = _wants.toInt().toDouble();
     } 
     if (_savings == _savings.toInt()) {
       _savings = _savings.toInt().toDouble();
     } 

  }

  void updateBudget(){
  if(formKey.currentState!.validate()){
    calculateBudget();
    setState(() {});
  }
}

  @override
  Widget build(BuildContext context) {

  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFEFEFE),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFEFE),
        leading: GestureDetector(
          onTap: () {
            ZoomDrawer.of(context)!.toggle();
          },
          child: const Icon(FeatherIcons.arrowLeft)
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Budget Calculator",
                  style: GoogleFonts.poppins(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.navy.shade600
                  )
                ),
                SizedBox( height: 3.h),
                Text(
                  "Enter your income to create a\nsuggested budget.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    height: 1.2
                  )
                ),
                SizedBox( height: 22.h),
                Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: MyCalculatorTextFieldWidget(
                    screenWidth: screenWidth,
                    incomeController: _incomeController,
                  ),
                ),
                SizedBox( height: 10.h),
                PocketPalButton(
                  buttonOnTap: (){
                    if(formKey.currentState!.validate()){
                      setState(() {
                      updateBudget();
                      showAllocation = true;
                      _buttonText = "Recalculate";
                      FocusScope.of(context).unfocus();
                    });
                    }
                  }, 
                  buttonWidth: screenWidth * 0.70, 
                  buttonHeight: 45.h, 
                  buttonColor: ColorPalette.rustic, 
                  buttonChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _buttonText,
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: ColorPalette.white,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                      SizedBox( width: 1.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: ColorPalette.white,
                      )
                    ],
                  )),
                  SizedBox( height: 40.h),
                  Visibility(
                    visible: showAllocation,
                    child: Column(
                      children: [
                        Text(
                          "Your 50/30/20 Budget Allocation",
                          style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            color: ColorPalette.navy.shade400,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox( height: 6.h),
                        MyBudgetAllocation(
                          needs:  _needs.toStringAsFixed(_needs.truncateToDouble() == _needs ? 0 : 2),
                          wants: _wants.toStringAsFixed(_needs.truncateToDouble() == _needs ? 0 : 2),
                          savings: _savings.toStringAsFixed(_needs.truncateToDouble() == _needs ? 0 : 2),
                          fontSize: _needs.toString().length > 5 ? 17.sp : 24.sp
                        ),
                        SizedBox( height: 25.h),
                        MyCalculatorGraph(
                          screenWidth: screenWidth,
                          dataMap: dataMap,
                          colorList: colorList
                        ),
                        SizedBox( height: 40.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 14.h),
                          child: Text(
                            "     The 50/30/20 budget is a simple and effective way to manage your money and ensure that you're prioritizing your spending in a way that aligns with your goals. By dividing your income into three categories, you can easily see where your money is going and make adjustments as needed.",
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        )
                      ],
                    ),
                  ),
              ]
            ),
          ),
        ),
      )
    );
  }

 
  
}