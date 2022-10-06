import 'package:carkeeper/pages/stream_page.dart';
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
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => StreamPage()));
      },
      child: Container(
        decoration: buttonStyle1(),
        alignment: Alignment.center,
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.videocam,
              size: 50,
              color: Color(0xFF06A66C),
            ),
            Text(
              textAlign: TextAlign.center,
              '실시간 동영상',
              style: subtitle2(mColor: const Color(0xFF06A66C)),
            ),
          ],
        ),
      ),
    );
  }
}
