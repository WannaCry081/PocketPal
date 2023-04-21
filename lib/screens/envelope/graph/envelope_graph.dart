import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/envelope/widgets/glassbox_widget.dart';
import 'package:pocket_pal/screens/envelope/widgets/money_flow_card.dart';
import 'package:pocket_pal/utils/envelope_structure_util.dart';

class EnvelopeSummaryPieChart extends StatelessWidget {

  final String pageName;
  final double incomeTotal;
  final double expenseTotal;
  final double width;

  EnvelopeSummaryPieChart({
    required this.pageName,
    required this.incomeTotal,
    required this.expenseTotal,
    required this.width,
    super.key});
  

  @override
  Widget build(BuildContext context) {

    Map<String, double> dataMap = {
    "Income": incomeTotal,
    "Expenses": expenseTotal,
    };
    final colorList = <Color>[
      ColorPalette.black!,
      ColorPalette.lightGrey!
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "$pageName Summary",
           style: GoogleFonts.poppins(
              fontSize : 20.sp,
              color: ColorPalette.white,
            ),
        ),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/envelope_bg.png",
              ),
              fit: BoxFit.cover,
            )
          ),
          child: SafeArea(
            child: Column(
            children: [
              SizedBox( height: 15.h,),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w),
                child: Glassbox(
                  height: screenHeight * 0.5,
                  width: width,
                  borderRadius: 25,
                  child: Padding(
                    padding:  EdgeInsets.only( top: 8.0),
                    child: PieChart(
                      dataMap: dataMap,
                      chartType: ChartType.ring,
                      chartRadius: screenWidth * 0.6,
                      ringStrokeWidth: 50,
                      colorList: colorList,
                      chartValuesOptions: ChartValuesOptions(
                        showChartValuesInPercentage: true,
                        chartValueBackgroundColor: ColorPalette.murky.shade500,
                        chartValueStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                        )
                      ),
                      legendOptions: LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom,
                        legendTextStyle: GoogleFonts.poppins(
                          fontSize: 14.sp,
                        )
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox( height: 20.h,),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: ColorPalette.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)
                      )
                  ),
                  child:   
                  Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MoneyFlowCard(
                            name: "Income",
                            width: (screenWidth / 2) - 20,
                            amount: incomeTotal.toStringAsFixed(2), 
                            iconColor: Colors.green.shade700,
                            icon: FeatherIcons.arrowDown,
                           ),
                          MoneyFlowCard(
                            name: "Expense",
                            width: (screenWidth / 2) - 20,
                            amount: expenseTotal.toStringAsFixed(2), 
                            iconColor: Colors.red.shade700,
                            icon: FeatherIcons.arrowUp,
                            ),
                        ],
                      ),
                    ),
                )
              )
            ],
                  ),
          ),
        ),
      )
    );
  }
}