import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/calculator/widgets/result_container.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {

  String userInput = "";
  String result = "0";

  @override
  Widget build(BuildContext context) {

  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFFEFEFE),
      appBar: AppBar(
        backgroundColor: Color(0xFFFEFEFE),
        leading: GestureDetector(
          onTap: () {
            ZoomDrawer.of(context)!.toggle();
          },
          child: const Icon(FeatherIcons.arrowLeft)
        ),
        title: Text(
            "Calculator",
            style: GoogleFonts.poppins(
              fontSize : 18.sp,
              color: ColorPalette.black,
            ),
        ),
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: screenHeight / 3.5,
              child: MyResultWidget(
                userInput: userInput, 
                result: result,
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                )
            ),
            Expanded(
              child: Container(
                height: screenHeight * 2 / 3.5,
                color: const Color(0xFFFEFEFE),
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: buttonList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10, 
                  ), 
                  itemBuilder: (context, index){
              
                    return InkWell(
                      onTap: (){
                        setState(() {
                          handleButtonPress(buttonList[index]);
                        });
                      },
                      splashColor: Colors.red,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getBGColor(buttonList[index]),
                          boxShadow: [
                        
                          BoxShadow(
                            color: Colors.grey.shade400,
                            offset: const Offset(4,4),
                            blurRadius: 5.0,
                            spreadRadius: 0.5
                          ),
                        
                          BoxShadow(
                            color: ColorPalette.white!,
                            offset: const Offset(-4.0, -4.0),
                          blurRadius: 10.0,
                            spreadRadius: 0.5
                          ),
                          ]
                        ),
                        child: Center(
                          child: Text(
                            buttonList[index], 
                            style: GoogleFonts.poppins(
                              color: getColor(buttonList[index]),
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w600,
                            )
                          ),
                        ),
                              ),
                    );
                }),
              ),
            )
          ]
        ),
      )
    );
  }

  getColor(String text){
    if( 
      text == "/" ||
      text == "*" ||
      text == "+" ||
      text == "-" ||
      text == "C" ||
      text == "(" ||
      text == ")"
    ){
      return ColorPalette.rustic.shade400;
    }
    if(text == "=" || text == "AC"){
      return Colors.white;
    }
    return const Color(0xFF343434);
  }

  getBGColor(String text){
    if(text == "AC"){
      return ColorPalette.navy.shade700;
    }
    if(text == "="){
      return ColorPalette.rustic;
    }
    return const Color(0xFFFEFEFE);
  }

  List<String> buttonList = [
    "AC", 
    "(", 
    ")", 
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "=",
  ];

  handleButtonPress(String text){
    if(text == "AC"){
      userInput = "";
      result = "0";
      return;
    }
    
    if(text == "C"){
      if(userInput.isNotEmpty){
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      }
      else {
        return null;
      }
    }

    if (text == "="){
      result = calculate();
      userInput = result;
      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", "");
      }
      if(result.endsWith(".0")){
        result = result.replaceAll(".0", "");
      }
      return;
    }
    userInput += text;
  }
  
  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(
        EvaluationType.REAL,
        ContextModel()
      );
      return evaluation.toString();
    }
    catch(e){
      return "Error";
    }
  }


  
}