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
      mainAxisAlignment: MainAxisAlignment.center,
      children : [
        for (int i=0; i<pageViewItemLength; i++)
          AnimatedContainer(
            curve: Curves.fastLinearToSlowEaseIn,
            height : 10.h,
            width : (pageViewCurrentPage == i) ? 30.w : 10.w,
            duration : const Duration( milliseconds: 300 ),
            margin : EdgeInsets.symmetric(
              horizontal: 3.w,
            ),
            decoration: BoxDecoration(
              color : (pageViewCurrentPage == i) ?  ColorPalette.rustic : ColorPalette.lightGrey,
              borderRadius: BorderRadius.circular(100)
            ),
          )
      ]
    );
    // return ListView.builder(
    //   scrollDirection: Axis.horizontal,
    //   itemCount : pageViewItemLength,
    //   itemBuilder :(context, index) {
        // return AnimatedContainer(
        //   curve: Curves.fastLinearToSlowEaseIn,
        //   height : 12,
        //   width : (pageViewCurrentPage == index) ? 24 : 12,
        //   duration : const Duration( milliseconds: 300 ),
        //   margin : const EdgeInsets.symmetric(
        //     horizontal: 3,
        //   ),
        //   decoration: BoxDecoration(
        //     color : (pageViewCurrentPage == index) ?  ColorPalette.rustic : ColorPalette.lightGrey,
        //     borderRadius: BorderRadius.circular(100)
        //   ),
        // );
    //   },
    // );
  }
}