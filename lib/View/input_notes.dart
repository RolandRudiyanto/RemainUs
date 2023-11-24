import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:remainus/Database/note_operation.dart';
import 'package:remainus/Database/user_opration.dart';
import 'package:remainus/Model/notes.dart';
import 'package:remainus/Model/user.dart';
import 'package:remainus/View/home.dart';

import '../Database/database_helper.dart';
import '../menu.dart';

class InputNotes extends StatefulWidget {
  const InputNotes({super.key});

  @override
  State<InputNotes> createState() => _InputNotesState();
}

class _InputNotesState extends State<InputNotes> {
  final _formState = GlobalKey<FormState>();
  final date = TextEditingController();
  final tahun = TextEditingController();
  final nama = TextEditingController();
  final dateFocus = FocusNode();
  final tahunFocus = FocusNode();
  final namaFocus = FocusNode();





  // List<User> user = UserOprations().getUser() as List<User>;

  NoteOprational _dbNote = NoteOprational();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      appBar: AppBar(
            title: Text("NOTES".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,),),
            centerTitle: true,

            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width-50,
              child: Center(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 150,),
                    Form(
                      key: _formState,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Tanggal".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,)),
                              SizedBox(height: 10,),
                              TextFormField(
                                  controller: date,
                                  decoration:InputDecoration(
                                      border:OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: "Masukan Tanggal",
                                      suffixIcon: IconButton(
                                          onPressed: () async {
                                            DateTime? datepiker = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2023),
                                                lastDate: DateTime(2030));
                                            if(datepiker != null){
                                              String formatDate = DateFormat("dd-MM-yyyy").format(datepiker);
                                              String formatYear = DateFormat("yyyy").format(datepiker);
                                              setState(() {
                                                date.text= formatDate;
                                                tahun.text=formatYear;
                                              });
                                            }
                                            else{
                                              date.text ="";
                                            }
                                          },
                                          icon: Icon(Icons.date_range_outlined)
                                      )
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Masukan Sesuatu!";
                                    }
                                    return null;
                                  },
                                ),
                              SizedBox(height: 50,),
                              Text("Judul".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold,)),
                              SizedBox(height: 10,),
                              TextFormField(
                                controller: nama,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: "Masukan Judul",
                                ),
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Masukan Sesuatu!";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(height: 50,),
                    ElevatedButton(
                      onPressed: () async {
                        if(_formState.currentState!.validate()){
                          List<User> user = await UserOprations().getUser();
                          String? username = user.last.username;
                          Notes note = Notes(
                            name: nama.text,
                            date: date.text,
                            year: tahun.text,
                            username: username
                          );
                          await _dbNote.insertNotes(note);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Menu()));
                          // print("${nama.text},${date.text},${tahun.text},${email}");
                        }
                      },
                      child:Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width-200,
                        child: Center(child: Text("Next".toUpperCase(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xff08457e),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )
                      ),
                    )
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
