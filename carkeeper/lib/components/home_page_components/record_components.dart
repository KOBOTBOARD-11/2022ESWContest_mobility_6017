import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../styles.dart';

class RecordCompo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/record');
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xFFC98474),
        ),
        width: 140,
        height: 130,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.doc_text_fill,
              size: 60,
              color: Colors.white,
            ),
            Text(
              '접근 기록',
              style: subtitle3(mColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
