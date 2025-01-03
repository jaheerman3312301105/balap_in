import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class WebSocketApi {
  static void connectWebSocket() {
    final WebSocketChannel channel = WebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:8000/ws/notifications/'),
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
