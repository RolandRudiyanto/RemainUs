import 'package:flutter/material.dart';
import 'package:remainus/Database/user_opration.dart';
import 'package:remainus/SinginSignUp/about_us.dart';
import 'package:remainus/SinginSignUp/login.dart';

import '../Model/user.dart';
import '../menu.dart';
import 'package:quickalert/quickalert.dart';

class Provile extends StatefulWidget {
  const Provile({super.key});

  @override
  State<Provile> createState() => _ProvileState();
}

class _ProvileState extends State<Provile> {
  UserOprations? _Dbuser;

  late Future<List<User>> userList;


  @override
  void initState() {
    super.initState();
    _Dbuser = UserOprations();
    loadNotes();
  }

  loadNotes() async {
    userList = _Dbuser!.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      appBar: AppBar(
        title: Text("Profile".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Menu()));
          },
        ),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: userList,
            builder: (context, AsyncSnapshot<List<User>> snapshot){
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else{
                String? username = snapshot.data!.last.username;
                return Column(
                  children: <Widget>[
                    Image.asset("asstes/logo.png",width: 100.0,
                      height: 100.0,),
                    SizedBox(height: 50,),
                    Text(
                      username!.toUpperCase(),
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50, color: Colors.black),
                    ),
                    SizedBox(height: 50,),
                    Container(
                         width: MediaQuery.of(context).size.width - 50,
                        height: 450,
                         margin: EdgeInsets.only(bottom: 10),
                         decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.black),
                    ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 50,),
                          ElevatedButton(
                              onPressed: (){
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => AboutUs()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width - 70,
                                height: 100,
                                child: ListTile(
                                  title: Text("About Us",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  trailing: Icon(Icons.arrow_forward),
                                ),
                              )
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 70,
                            height: 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(width: 2, color: Colors.black),
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            width: MediaQuery.of(context).size.width - 70,
                            height: 100,
                            child: ListTile(
                              title: Text("Versi",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                              trailing: Text("1.0",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          ),
                          SizedBox(height: 30,),
                          ElevatedButton(
                            onPressed: () async {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.confirm,
                                text: 'Mau Keluar Beneran?',
                                confirmBtnText: 'Yes',
                                cancelBtnText: 'No',
                                confirmBtnColor: Colors.green,
                                onConfirmBtnTap: () {
                                  print('Confirmed');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => Login()),
                                  );
                                },

                              );
                            },
                            child:Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width-130,
                              child: Center(child: Text("Log-Out",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
            },
          ) ,
        ),
      ),
    );
  }
}
