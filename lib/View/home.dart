import 'package:flutter/material.dart';
import 'package:remainus/Database/database_helper.dart';
import 'package:remainus/Database/user_opration.dart';
import 'package:remainus/Model/user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user = new User();
  // List<User> _userlist =[];

  late UserOprations _dbUser = UserOprations();

  // void iniState(){
  //   super.initState();
  //   _dbUser =DatabaseHelper.instance as UserOprations;
  //   _refreshContactList();
  // }
  //
  // _refreshContactList() async{
  //   List<User> x = await _dbUser.getUser();
  //   setState(() {
  //     _userlist = x!;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      appBar: AppBar(
        actions: <Widget>[
          Padding(padding: EdgeInsets.only(left: 20)),
          Row(
            children: [
              Center(
                child: Text("${user.username}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.black),)
              ),
              Padding(padding: EdgeInsets.only(left: 20)),
              Image.asset("asstes/provpic.png",),
            ],
          )
        ],
        leading: Container(
          child: Image.asset("asstes/logo.png",width: 300,height: 300,),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    body: Center(
      child: Text("Halo"),
    ),
    );
  }
}
