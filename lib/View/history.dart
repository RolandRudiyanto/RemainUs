import 'package:flutter/material.dart';
import 'package:remainus/View/view_item.dart';

import '../Database/note_operation.dart';
import '../Model/notes.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {

  NoteOprational? _dbNote;


  late Future<List<Notes>> noteList;



  @override
  void initState() {
    super.initState();
    _dbNote = NoteOprational();
    loadNotes();
  }

  loadNotes() async {
    noteList = _dbNote!.getNotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      appBar: AppBar(
        title: Text("History".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,),),
        centerTitle: true,
        leading: Image.asset("asstes/logo.png",width: 300.0,
          height: 300.0,),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future :noteList,
            builder: (context,AsyncSnapshot<List<Notes>> snapshot){
              if (!snapshot.hasData || snapshot.data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              else if(snapshot.data!.isEmpty){
                return Center(
                  child: Text(
                    "TIDAK ADA Notes!",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.left,
                  ),
                );
              }
              else{
                return SafeArea(
                  child: ListView.builder(
                      shrinkWrap: false,
                      itemCount: snapshot.data?.length,
                      itemBuilder:(context,index){
                        int? dataId = snapshot.data![index].noteId?.toInt();
                        return Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10.0),
                                height: 140,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0)
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget> [
                                        Container(
                                            width: 230,
                                            margin: EdgeInsets.fromLTRB(20, 30, 10, 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget> [
                                                Text(snapshot.data![index].date.toString().toUpperCase(),style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                                Text(snapshot.data![index].name.toString().toUpperCase(),style: TextStyle(fontSize: 30,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                                Text('Rp.${snapshot.data![index].total.toString().toUpperCase()}',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                                              ],
                                            )
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0,20, 20, 10),
                                      child: Column(
                                        children: [
                                          Dismissible(
                                            key: ValueKey<int>(dataId!),
                                            child:  ElevatedButton(
                                                style: ElevatedButton.styleFrom(primary: Colors.red),
                                                onPressed: (){
                                                  setState(() {
                                                    _dbNote!.delete(dataId);
                                                    noteList =_dbNote!.getNotes();
                                                    snapshot.data!.remove(snapshot.data![index]);
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(Icons.delete),
                                                    Text("Delete",style: TextStyle(fontSize: 15),)
                                                  ],
                                                )
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ]
                        );
                      }
                  ),
                );
              }
            },
          ) ,
        ),
      )
    );
  }
}
