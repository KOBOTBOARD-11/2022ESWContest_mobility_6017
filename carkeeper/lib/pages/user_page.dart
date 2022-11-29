import 'package:carkeeper/pages/face_register_page.dart';
import 'package:carkeeper/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          content: SizedBox(
            height: 200,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                height: 50.0,
                width: 50.0,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Color(0xFF06A66C),
                  ),
                  strokeWidth: 5.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("Success");
    } catch (e) {
      print(e.toString());
    }
  }

  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AspectRatio(
            aspectRatio: 1.5,
            child: Icon(
              Icons.account_circle,
              size: 160,
              color: Color(0xFF06A66C),
            ),
          ),
          Text(
            "사용자",
            style: h5(mColor: Colors.grey),
          ),
          Text(
            "${user?.email}",
            style: h5(mColor: Colors.black),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.25),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FaceRegisterPage(),
                  ),
                );
              },
              color: Color(0xFF06A66C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "사용자 등록",
                  style: h5(mColor: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.3),
          InkWell(
            onTap: () {
              _showDialog();
              signOut();
            },
            child: Text(
              "Sign Out",
              style: h5(mColor: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
