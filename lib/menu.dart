import 'package:flutter/material.dart';
import 'package:remainus/View/history.dart';
import 'package:remainus/View/home.dart';
import 'package:remainus/View/input_notes.dart';

import 'Model/user.dart';

class Menu extends StatefulWidget {

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedItem=0;
  static List<Widget> _page=<Widget>[
    Home(),
    History()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _page.elementAt(_selectedItem),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => InputNotes()));
          },
          backgroundColor: Colors.white,
          child: Icon(Icons.add,color: Colors.black,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0x801b9fe1),
        items:<BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,color: Colors.black,),
            label: "Home",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.history,color: Colors.black),
            label: "History",
          )
        ],
        currentIndex: _selectedItem,
        onTap: (setValue){
            setState(() {
          _selectedItem=setValue;
            });
        },
      ),
    );
  }
}
