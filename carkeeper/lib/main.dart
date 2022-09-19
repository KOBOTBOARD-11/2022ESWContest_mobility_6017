import 'package:carkeeper/pages/face_register_page.dart';
import 'package:carkeeper/pages/home_screen_page.dart';
import 'package:carkeeper/pages/record_page.dart';
import 'package:carkeeper/pages/stream_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
          backgroundColor: Color(0xFFF2D388),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomeScreenPage(),
        '/stream': (context) => StreamPage(),
        '/record': (context) => RecordPage(),
        '/face': (context) => FaceRegisterPage(),
      },
    );
  }
}
