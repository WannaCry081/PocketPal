import "package:flutter/material.dart";
import "package:pocket_pal/const/font_style.dart";


class NoWifiPage extends StatelessWidget {
  const NoWifiPage({ Key? key }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : Center(
        child : titleText(
          "Ha! Walay Wifi!"
        )
      )
    );
  }
}