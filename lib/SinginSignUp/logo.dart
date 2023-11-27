import 'dart:async';

import 'package:flutter/material.dart';
import 'package:remainus/SinginSignUp/login.dart';

class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  void initState(){
    super.initState();
    Timer(
      Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(BuildContext context)=> Login()))
    );
  }

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
