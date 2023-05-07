import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/screens/envelope/envelope%20notes/widgets/graph_tab_bar.dart';
import 'package:pocket_pal/screens/envelope/widgets/glassbox_widget.dart';
import 'package:pocket_pal/utils/envelope_util.dart';

class EnvelopeSummaryPieChart extends StatelessWidget {

  final String pageName;
  final Map<String, double> expensedataMap;
  final Map<String, double> incomedataMap;
  final Map<String, Color> categoryColorMap;
  final List<String> categories;
   final double incomeTotal;
   final double expenseTotal;
  final double width;

  EnvelopeSummaryPieChart({
    required this.pageName,
    required this.expensedataMap,
    required this.incomedataMap,
    required this.categoryColorMap,
    required this.categories,
    required this.incomeTotal,
    required this.expenseTotal,
    required this.width,
    super.key});
  

  @override
  Widget build(BuildContext context) {

    final List<Color> expenseColorList = expensedataMap.entries
    .map((entry) => categoryColorMap[entry.key] ?? Colors.grey)
    .toList();
    final List<Color> incomeColorList = incomedataMap.entries
    .map((entry) => categoryColorMap[entry.key] ?? Colors.grey)
    .toList();

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: titleText(
            "$pageName Overview",
            titleSize: 18.sp,
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 14.w),
            child: ListView(
            children: [
              SizedBox(
                height: screenHeight * 0.85,
                child: MyPieChartTab(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  expensedataMap: expensedataMap,
                  incomedataMap: incomedataMap,
                  expenseColorList: expenseColorList,
                  incomeColorList: incomeColorList,
                ),
              ),
            ],
            ),
          ),
        )
      ),
    );
  }
}