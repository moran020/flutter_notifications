import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NotificationApp(),
    );
  }
}

class NotificationApp extends StatefulWidget {
  const NotificationApp({Key? key}) : super(key: key);

  @override
  _NotificationAppState createState() => _NotificationAppState();
}

class _NotificationAppState extends State<NotificationApp> {
  //объект уведомления
  late FlutterLocalNotificationsPlugin localNotifications;

  //инициализация
  @override
  void initState() {
    super.initState();
    //объект для Android настроек
    AndroidInitializationSettings androidInitialize =
        const AndroidInitializationSettings('ic_launcher');
    //объект для IOS настроек
    const IOSInitializationSettings iosInitialize = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    // общая инициализация
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    //мы создаем локальное уведомление
    FlutterLocalNotificationsPlugin localNotifications =
        FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializationSettings);
  }

// уведомление каждую минуту
  Future shownotifications() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      "ID",
      "Название уведомления",
      importance: Importance.high,
      channelDescription: "Контент уведомления",
    );

    const IOSNotificationDetails iosDetails = IOSNotificationDetails();

    NotificationDetails platformChannelSpecifics =
        const NotificationDetails(android: androidDetails, iOS: iosDetails);
    await FlutterLocalNotificationsPlugin().periodicallyShow(
        0,
        'Ежедневное уведомление',
        'Время заняться программированием!',
        RepeatInterval.daily,
        platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Нажми на кнопку, чтобы получать ежедневные уведомления',
            style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: shownotifications,
        child: const Icon(Icons.notifications),
      ),
    );
  }
}
