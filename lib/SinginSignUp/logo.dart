import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      body: Center(
      child: Image.asset("asstes/logo.png",width: 350.0,
        height: 350.0,),

    ),
    );
  }
}
