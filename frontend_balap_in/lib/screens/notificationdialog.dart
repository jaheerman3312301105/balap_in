import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketNotification extends StatefulWidget {
  const WebSocketNotification({super.key});

  @override
  State<WebSocketNotification> createState() => _WebSocketNotificationState();
}

class _WebSocketNotificationState extends State<WebSocketNotification> {
  // Koneksi WebSocket
  late WebSocketChannel channel;

  @override
  void initState() {
    super.initState();

    // Membuka koneksi WebSocket
    channel = WebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:8000/ws/notifications/'), 
    );

    // Mendengarkan pesan dari WebSocket
    channel.stream.listen((message) {
      // Trigger notifikasi ketika pesan diterima
      createNotification(message);
    });
  }

  // Fungsi untuk menampilkan notifikasi
  void createNotification(String message) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        actionType: ActionType.Default,
        title: 'Perubahan Status',
        body: message, // Pesan yang diterima dari WebSocket
        roundedLargeIcon: true,
        largeIcon: 'resource://drawable/small_ic_launcher',
      ),
    );
  }

  @override
  void dispose() {
    // Pastikan untuk menutup koneksi WebSocket saat widget dibuang
    channel.sink.close();
    super.dispose();
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
            // Fungsi untuk memicu notifikasi secara manual (bisa dihilangkan jika tidak diperlukan)
            createNotification('Pesan Uji'); 
          },
          child: Icon(Icons.notifications),
        ),
      ),
    );
  }
}
