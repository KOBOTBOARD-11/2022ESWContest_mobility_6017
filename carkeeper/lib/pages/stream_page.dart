import 'package:carkeeper/pages/record_page.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:carkeeper/components/stream_page_components/stream_video.dart';
import '../styles.dart';

class StreamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Car Keeper",
            style: h5(mColor: Color(0xFF06A66C)),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context); //뒤로가기
              },
              color: Color(0xFF06A66C),
              icon: Icon(Icons.arrow_back)),
        ),
        body: Center(
            child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              constraints: BoxConstraints(maxWidth: 300),
              child: Text(
                "※ 객체가 탐지되면 객체의 움직임을 감지합니다.",
                style: subtitle1(),
              ),
            ),
            VideoStream(),
          ],
        )),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const RecordPage()));
            },
            label: Text(
              "접근 기록 확인하기",
            )));
  }
}
