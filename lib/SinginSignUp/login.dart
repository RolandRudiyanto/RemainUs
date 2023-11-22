import 'package:flutter/material.dart';
import 'package:remainus/SinginSignUp/sing_in.dart';
import 'package:remainus/SinginSignUp/sing_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      body: SafeArea(
          bottom: false,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: <Widget>[
              Image.asset("asstes/logo.png",width: 350.0,
                height: 350.0,),
              SizedBox(height: 55,),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 200,
                child: ElevatedButton(
                    onPressed: (){
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context){
                            return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                              return Wrap(
                                children: <Widget>[
                                  Container(
                                    color: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
                                      ),
                                      child: SignIn(),
                                    ),

                                  )
                                ],
                              );
                            });
                          },
                      );
                    },
                    child: Text("Sign In",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff08457e),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        )
                    ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width - 200,
                child: ElevatedButton(
                  onPressed: (){
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context){
                        return StatefulBuilder(builder: (BuildContext context, StateSetter setState){
                          return Wrap(
                            children: <Widget>[
                              Container(
                                color: Colors.transparent,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
                                  ),
                                  child: SignUp(),
                                ),

                              )
                            ],
                          );
                        });
                      },
                    );
                  },
                  child: Text("Sign Up",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0xff08457e),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      )
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}

