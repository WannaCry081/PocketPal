import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pocket_pal/const/color_palette.dart';

class MyPieChart extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final Map<String, double> dataMap;
  final List<Color> colorList;
  

  const MyPieChart({
    required this.screenHeight,
    required this.screenWidth,
    required this.dataMap,
    required this.colorList,
    super.key});

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding:  const EdgeInsets.only(top: 10.0),
      child: Container(
        padding:  const EdgeInsets.only(top: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: const GradientBoxBorder(
            width: 2,
            gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFea5753),
                    Color(0xFFfa9372),
                  ]
            ),
          ),
        ), 
        child: dataMap.isEmpty ?
        Container(
            width: screenWidth * 0.6,
            height: screenWidth * 0.6,
            alignment: Alignment.center,
            child: Text(
              'No data available',
              style: GoogleFonts.poppins(
                fontSize: 14.sp),
            ),
          )
        : PieChart(
          dataMap:  dataMap,
          emptyColor: ColorPalette.grey!,
          chartType: ChartType.ring,
          chartRadius: screenWidth * 0.6,
          ringStrokeWidth: 70,
          colorList:  colorList,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
            chartValueBackgroundColor: ColorPalette.midnightBlue,
            chartValueStyle: GoogleFonts.poppins(
              fontSize: 12.sp,
            ),
            showChartValuesOutside: true
          ),
          legendOptions: LegendOptions(
            showLegendsInRow: true,
            legendPosition: LegendPosition.bottom,
            legendTextStyle: GoogleFonts.poppins(
              fontSize: 12.sp,
            )
          ),
        ),
      ),
    );
  }
}