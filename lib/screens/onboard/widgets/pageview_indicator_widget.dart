import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pocket_pal/const/color_palette.dart";


class MyPageViewIndicatorWidget extends StatelessWidget {

  final int pageViewItemLength;
  final int pageViewCurrentPage; 

  const MyPageViewIndicatorWidget({
    super.key,
    required this.pageViewItemLength,
    required this.pageViewCurrentPage,
  }); 

  @override
  Widget build(BuildContext context){

    return Row(
      children : [
        for (int i=0; i<pageViewItemLength; i++)
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            height : 4.h,
            width : (pageViewCurrentPage == i) ? 
              40.w : 
              15.w,
            duration : const Duration( milliseconds: 300 ),
            margin : EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
            decoration: BoxDecoration(
              color : (pageViewCurrentPage == i) ?  
                ColorPalette.rustic : 
                ColorPalette.grey,
              borderRadius: BorderRadius.circular(10)
            ),
          )
      ]
    );
  }
}