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
          border: Border.all(color: Color(0xFF06A66C), width: 2),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.face,
              size: 60,
              color: Color(0xFF06A66C),
            ),
            Text(
              '사용자 등록',
              style: subtitle3(mColor: Color(0xFF06A66C)),
            ),
          ],
        ),
      ),
    );
  }
}
