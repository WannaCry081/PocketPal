import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/screens/envelope/widgets/glassbox_widget.dart';
import 'package:pocket_pal/widgets/pocket_pal_appbar.dart';
import 'package:pocket_pal/widgets/pocket_pal_button.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';
import 'package:pocket_pal/screens/calculator/widgets/textfield_widget.dart';

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
      ColorPalette.midnightBlue,
      ColorPalette.crimsonRed,
      ColorPalette.salmonPink.shade300,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                const PocketPalAppBar(
                  pocketPalTitle: "Calculator",
                ),

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
                              calculatorGraph( dataMap, colorList, screenWidth ),
                               
                              myBudgetTiles(
                                _needs.toStringAsFixed(_needs.truncateToDouble() == _needs ? 0 : 2),
                                _wants.toStringAsFixed(_needs.truncateToDouble() == _needs ? 0 : 2),
                                _savings.toStringAsFixed(_needs.truncateToDouble() == _needs ? 0 : 2),
                                _incomeController.text.length > 6 ? 16.sp : 26.sp,
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

  Widget calculatorGraph(dataMap, colorList, screenWidth) =>
  Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 5,0),
      child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          chartRadius: screenWidth * 0.45,
          ringStrokeWidth: 25,
          colorList: colorList,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
            decimalPlaces: 0,
            chartValueBackgroundColor: ColorPalette.midnightBlue.shade100,
            chartValueStyle: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: ColorPalette.black
            )
          ),
          legendOptions: LegendOptions(
            legendPosition: LegendPosition.bottom,
            legendTextStyle: GoogleFonts.poppins(
              fontSize: 14.sp,
            )
          ),
        ),
    );

  Widget myBudgetTiles (needs, wants, savings, fontSize ) =>
  Column(
      children: [
        cardContent( "Needs", needs, fontSize, ColorPalette.midnightBlue ),
        SizedBox( height: 10.h),
        cardContent( "Wants", wants, fontSize, ColorPalette.crimsonRed),
        SizedBox( height: 10.h),
        cardContent( "Savings", savings, fontSize, ColorPalette.salmonPink.shade300 ),
      ],
  );

    Widget cardContent( name, value, fontSize, color) =>
    Container(
      height: 140, 
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          bodyText(
            name,
            bodySize: 16.sp,
            bodyWeight: FontWeight.w600,
            bodyColor: ColorPalette.white,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SvgPicture.asset(
                  "assets/icon/peso_sign.svg",
                  height: 14.h,
                  color: ColorPalette.white,
              ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: titleText(
                value,
                titleColor: ColorPalette.white,
                titleWeight: FontWeight.bold,
                titleSize: fontSize,
              ),
          )
          ],
        ),
        ],
      ),
    );
}