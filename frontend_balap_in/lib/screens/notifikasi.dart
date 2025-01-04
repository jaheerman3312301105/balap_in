// Nama File: notifikasi.dart
// Deskripsi: File ini berfungsi untuk menampilkan halaman notifikasi
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal: Nov 3, 2024

import 'package:balap_in/widgets/notifikasiwidget.dart';
import 'package:flutter/material.dart';


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();

}

class _NotificationsScreenState extends State<NotificationsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
             Navigator.of(context).pop();
          }, 
          icon: const Icon(Icons.keyboard_arrow_left),
          color: const Color.fromRGBO(5, 5, 5, 0.612),
          iconSize: 40,),
          title: const Row(
          children: [
            Text('Pemberitahuan',
            style: TextStyle(
              color: Color.fromRGBO(5, 5, 5, 0.612),
              fontSize: 18.0,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 6.0),
                        blurRadius: 10,
                        color: Colors.black26,
                      ),
              ]
            ),
            ),
          ],
        ),
      ),
      
      body: Stack(
        children: [
          Positioned(
            top: -50, 
            left: -75,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                color: Color(0xFFF7E0E0),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.87,
              child: ListView(
                children: const [
                  WidgetNotification()
                ],
              )
            )
          )
        ],
      ),

    );
  }
}