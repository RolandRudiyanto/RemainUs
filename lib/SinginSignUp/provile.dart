import 'package:flutter/material.dart';
import 'package:remainus/Database/user_opration.dart';
import 'package:remainus/Model/user.dart';
import 'package:remainus/SinginSignUp/about_us.dart';

class Profile extends StatefulWidget {

  // final User user;
  // Profile({required this.user});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formState = GlobalKey<FormState>();
  final username = TextEditingController();

  UserOprations _dbUser = UserOprations();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      appBar: AppBar(
        title: Text("Edit Prifile".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,),),
        centerTitle: true,
        leading: Image.asset("asstes/logo.png",width: 300.0,
          height: 300.0,),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("asstes/provpic.png",width: 300.0,
                  height: 300.0,),
                SizedBox(height: 50,),
                Form(
                  key: _formState ,
                    child: TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        hintText:"Enter Username"
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "Masukan Sesuatu!!!";
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(height: 60,),
                ElevatedButton(
                  onPressed: () async {
                    if(_formState.currentState!.validate()){
                      User user = User(
                        username: username.text,
                      );
                      await _dbUser.updateUser(user);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => AboutUs()));
                    }
                  },
                  child:Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width-150,
                    child: Center(child: Text("Continue",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}


