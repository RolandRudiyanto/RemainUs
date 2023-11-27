import 'package:flutter/material.dart';
import 'package:remainus/Database/item_opration.dart';
import 'package:remainus/Database/note_operation.dart';
import 'package:remainus/Model/belanja_item.dart';
import 'package:remainus/Model/notes.dart';
import 'package:remainus/Model/user.dart';
import 'package:remainus/menu.dart';

class ViewItem extends StatefulWidget {
  final Notes note;

  ViewItem({required this.note});

  @override
  State<ViewItem> createState() => _ViewItemState(note: note);
}

class _ViewItemState extends State<ViewItem> {

  ItemOprational? _dbItem;
  NoteOprational? _dbNote;

  final Notes note;

  _ViewItemState({required this.note});

  late Future<List<Belanja>> belanja;
  late Future<List<Notes>> notelist;


  @override
  void initState(){
    super.initState();
    _dbItem = ItemOprational();
    _dbNote = NoteOprational();
    loadNotes();
  }

  loadNotes() async{
    belanja = _dbItem!.getItemByNotes(note.noteId);
    notelist = _dbNote!.getNotesByNotes(note.noteId);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      appBar: AppBar(
        title: Text("View".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,),),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width-20,
              height: 700,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white
              ),
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 500,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: Colors.black,width: 3),
                    ),
                    child: FutureBuilder(
                        future: belanja,
                        builder: (context,AsyncSnapshot<List<Belanja>> snapshot){
                          if(!snapshot.hasData || snapshot.data == null){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          else{
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index){
                                  return ListTile(
                                    leading: Image.asset(snapshot.data![index].img.toString(),width: 70,height: 70,),
                                    title: Text(snapshot.data![index].name.toString()),
                                    subtitle: Text('Harga: ${snapshot.data![index].harga.toString()}'),
                                    trailing: Text(snapshot.data![index].quantity.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  );
                                }
                            );
                          }
                        }
                        ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width-100,
                    height: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(width: 2, color: Colors.black),
                        color: Colors.black
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 50,
                    child: FutureBuilder(
                      future: notelist,
                      builder: (context,AsyncSnapshot<List<Notes>> snapshot){
                        if(!snapshot.hasData || snapshot.data == null){
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        else{
                          return Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(width: 5,),
                                  Text("Total :", style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),),
                                  Text("Rp.${snapshot.data!.last.total.toString()}", style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),),
                                  SizedBox(width: 10,),
                                ],
                            ),
                          );
                        }
                      }
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}
