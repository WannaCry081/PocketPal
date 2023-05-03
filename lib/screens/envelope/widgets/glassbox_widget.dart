import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:pocket_pal/const/color_palette.dart';

class Glassbox extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Widget child;

  const Glassbox({
    Key? key,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
          height: height,
          width: width,
          child: Stack(
            children: [
              GlassmorphicContainer(
                child: Center(
                  child: child),
                width: width, 
                height: height, 
                borderRadius: borderRadius, 
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                border: 1, 
                blur: 30, 
                borderGradient: 
                    LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.3)
                        ],
                     ),),
            ],
          )),
    );
  }
}
