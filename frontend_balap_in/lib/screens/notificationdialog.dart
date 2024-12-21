import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class TestNotification extends StatefulWidget {
  const TestNotification({super.key});

  @override
  State<TestNotification> createState() => _TestNotificationState();
}

class _TestNotificationState extends State<TestNotification> {

  // Fungsi untuk mengambil pesan dari API dan menampilkan notifikasi
  static Future<void> createNewNotification() async {
    try {
      // Inisialisasi Dio untuk melakukan request ke API
      Dio dio = Dio();
      String url = 'http://10.0.2.2:8000/notifikasi/pesan/'; // Gantilah dengan URL API yang sesuai

      // Melakukan GET request
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        String message = response.data['message']; // Ambil pesan dari respons

        // Memeriksa apakah izin notifikasi sudah diberikan
        bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
        if (!isAllowed) return;

        // Menampilkan notifikasi dengan pesan yang diterima dari API
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            actionType: ActionType.Default,
            title: 'Perubahan Status',
            body: message, // Gunakan pesan dari API
            roundedLargeIcon: true,
            largeIcon: 'resource://drawable/small_ic_launcher',
          ),
        );
      } else {
        print("Gagal mendapatkan pesan rekomendasi: ${response.statusCode}");
      }
    } catch (e) {
      print("Terjadi kesalahan saat mengambil data dari API: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FloatingActionButton(
          hoverColor: Colors.purple,
          backgroundColor: Colors.red,
          onPressed: () {
            createNewNotification(); // Memanggil fungsi untuk menampilkan notifikasi
          },
          child: Icon(Icons.notifications),
        ),
      ),
    );
  }
}
