import 'package:flutter/material.dart';
import 'package:pocket_pal/screens/profile/widgets/overview_count_widget.dart';
import 'package:pocket_pal/const/color_palette.dart';

class MyProfileOverview extends StatelessWidget{

  final int folderNumber;
  final int envelopeNumber;
  final int groupNumber;

  const MyProfileOverview ({
    super.key,
    required this.folderNumber,
    required this.envelopeNumber,
    required this.groupNumber,
    });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          OverviewCountWidget(
            count: folderNumber,
            countTitle: "folders",
          ),
    
          VerticalDivider(
            thickness: 1.5,
            color: ColorPalette.lightGrey,
            indent: 5,
            endIndent: 5,
            width: 45,
           ),

          OverviewCountWidget(
            count: envelopeNumber,
            countTitle: "envelopes",
          ),

          VerticalDivider(
            thickness: 1.5,
            color: ColorPalette.lightGrey,
            indent: 5,
            endIndent: 5,
            width: 45,
          ),

          OverviewCountWidget(
            count: envelopeNumber,
            countTitle: "groups",
          ),
          
         
        ]
      ),
    );
  }
  
}