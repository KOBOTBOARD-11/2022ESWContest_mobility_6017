import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../styles.dart';

class FaceCompo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/face");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xFFC98474),
        ),
        alignment: Alignment.center,
        width: 140,
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.face,
              size: 60,
              color: Colors.white,
            ),
            Text(
              '사용자 등록',
              style: subtitle3(mColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
