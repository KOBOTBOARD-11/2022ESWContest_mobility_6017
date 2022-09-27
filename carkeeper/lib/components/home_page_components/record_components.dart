import 'package:carkeeper/commons/common_form_field_small.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../commons/common_form_field.dart';
import '../../styles.dart';

class RecordCompo extends StatefulWidget {
  @override
  State<RecordCompo> createState() => _RecordCompoState();
}

class _RecordCompoState extends State<RecordCompo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          _buildRecordContainer("00시 00분 10초", "외부인 감지"),
          _buildRecordContainer("00시 00분 10초", "맷돼지 감지"),
          _buildRecordContainer("00시 00분 10초", "맷돼지 감지"),
          _buildRecordContainer("00시 00분 10초", "맷돼지 감지"),
          //_buildRecordContainer("00시 00분 10초", "맷돼지 감지"),
        ],
      ),
    );
  }

  TextButton _buildRecordContainer(String date, String info) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/record');
      },
      child: Column(
        children: [
          Container(
            width: 130,
            height: 50,
            child: CommonFormFieldSmall(date: date, info: info),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
