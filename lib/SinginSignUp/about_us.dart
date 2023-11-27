import 'package:flutter/material.dart';
import 'package:remainus/Model/user.dart';
import 'package:remainus/View/profile.dart';
import 'package:remainus/menu.dart';

class AboutUs extends StatefulWidget {
  // final User user;
  // AboutUs({required this.user});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1ba0e2),
      appBar: AppBar(
        title: Text("About Us".toUpperCase(),style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,),),
        centerTitle: true,
        leading: BackButton(
          onPressed: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Provile()));
          },
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width-100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 100,),
                Text('Remind Us adalah sebuah aplikasi pintar yang dirancang untuk '
                      'membantu Anda mengelola dan mengatur pengeluaran bulanan '
                      'Anda dengan mudah dan efisien. Dengan fitur-fitur yang '
                      'disediakan, Remind Us membantu Anda menjaga kendali atas '
                      'keuangan pribadi Anda, merencanakan anggaran, dan '
                      'menghindari pemborosan yang tidak perlu. '
                      'Aplikasi ini menjadi teman setia Anda dalam perjalanan '
                      'mencapai stabilitas keuangan.',
                  textAlign: TextAlign.justify
                ),
                SizedBox(height: 50,),
                   Text('Fitur Utama:', textAlign: TextAlign.start,),
                   Text(
                       '1. Pemantauan Pengeluaran: Remind Us memungkinkan Anda untuk mencatat dan memantau semua transaksi keuangan Anda. Anda dapat dengan cepat dan mudah menginput pengeluaran sehari-hari, baik yang besar maupun kecil.'
                           ,textAlign: TextAlign.justify,
                   ),
                   Text(
                       '2. Anggaran Bulanan: Anda dapat membuat anggaran bulanan yang sesuai dengan kebutuhan Anda. Aplikasi ini akan memberi tahu Anda ketika Anda mendekati atau melebihi batas anggaran yang telah ditetapkan.'
                     ,textAlign: TextAlign.justify,
                   ),
                   Text(
                       '3. Analisis Keuangan: Aplikasi ini menyediakan grafik dan laporan yang membantu Anda memahami pola pengeluaran Anda. Anda dapat melihat tren keuangan Anda dari waktu ke waktu.'
                     ,textAlign: TextAlign.justify,
                   ),
                SizedBox(height: 60,),
               Container(
                 child: Center(
                   child: Text("Versi : 1.0",style: TextStyle(color: Colors.white),),
                 ),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
