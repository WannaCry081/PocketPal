import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";

import "package:pocket_pal/const/color_palette.dart";

import "package:pocket_pal/widgets/pocket_pal_button.dart";

import "package:pocket_pal/services/auth_services.dart";


class SocialAuthWidget extends StatelessWidget {

  const SocialAuthWidget({ super.key });

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children : [
        PocketPalButton(
          buttonBorderRadius: 100,
          buttonHeight: 60, 
          buttonWidth: 60, 
          buttonColor: ColorPalette.white, 
          buttonOnTap: () => AuthFirebaseService().signInWithGoogle(),
          buttonBoxShadow: [
            BoxShadow(
              blurRadius: 5,
              color : Colors.black.withOpacity(.2)
            ) 
          ],
          buttonChild: SvgPicture.asset(
            "assets/icon/Google.svg",
          ),
        ),
      
        const SizedBox( width : 20 ),
        PocketPalButton(
          buttonBorderRadius: 100,
          buttonHeight: 60, 
          buttonWidth: 60, 
          buttonColor: ColorPalette.white, 
          buttonOnTap: (){},
          buttonBoxShadow: [
            BoxShadow(
              blurRadius: 5,
              color : Colors.black.withOpacity(.2)
            ) 
          ],
          buttonChild: SvgPicture.asset(
            "assets/icon/Facebook.svg",
          ),
        ),

        const SizedBox( width : 20 ),
        PocketPalButton(
          buttonBorderRadius: 100,
          buttonHeight: 60, 
          buttonWidth: 60, 
          buttonColor: ColorPalette.white, 
          buttonOnTap: (){},
          buttonBoxShadow: [
            BoxShadow(
              blurRadius: 5,
              color : Colors.black.withOpacity(.2)
            ) 
          ],
          buttonChild: SvgPicture.asset(
            "assets/icon/Github.svg",
          ),
        ),
        
      ]
    );
  }
}