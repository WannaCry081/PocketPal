import "package:flutter/material.dart";
import "package:pocket_pal/screens/dashboard/widgets/card_widget.dart";
import "package:pocket_pal/screens/dashboard/widgets/search_bar_widget.dart";


class DashboardView extends StatelessWidget {
  const DashboardView({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : SafeArea(
        child : SingleChildScrollView(
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children : [
              
              const MySearchBarWidget(),
              const MyCardWidget(),

              
            ]
          )
        )
      )
    );
  }
}

