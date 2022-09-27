import 'package:camera/camera.dart';
import 'package:carkeeper/pages/car_keeper_page.dart';
import 'package:carkeeper/pages/face_register_page.dart';
import 'package:carkeeper/pages/home_screen_page.dart';
import 'package:carkeeper/pages/record_page.dart';
import 'package:carkeeper/pages/stream_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

Future<bool> permission() async {
  Map<Permission, PermissionStatus> status =
      await [Permission.camera].request(); // [] 권한배열에 권한을 작성

  if (await Permission.camera.isGranted) {
    return Future.value(true);
  } else {
    return Future.value(false);
  }
}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
late final firstCamera;

void main() async {
  // UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String? token = await FirebaseMessaging.instance.getToken();
  print("token : ${token ?? 'token NULL!'}");
  permission();
  // 디바이스에서 이용가능한 카메라 목록을 받아옵니다.
  final cameras = await availableCameras();
  // 이용가능한 카메라 목록에서 특정 카메라를 얻습니다.
  firstCamera = cameras.first;
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    var androidNotiDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
    );
    var iOSNotiDetails = const IOSNotificationDetails();
    var details =
        NotificationDetails(android: androidNotiDetails, iOS: iOSNotiDetails);
    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        details,
      );
    }
  });
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestPermission();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFFFFFAF2),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 1,
        ),
        scaffoldBackgroundColor: Color(0xFFFFFAF2),
        primaryColor: Colors.white,
        accentColor: Color(0xFF06A66C),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/carkeeper',
      routes: {
        '/carkeeper': (context) => CarKeeperPage(),
        '/home': (context) => HomeScreenPage(),
        '/stream': (context) => StreamPage(),
        '/record': (context) => RecordPage(),
        '/face': (context) => FaceRegisterPage(),
      },
    );
  }
}
