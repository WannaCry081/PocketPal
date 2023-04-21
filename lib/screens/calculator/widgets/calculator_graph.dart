import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pocket_pal/const/color_palette.dart';

class MyCalculatorGraph extends StatelessWidget {
  final Map<String, double> dataMap;
  final List<Color> colorList;
  final double screenWidth;

  const MyCalculatorGraph({
    required this.dataMap,
    required this.colorList,
    required this.screenWidth,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB( 25, 10, 5,0),
      child: PieChart(
          dataMap: dataMap,
          chartType: ChartType.ring,
          chartRadius: screenWidth * 0.43,
          ringStrokeWidth: 45,
          colorList: colorList,
          chartValuesOptions: ChartValuesOptions(
            showChartValuesInPercentage: true,
            showChartValuesOutside: true,
            decimalPlaces: 0,
            chartValueBackgroundColor: ColorPalette.murky.shade100,
            chartValueStyle: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: ColorPalette.black
            )
          ),
          legendOptions: LegendOptions(
            legendPosition: LegendPosition.right,
            legendTextStyle: GoogleFonts.poppins(
              fontSize: 14.sp,
            )
          ),
        ),
    );
  }
}