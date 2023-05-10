import "package:flutter/material.dart";
import "package:pocket_pal/widgets/pocket_pal_appbar.dart";


class NotificationsView extends StatelessWidget {
  const NotificationsView({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : SafeArea(
        child: Column(
          children : [
            const PocketPalAppBar(
              pocketPalTitle: "Notifications",
            )
          ]
        ),
      )
    );
  }
}