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
      onPressed: () {
        Navigator.pushNamed(context, "/stream");
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFF06A66C),
        ),
        alignment: Alignment.center,
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              CupertinoIcons.clock_fill,
              size: 60,
              color: Colors.white,
            ),
            Text(
              textAlign: TextAlign.center,
              '실시간 동영상',
              style: subtitle2(mColor: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
