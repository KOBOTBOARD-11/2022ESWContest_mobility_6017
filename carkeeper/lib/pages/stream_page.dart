import 'package:flutter/material.dart';
import 'package:carkeeper/components/stream_page_components/stream_video.dart';
import '../styles.dart';

class StreamPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("실시간 스트리밍"),
      ),
      body: Column(
        children: [
          VideoStream(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 45),
            alignment: Alignment.center,
            constraints: BoxConstraints(maxWidth: 300),
            child: Text(
              "※ 객체가 탐지되면 객체의 움직임을\n\t\t\t 감지합니다.",
              style: subtitle3(),
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            height: 85,
            color: Color(0xFFC98474),
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/record");
                },
                child: Text(
                  "접근 기록 확인하기",
                  style: h5(
                    mColor: Colors.white,
                  ),
                )),
          )
        ],
      ),
    );
  }
}
