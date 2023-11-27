import 'package:flutter/material.dart';
import 'package:remainus/Database/item_opration.dart';
import 'package:remainus/Database/note_operation.dart';
import 'package:remainus/Database/total_operation.dart';
import 'package:remainus/Model/belanja_item.dart';
import 'package:remainus/Model/notes.dart';
import 'package:remainus/menu.dart';

import '../Database/user_opration.dart';
import '../Model/barang.dart';
import '../Model/total.dart';
import '../Model/user.dart';

class InputItem extends StatefulWidget {

  // final Notes note;
  //
  // InputItem({required this.note});


  @override
  State<InputItem> createState() => _InputItemState();
}

class _InputItemState extends State<InputItem> {
  final _formState = GlobalKey<FormState>();
  final cari = TextEditingController();
  final cariFocus = FocusNode();

  // final Notes note;
  //
  // _InputItemState({required this.note});

  ItemOprational _Dbitem = ItemOprational();
  NoteOprational _Dbnotes = NoteOprational();
  TotalOperation _Dbtotal = TotalOperation();

  int total = 0;
  List<Barang> _filterBarang = [];

  @override
  void initState(){
    super.initState();
    _filterBarang = barang;
  }

  void filterBarang(String query){
    List<Barang> _filterBelanja = barang.where((belanja) => belanja.nama.toLowerCase().contains(query.toLowerCase())).toList();
    setState(() {
      _filterBarang = _filterBelanja;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      appBar: AppBar(
        title: Text("Barang".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width-50,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Form(
                    key: _formState,
                    child: TextFormField(
                      controller: cari,
                      decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Cari Barang",
                          suffixIcon: Icon(Icons.search)
                      ),
                      onChanged: (query) => filterBarang(query),
                    ),
                  ),
                  SizedBox(height: 30,),
                  Container(
                    width: MediaQuery.of(context).size.width-50,
                    height: 590,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white
                    ),
                    child: Column(
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30,),
                              Container(
                                width: MediaQuery.of(context).size.width-100,
                                height: 400,
                                child: ListView.builder(
                                    itemCount: _filterBarang.length,
                                    itemBuilder: (context,index){
                                      final belanja = _filterBarang[index];
                                      return Container(
                                        child: ListTile(
                                          leading: Image.asset(belanja.gambarPath,width: 70,height: 70,),
                                          title: Text(belanja.nama,style: TextStyle(fontWeight: FontWeight.bold)),
                                          subtitle: Text('Harga: \Rp.${belanja.harga}'),
                                          trailing: IconButton(
                                              onPressed: () async {
                                                setState(() {
                                                  total += belanja.harga;
                                                  belanja.quantity += 1;
                                                });
                                                List<Notes> notes = await NoteOprational().getNotes();
                                                int? id = notes.last.noteId;
                                                Belanja item = Belanja(
                                                  name: belanja.nama,
                                                  harga: belanja.harga,
                                                  img: belanja.gambarPath,
                                                  noteId: id,
                                                  quantity: belanja.quantity
                                                );
                                                await _Dbitem.insertOrUpdateItem(item);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                        duration: Duration(microseconds: 20000),
                                                        content: Text("Item Telah Dimasukan ${belanja.quantity}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                                                        backgroundColor: Colors.red,
                                                    )
                                                );
                                              },
                                              icon: Icon(Icons.add))
                                        ),
                                      );
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
                              SizedBox(height: 15,),
                              Container(
                                width: MediaQuery.of(context).size.width-150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Total Harga :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    Text(total.toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                              SizedBox(height: 25,),
                              ElevatedButton(
                                onPressed: () async {
                                  List<Notes> notes = await NoteOprational().getNotes();
                                  int? id = notes.last.noteId;
                                  List<User> user = await UserOprations().getUser();
                                  int? userid = user.last.userId;
                                  Total amount = Total(
                                    userId: userid,
                                    totalAmount: total,
                                    year: notes.last.year
                                  );
                                  await _Dbtotal.updateOrInsertNotes(amount);
                                  await _Dbnotes.updateUser(id,total);
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context) => Menu()));
                                    // print("${nama.text},${date.text},${tahun.text},${email}");
                                },
                                child:Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width-200,
                                  child: Center(child: Text("Save".toUpperCase(),style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xff08457e),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    )
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  )

                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}


