import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/screens/calculator/widgets/budget_tiles.dart';
import 'package:pocket_pal/screens/calculator/widgets/calculator_graph.dart';
import 'package:pocket_pal/screens/calculator/widgets/textfield_widget.dart';
import 'package:pocket_pal/screens/envelope/widgets/glassbox_widget.dart';
import 'package:pocket_pal/widgets/pocket_pal_button.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';
import 'package:pocket_pal/widgets/pocket_pal_menu_button.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {

  TextEditingController _incomeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

   Map<String, double> dataMap = {
    "Necessities (50%)": 50,
    "Wants (30%)": 30,
    "Savings (20%)": 20,
    };
  
  final colorList = <Color>[
      ColorPalette.crimsonRed.shade500,
      ColorPalette.midnightBlue.shade500,
      ColorPalette.pearlWhite.shade500,
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

  final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFEFEFE),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFEFE),
        leading: PocketPalMenuButton(),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10.h,),
                titleText(
                  " 50/30/20 Budget Calculator",
                  titleAlignment: TextAlign.center,
                  titleColor: ColorPalette.midnightBlue,
                  titleSize: 22.sp,
                  titleWeight: FontWeight.w700
                ),
                SizedBox( height: 3.h),
                bodyText(
                  "Enter your income to create a\nsuggested budget.",
                  bodyAlignment: TextAlign.center,
                  bodySize: 14.sp,
                  bodyHeight: 1.2,
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
                  buttonColor: ColorPalette.crimsonRed, 
                  buttonChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      titleText(
                        _buttonText,
                        titleSize: 16.sp,
                        titleColor: ColorPalette.white,
                        titleWeight: FontWeight.w600,
                      ),
                      SizedBox( width: 1.w),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: ColorPalette.white,
                      )
                    ],
                  )),
                  SizedBox( height: 10.h),
                  Visibility(
                    visible: showAllocation,
                    child: Column(
                      children: [
                        SizedBox( height: 6.h),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               MyCalculatorGraph(
                                screenWidth: screenWidth,
                                dataMap: dataMap,
                                colorList: colorList
                              ),
                              MyBudgetTiles(
                                needs:  _needs.toStringAsFixed(_needs.truncateToDouble() == _needs ? 0 : 2),
                                wants: _wants.toStringAsFixed(_needs.truncateToDouble() == _needs ? 0 : 2),
                                savings: _savings.toStringAsFixed(_needs.truncateToDouble() == _needs ? 0 : 2),
                                fontSize: _needs.toString().length > 6 ? 17.sp : 26.sp
                              ),
                            ],
                          ),
                        ),
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