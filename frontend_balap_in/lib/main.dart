import 'package:balap_in/screens/isilapor.dart';
import 'package:balap_in/screens/isirekomendasi.dart';
import 'package:balap_in/screens/notifikasi.dart';
import 'package:balap_in/screens/splash.dart';
import 'package:balap_in/screens/notificationdialog.dart';
import 'package:flutter/material.dart';
import 'screens/homepage.dart';
import 'screens/tutorial.dart';
import 'screens/lapor.dart'; 
import 'screens/rekomendasi.dart'; 
import 'package:awesome_notifications/awesome_notifications.dart';

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

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeNotifications();
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
        '/testnotifikasi' : (context) => const WebSocketNotification(),
      },
    );
  }
}