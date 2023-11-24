import 'package:flutter/material.dart';

import '../Model/barang.dart';

class InputItem extends StatefulWidget {


  @override
  State<InputItem> createState() => _InputItemState();
}

class _InputItemState extends State<InputItem> {
  final _formState = GlobalKey<FormState>();
  final cari = TextEditingController();
  final cariFocus = FocusNode();

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
                                              onPressed: (){
                                                setState(() {
                                                  total += belanja.harga;
                                                });
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                        duration: Duration(microseconds: 20000),
                                                        content: Text("Item Telah Dimasukan",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
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


