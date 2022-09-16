import 'package:carkeeper/commons/common_form_field.dart';
import 'package:carkeeper/styles.dart';
import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("접근 기록"),
      ),
      body: ListView(
        children: [
          _buildRecordContainer("2022년 09월 16일\n00시 00분 00초", "외부인 감지"),
          _buildRecordContainer("2022년 09월 16일\n00시 00분 10초", "맷돼지 감지"),
        ],
      ),
    );
  }

  Column _buildRecordContainer(String date, String info) {
    return Column(
      children: [
        SizedBox(height: 25),
        Container(
          alignment: Alignment.center,
          width: 300,
          height: 200,
          color: Colors.black,
          child: Text(
            "image",
            style: h4(mColor: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 5),
        Container(
          width: 290,
          height: 110,
          alignment: Alignment.center,
          //color: Color(0xFFA7D2CB),
          child: CommonFormField(date: date, info: info),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xFFA7D2CB),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
