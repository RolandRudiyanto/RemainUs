import 'package:flutter/material.dart';
import 'package:remainus/Database/database_helper.dart';
import 'package:remainus/Database/user_opration.dart';
import 'package:remainus/Model/user.dart';
import 'package:remainus/SinginSignUp/sing_in.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formState = GlobalKey<FormState>();
  final email = TextEditingController();
  final pasword = TextEditingController();
  final confirm = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmFocus = FocusNode();

  UserOprations _dbUser = UserOprations();


  var _isObscured;
  var _isOser;

  @override
  void initState(){
    super.initState();
    _isObscured = true;
    _isOser = true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child:Container(
          height: 600,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 25.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40.0)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 35,),
              Text("Sign In",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              SizedBox(height: 60,),
              Form(
                  key: _formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      SizedBox(height: 2,),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            hintText:"Enter email"
                        ),
                        validator: (value){
                          if(value == null || value!.isEmpty){
                            emailFocus.requestFocus();
                            return "Masukan Sesuatu!!!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 35,),
                      Text("Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      SizedBox(height: 2,),
                      TextFormField(
                        obscureText: _isObscured,
                        focusNode: passwordFocus,
                        keyboardType: TextInputType.emailAddress,
                        controller: pasword,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                padding: EdgeInsets.only(right: 12.0),
                                onPressed: (){
                                  setState(() {
                                    _isObscured =! _isObscured;
                                  });
                                },
                                icon: _isObscured ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)
                            ),
                            hintText:"Enter password"
                        ),
                        validator: (value){
                          if(value == null || value!.isEmpty){
                            passwordFocus.requestFocus();
                            return "Masukan Sesuatu!!!";
                          }
                          if(value.length < 8){
                            passwordFocus.requestFocus();
                            return "Minimal Password 8 Kata!";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 35,),
                      Text("Confirm Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      SizedBox(height: 2,),
                      TextFormField(
                        obscureText: _isOser,
                        focusNode: confirmFocus,
                        keyboardType: TextInputType.emailAddress,
                        controller: confirm,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                padding: EdgeInsets.only(right: 12.0),
                                onPressed: (){
                                  setState(() {
                                    _isOser =! _isOser;
                                  });
                                },
                                icon: _isOser ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off)
                            ),
                            hintText:"Enter password"
                        ),
                        validator: (value){
                          if(value == null || value!.isEmpty){
                            confirmFocus.requestFocus();
                            return "Masukan Sesuatu!!!";
                          }
                          if(value != pasword.text){
                            confirmFocus.requestFocus();
                            return "Password Berbeda!";
                          }
                          return null;
                        },
                      ),
                    ],
                  )
              ),

              SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () async {
                  if(_formState.currentState!.validate()){
                    User user = User(
                      emial: email.text,
                      password: pasword.text,
                    );
                    await _dbUser.insertUser(user);
                    Navigator.pop(context);
                  }
                },
                child:Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text("Sign Up",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
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
    );
  }
}
