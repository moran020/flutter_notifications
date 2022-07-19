import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  //время ежедневного уведомления
  DateTime time =
      DateTime.utc(2022, 07, 19, 16, 30, 00).add(Duration(hours: 24));

  //инициализация
  @override
  void initState() {
    super.initState();
    //объект для Android настроек
    var androidInitialize = new AndroidInitializationSettings('ic_launcher');
    //объект для IOS настроек
    var IOSInitialize = new IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    // общая инициализация
    var initializationSettings = new InitializationSettings(
        android: androidInitialize, iOS: IOSInitialize);

    //мы создаем локальное уведомление
    localNotifications = new FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializationSettings);

    _showNotification;
  }

// ежедневное уведомление
  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
      "ID",
      "Название уведомления",
      importance: Importance.high,
      channelDescription: "Контент уведомления",
    );

    var iosDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotifications.schedule(0, "Ежедневное уведомление",
        "Время заняться программированием!", time, generalNotificationDetails);
  }

// уведомление каждую минуту
  Future shownotifications() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'repeating channel id',
      'repeating channel name',
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await FlutterLocalNotificationsPlugin().periodicallyShow(0, 'Test title',
        'test body', RepeatInterval.everyMinute, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Нажми на кнопку, чтобы получить уведомление'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: shownotifications,
        child: Icon(Icons.notifications),
      ),
    );
  }
}
