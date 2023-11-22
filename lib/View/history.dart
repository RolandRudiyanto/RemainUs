import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      appBar: AppBar(
        title: Text("About Us".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,),),
        centerTitle: true,
        leading: Image.asset("asstes/logo.png",width: 300.0,
          height: 300.0,),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Text("Halo"),
      ),
    );
  }
}
