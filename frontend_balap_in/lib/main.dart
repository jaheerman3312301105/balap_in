import 'package:balap_in/screens/isilapor.dart';
import 'package:balap_in/screens/isirekomendasi.dart';
import 'package:balap_in/screens/notifikasi.dart';
import 'package:balap_in/screens/splash.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'screens/homepage.dart';
import 'screens/tutorial.dart';
import 'screens/lapor.dart'; 
import 'screens/rekomendasi.dart'; 
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
        enableVibration: true
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic group'
      )
    ],
    debug: true
  );

  AwesomeNotifications().setListeners(
    onActionReceivedMethod: (receivedAction) async {
      MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/rekomendasi',
        (route) => (route.settings.name != '/rekomendasi') || route.isFirst,
        arguments: receivedAction
      );
    }
  );
}

void connectWebSocket() {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://10.0.2.2:8000/ws/notifications/'), 
  );

    channel.stream.listen((message) {
    try {
      var decodedMessage = jsonDecode(message);

      String messageValue = decodedMessage['message'];

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: 'Menjadi Sorotan Masyarakat Batam',
          body: messageValue, 
          roundedLargeIcon: true,
          largeIcon: 'resource://drawable/small_ic_launcher',
        ),
      );
    } catch (e) {
      print("Terjadi error saat parsing JSON: $e");
    }
  }, onError: (error) {
    print("Terjadi error pada WebSocket: $error");
  }, onDone: () {
    print("Koneksi WebSocket ditutup");
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeNotifications();
  connectWebSocket(); 
  runApp(MyApp());
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
