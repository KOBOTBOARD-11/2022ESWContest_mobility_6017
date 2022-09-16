import 'package:carkeeper/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StreamCompo extends StatefulWidget {
  @override
  State<StreamCompo> createState() => StreamCompoState();
}

class StreamCompoState extends State<StreamCompo> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Color(0xFFA7D2CB),
        ),
        alignment: Alignment.center,
        width: 300,
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.clock_fill,
              size: 90,
              color: Colors.white,
            ),
            Text(
              textAlign: TextAlign.center,
              '차량 주변 \n 실시간 스트리밍',
              style: subtitle3(mColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
