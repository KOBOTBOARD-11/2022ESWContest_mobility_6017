import 'package:flutter/material.dart';

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
          Container(
            padding: EdgeInsets.symmetric(vertical: 45),
            alignment: Alignment.center,
            constraints: BoxConstraints(maxWidth: 300),
            child: Text(
              "※ 갹체가 탐지되면 객체의 움직임을\n\t\t\t 스트리밍 해줍니다.",
              style: subtitle3(),
            ),
          ),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 200,
                color: Colors.black,
                child: Text(
                  "image",
                  style: h4(mColor: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                height: 90,
                color: Color(0xFFA7D2CB),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "확대하기",
                    style: h5(mColor: Colors.white),
                  ),
                ),
              )
            ],
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
