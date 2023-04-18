import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/envelope/widgets/glassbox_widget.dart';

class MoneyFlowCard extends StatelessWidget {
  final double width;
  final String amount;
  final String name;
  final Color iconColor;
  final IconData icon;


  const MoneyFlowCard({
    super.key,
    required this.name,
    required this.width,
    required this.amount,
    required this.iconColor,
    required this.icon,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 150,
      decoration: BoxDecoration(
        color: ColorPalette.lightGrey,
        borderRadius: BorderRadius.circular(20)
        
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(icon,
                      color: Colors.white,
                      ),
                  ),
                  decoration: BoxDecoration(
                    color: iconColor,
                    shape: BoxShape.circle
                  ),
                ),
                const SizedBox ( width: 10),
                Text(
                  "$name",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                  )
                ),
              ],
            ),
            const SizedBox ( height: 5),
            Text(
              "Php $amount",
              style: GoogleFonts.poppins(
                fontSize: 30,
                color: ColorPalette.rustic.shade400,
                fontWeight: FontWeight.bold,
                height: 1.3
              )
            ),
          ],
        ),
      )
    );
  }
}