import "package:flutter/material.dart";


class LoadingPage extends StatelessWidget {
  const LoadingPage({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xFF263238),
      body: Center(child: SvgPicture.asset('assets/loading.svg', width: 150, height: 150))
    );
  }
}