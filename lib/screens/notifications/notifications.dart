import "package:flutter/material.dart";
import "package:pocket_pal/widgets/pocket_pal_menu_button.dart";


class NotificationsView extends StatelessWidget {
  const NotificationsView({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: PocketPalMenuButton(),
      ),
    );
  }
}