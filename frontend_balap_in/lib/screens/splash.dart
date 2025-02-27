// Nama File: splash.dart
// Deskripsi: File ini berfungsi untuk menampilkan efek splash pada saat ingin membuka aplikasi 
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal: Oct 31, 2024

import 'package:balap_in/api/api_service_pengguna.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    ApiServicePengguna().initToken();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacementNamed(context, '/home'); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: const Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image(
                    image: AssetImage('assets/images/wwww.png'),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Batam Lapor Infrastruktur',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: 250,
              child: Image(
                image: AssetImage('assets/images/elemen.jpeg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
