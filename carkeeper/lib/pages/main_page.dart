import 'package:carkeeper/pages/car_keeper_page.dart';
import 'package:carkeeper/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, userSnapshot) {
        if (userSnapshot.hasData) {
          return const CarKeeperPage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
