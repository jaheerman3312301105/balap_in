// Nama File: api_websocket.dart
// Deskripsi: File ini berfungsi untuk menangani layanan websocket notifikasi 
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal: Dec 20, 2024

import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class WebSocketApi {
  static void connectWebSocket() {
    final WebSocketChannel channel = WebSocketChannel.connect(
      Uri.parse('wss://2d97-180-252-48-10.ngrok-free.app/ws/notifications/'),
    );

    channel.stream.listen((message) {
      try {
        var decodedMessage = jsonDecode(message);
        String messageValue = decodedMessage['message'];

        // Menampilkan notifikasi menggunakan Awesome Notifications
        AwesomeNotifications().createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            actionType: ActionType.Default,
            title: 'Menjadi Sorotan Masyarakat Batam!',
            body: messageValue,
            roundedLargeIcon: true,
            largeIcon: 'resource://drawable/small_ic_launcher',
            notificationLayout: NotificationLayout.BigText,
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
}
