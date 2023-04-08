import "package:flutter/material.dart";


class PocketPalButton extends StatelessWidget {
  
  final void Function() ? buttonOnTap;
  final double buttonWidth;
  final double buttonHeight; 

  final double buttonVerticalMargin;
  final double buttonHorizontalMargin;
  final double buttonBorderRadius;

  final Color ? buttonColor;
  final Widget ? buttonChild;

  final List<BoxShadow> ? buttonBoxShadow;

  const PocketPalButton({ 
    super.key,
    required this.buttonOnTap,
    required this.buttonWidth,
    required this.buttonHeight,
    this.buttonHorizontalMargin = 0,
    this.buttonVerticalMargin = 0,
    required this.buttonColor,
    required this.buttonBorderRadius,
    required this.buttonChild,
    this.buttonBoxShadow
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap : buttonOnTap,
      child : AnimatedContainer(
        duration: const Duration( milliseconds:300 ),
        width : buttonWidth,
        height : buttonHeight,
        decoration: BoxDecoration(
          color : buttonColor,
          borderRadius: BorderRadius.circular(buttonBorderRadius),
          boxShadow : buttonBoxShadow
        ),

        child : Center(
          child : buttonChild
        )

      )
    );
  }
}