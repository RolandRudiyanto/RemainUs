import 'package:flutter/material.dart';
import 'package:remainus/Database/database_helper.dart';
import 'package:remainus/Database/note_operation.dart';
import 'package:remainus/Database/user_opration.dart';
import 'package:remainus/Model/user.dart';

import '../Model/notes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user = User();

  NoteOprational? _dbNote;
  late Future<List<Notes>> noteList;

  @override
  void initState(){
    super.initState();
    _dbNote = NoteOprational();
    loadNotes();
  }

  loadNotes() async{
    noteList = _dbNote!.getNotes();
  }


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
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 400,
            child: NotesData(),
          ),
        ],
      )
    );
  }

  Container NotesData() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Expanded(child:
          FutureBuilder(
              future: noteList,
              builder: (context,AsyncSnapshot<List<Notes>> snapshot){
                if(!snapshot.hasData || snapshot.data == null){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if(snapshot.data!.length == 0){
                  return SafeArea(
                    child:Column(
                        children: [
                          Container(
                              margin: const EdgeInsets.all(10.0),
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: Colors.black,width: 5,style: BorderStyle.solid),
                              ),
                              child: Center(
                                child: Container(
                                  child: Text("TIDAK ADA DATA!",style: TextStyle(fontSize: 25,),textAlign: TextAlign.left,),
                                ),
                              )
                          ),
                        ]
                    ),
                  );
                }
                else{
                  return SafeArea(
                      child: PageView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index){
                          String nama = snapshot.data![index].name.toString();
                          String date = snapshot.data![index].date.toString();
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(color: Colors.black,width: 5,style: BorderStyle.solid),
                                  color: Colors.white
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget> [
                                    Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 0)),
                                    Container(
                                      width: 350,
                                      child: Text(date.toUpperCase(),style: TextStyle(fontSize: 15,color: Colors.black),textAlign: TextAlign.left,),
                                    ),
                                    Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                    Container(
                                        width: 350,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget> [
                                            Text(nama.toUpperCase(),style: TextStyle(fontSize: 25,color: Colors.black),textAlign: TextAlign.left,),
                                          ],
                                        )
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(padding: const EdgeInsets.fromLTRB(17.5, 0, 0, 0)),
                                        Container(
                                          width: 100,
                                          child: ElevatedButton(onPressed: (){
                                          },
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(Icons.edit),
                                                  Text("Edit"),
                                                ],
                                              )
                                          ),
                                        ),
                                        Padding(padding: const EdgeInsets.fromLTRB(15, 0, 0, 0)),
                                        Container(
                                          width: 100,
                                          child: ElevatedButton(onPressed: (){
                                          },
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(Icons.view_agenda_outlined),
                                                  Text("View"),
                                                ],
                                              )
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      )
                  );
                }
              }
          ))
        ],
      ),
  );
  }
}
