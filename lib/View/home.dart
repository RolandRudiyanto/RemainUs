import 'package:flutter/material.dart';
import 'package:remainus/Database/note_operation.dart';
import 'package:remainus/View/edit_item.dart';
import 'package:remainus/View/profile.dart';
import '../Database/total_operation.dart';
import '../Database/user_opration.dart';
import '../Model/notes.dart';
import '../Model/total.dart';
import '../Model/user.dart';
import 'view_item.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  NoteOprational? _dbNote;
  TotalOperation? _dbTotal;
  UserOprations? _dbUser;

  late Future<List<Notes>> noteList;
  late Future<List<Total>> tahunList;
  late Future<List<User>> userList;


  @override
  void initState() {
    super.initState();
    _dbNote = NoteOprational();
    _dbTotal = TotalOperation();
    _dbUser = UserOprations();
    loadNotes();
  }

  loadNotes() async {
    noteList = _dbNote!.getNotes();
    tahunList = _dbTotal!.getTotal();
    userList = _dbUser!.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      appBar:
      PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: FutureBuilder(
          future: userList,
          builder: (context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AppBar(
                title: Text('Loading...'),
              );
            } else if (snapshot.hasError) {
              return AppBar(
                title: Text('Error: ${snapshot.error}'),
              );
            } else {
              String? username = snapshot.data!.last.username;
              return AppBar(
                actions: <Widget>[
                  Center(
                    child:TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Provile()
                          ),
                        );
                      },
                      child: Text(
                        username!.toUpperCase(),
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black),
                      ),
                    )
                  ),
                  SizedBox(width: 30),
                ],
                leading: Container(
                  child: Image.asset("asstes/logo.png", width: 300, height: 300),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              );
            }
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: NotesData(),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 50,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(width: 2, color: Colors.black),
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20,),
            tahunBuid(),

          ],
        ),
      ),
    );
  }

  Widget tahunBuid() {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width-30,
          height: 450,
          child: FutureBuilder(
            future: tahunList,
            builder: (context, AsyncSnapshot<List<Total>> snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data!.isEmpty) {
                return Container(
                  width: MediaQuery.of(context).size.width - 50,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.black),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(width: 5,),
                        Text("Tahun : -", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        Text("Rp.-", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context,index){
                      return Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: 100,
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: Colors.black),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(width: 5,),
                              Text("Tahun : ${snapshot.data![index].year.toString()}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                              Text(
                                "Rp.${snapshot.data![index].totalAmount.toString()}",
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 10,),
                            ],
                          ),
                        ),
                      );
                    }
                );
              }
            },
          ),
        ),
      )
    );
  }


  Container NotesData() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Expanded(
            child: FutureBuilder(
              future: noteList,
              builder: (context, AsyncSnapshot<List<Notes>> snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.isEmpty) {
                  return SafeArea(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(10.0),
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.black, width: 5, style: BorderStyle.solid),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Container(
                              child: Text(
                                "TIDAK ADA DATA!",
                                style: TextStyle(fontSize: 25),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              String nama = snapshot.data![index].name.toString();
                              String date = snapshot.data![index].date.toString();
                              return Column(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.all(10.0),
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(color: Colors.black, width: 5, style: BorderStyle.solid),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(padding: const EdgeInsets.fromLTRB(0, 20, 0, 0)),
                                        Container(
                                          width: 350,
                                          child: Text(
                                            date.toUpperCase(),
                                            style: TextStyle(fontSize: 15, color: Colors.black),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 0)),
                                        Container(
                                          width: 350,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                nama.toUpperCase(),
                                                style: TextStyle(fontSize: 25, color: Colors.black),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(padding: const EdgeInsets.fromLTRB(17.5, 0, 0, 0)),
                                            Container(
                                              width: 100,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => EditItem(note: snapshot.data![index]),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.edit),
                                                    Text("Edit"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(padding: const EdgeInsets.fromLTRB(15, 0, 0, 0)),
                                            Container(
                                              width: 100,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ViewItem(note: snapshot.data![index]),
                                                    ),
                                                  );
                                                },
                                                child: Row(
                                                  children: <Widget>[
                                                    Icon(Icons.view_agenda_outlined),
                                                    Text("View"),
                                                  ],
                                                ),
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
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
