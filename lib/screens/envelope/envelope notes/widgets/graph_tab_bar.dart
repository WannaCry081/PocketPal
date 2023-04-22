import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/envelope/graph/graph_tab_bar_view.dart';

class MyPieChartTab extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final Map<String, double> expensedataMap;
  final Map<String, double> incomedataMap;
  final List<Color> expenseColorList;
  final List<Color> incomeColorList;


  const MyPieChartTab({
    required this.screenHeight,
    required this.screenWidth,
    required this.expensedataMap,
    required this.incomedataMap,
    required this.expenseColorList,
    required this.incomeColorList,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Container(
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12)
          ),
           child: Padding(
             padding: const EdgeInsets.symmetric(
              vertical: 5.5,
              ),
             child: TabBar(
              isScrollable: true,
              labelColor: ColorPalette.white,
              unselectedLabelColor: ColorPalette.grey,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFFea5753),
                   Color(0xFFfa9372),
                  ]
                )
              ),
              dividerColor: Colors.transparent,
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return states.contains(MaterialState.focused) ? null : Colors.transparent;
                }
              ),
              tabs:  [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric( horizontal: 20.w),
                    child: Text(
                      "Income",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  )
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric( horizontal: 20.w),
                    child: Text(
                      "Expenses",
                      style: GoogleFonts.poppins(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  )
                ),
              ],
             ),
           ),
         ),
         Expanded(
          child: TabBarView(
            children: [
              MyPieChart(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                dataMap: incomedataMap,
                colorList: incomeColorList,
              ),
              MyPieChart(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                dataMap: expensedataMap,
                colorList: expenseColorList,
              ),

            ],
          ),
         )

      ],
    );
  }
}