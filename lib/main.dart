
import 'package:flutter/material.dart';
import 'package:remainus/SinginSignUp/login.dart';

import 'menu.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
          theme: ThemeData(
            canvasColor: Colors.transparent,
            primaryColor: Color(0xff1ba0e2),
          ),
          debugShowCheckedModeBanner: false,
          home: Login(),
        );
      }
  }