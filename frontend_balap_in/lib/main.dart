import 'package:balap_in/screens/isilapor.dart';
import 'package:balap_in/screens/isirekomendasi.dart';
import 'package:balap_in/screens/notifikasi.dart';
import 'package:balap_in/screens/splash.dart';
import 'package:flutter/material.dart';
import 'screens/homepage.dart';
import 'screens/tutorial.dart';
import 'screens/lapor.dart'; 
import 'screens/rekomendasi.dart'; 

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hallo, Selamat Datang di BALAP-IN',
      home: const SplashScreen(),
      routes: {
        '/home':(context) => const HomeScreen(),
        '/tutorial': (context) => const Tutorial(),
        '/lapor':(context) => const LaporScreen(),
        '/isilapor':(context) => const IsilaporScreen(),
        '/rekomendasi':(context) => const RecommendationsScreen(),
        '/isirekomendasi':(context) => const IsiRekomendasiScreen(),
        '/notifikasi':(context) => const NotificationsScreen(),
      },
    );
  }
}
