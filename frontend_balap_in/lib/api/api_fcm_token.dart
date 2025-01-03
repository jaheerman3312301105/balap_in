import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class ApiFcmToken {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Mendapatkan token FCM
  Future<String?> getFcmToken() async {
    String? token = await messaging.getToken();
    print("FCM Token: $token");
    return token;
  }

  // Meminta izin untuk notifikasi
  Future<void> requestPermission() async {
    await messaging.requestPermission();
  }

  // Subscribe ke topik tertentu
  Future<void> subscribeToTopic(String topic) async {
    await messaging.subscribeToTopic(topic);
  }

  // Menangani pesan saat aplikasi berada di latar depan
  void handleForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Pesan diterima: ${message.notification?.title}, ${message.notification?.body}');

      // Menampilkan notifikasi menggunakan Awesome Notifications
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: message.notification?.title ?? 'Tidak Ada Judul',
          body: message.notification?.body ?? 'Tidak Ada Pesan',
          roundedLargeIcon: true,
          largeIcon: 'resource://drawable/small_ic_launcher',
          notificationLayout: NotificationLayout.BigText,
        ),
      );
    });
  }

  // Menangani pesan saat aplikasi berada di latar belakang
  void handleBackgroundMessages() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // Handler untuk pesan saat aplikasi berada di latar belakang atau tertutup
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print('Pesan saat aplikasi di latar belakang: ${message.notification?.title}, ${message.notification?.body}');
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'basic_channel',
        actionType: ActionType.Default,
        title: message.notification?.title ?? 'Tidak Ada Judul',
        body: message.notification?.body ?? 'Tidak Ada Pesan',
        roundedLargeIcon: true,
        largeIcon: 'resource://drawable/small_ic_launcher',
        notificationLayout: NotificationLayout.BigText,
      ),
    );
  }
}
