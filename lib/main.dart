
import 'package:flutter/material.dart';
import 'package:remainus/Model/user.dart';
import 'package:remainus/SinginSignUp/login.dart';
import 'package:remainus/SinginSignUp/logo.dart';
import 'package:remainus/View/input_item.dart';
import 'package:remainus/View/input_notes.dart';
import 'package:remainus/View/profile.dart';
import 'package:remainus/View/view_item.dart';

import 'Model/user.dart';
import 'View/home.dart';
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
          home:Logo(),
        );
      }
  }