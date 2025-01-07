// Nama File: main.dart
// Deskripsi: File ini bertujuan sebagai awal inisialisasi dari aplikasi serta routing halaman frontend
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal: Oct 31, 2024

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'api/api_fcm_token.dart';
import 'api/api_websocket.dart'; 
import 'screens/splash.dart';
import 'screens/homepage.dart';
import 'screens/tutorial.dart';
import 'screens/lapor.dart';
import 'screens/rekomendasi.dart';
import 'screens/isilapor.dart';
import 'screens/isirekomendasi.dart';
import 'screens/notifikasi.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  // memastikan widget diinisialisasi
  WidgetsFlutterBinding.ensureInitialized();
  // inisialisasi firebase
  await Firebase.initializeApp(); 

  // Firebase token
  ApiFcmToken apiFcmToken = ApiFcmToken();

  // Meminta izin untuk notifikasi dan mendapatkan token
  await apiFcmToken.requestPermission();
  await apiFcmToken.subscribeToTopic('global_notifications');
  
  String? token = await apiFcmToken.getFcmToken();
  print("FCM Token: $token");

  // Menangani pesan ketika aplikasi berada di latar depan dan latar belakang
  apiFcmToken.handleForegroundMessages();
  apiFcmToken.handleBackgroundMessages();

  // Menampilkan notifikasi saat aplikasi berada di latar depan atau latar belakang
  initializeNotifications();

  // Mulai WebSocket untuk komunikasi real-time
  WebSocketApi.connectWebSocket();

  runApp(MyApp());
}

// Inisialisasi notifikasi
void initializeNotifications() {
  AwesomeNotifications().initialize(
    'resource://drawable/small_ic_launcher',
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Colors.blue,
        ledColor: Colors.white,
        icon: 'resource://drawable/small_ic_launcher',
        enableVibration: true,
        importance: NotificationImportance.High
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group',
      ),
    ],
    debug: true,
  );

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: (receivedAction) async {
      MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/rekomendasi',
        (route) => (route.settings.name != '/rekomendasi') || route.isFirst,
        arguments: receivedAction,
      );
    },
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Hallo, Selamat Datang di BALAP-IN',
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/tutorial': (context) => const Tutorial(),
        '/lapor': (context) => const LaporScreen(),
        '/isilapor': (context) => const IsilaporScreen(),
        '/rekomendasi': (context) => const RecommendationsScreen(),
        '/isirekomendasi': (context) => const IsiRekomendasiScreen(),
        '/notifikasi': (context) => const NotificationsScreen(),
      },
    );
  }
}
