import 'package:flutter/material.dart';
import 'package:remainus/Database/user_opration.dart';
import 'package:remainus/Model/user.dart';
import 'package:remainus/SinginSignUp/about_us.dart';


class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formState = GlobalKey<FormState>();
  final email = TextEditingController();
  final pasword = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  late UserOprations _dbUser = UserOprations();

  var _isObscured;

  @override
  void initState(){
    super.initState();
    _isObscured = true;
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
                      Text("Username",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      SizedBox(height: 2,),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            hintText:"Enter username"
                        ),
                        validator: (value){
                          if(value!.isEmpty){
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
                          if(value!.isEmpty){
                            return "Masukan Sesuatu!!";
                          }
                          return null;
                        },
                      ),
                    ],
                  )
              ),
              SizedBox(height: 15,),
              Text("Forget password?",style: TextStyle(fontSize:15,color: Colors.grey),),
              SizedBox(height: 120,),
              ElevatedButton(
                onPressed: () async {
                  if(_formState.currentState!.validate()){
                    User? user = await _dbUser.signIn(
                      email.text,
                      pasword.text,
                    );
                    if(user != null) {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => AboutUs()));
                    }
                    else{
                      print("Email dan Password Salah!!");
                    }
                  }
                },
                child:Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text("Sign In",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
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

