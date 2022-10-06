import 'package:carkeeper/commons/common_form_field_small.dart';
import 'package:carkeeper/pages/record_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../firebase/record_data_list.dart';

class RecordCompo extends StatefulWidget {
  @override
  State<RecordCompo> createState() => _RecordCompoState();
}

class _RecordCompoState extends State<RecordCompo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: recordInfo.isEmpty
          ? _buildRecordContainer("No", "No")
          : Column(
              children: [
                for (var i in recordInfo)
                  _buildRecordContainer(
                    i['time'],
                    i['type'],
                  ),
              ],
            ),
    );
  }

  Column _buildRecordContainer(String date, String info) {
    if (info == 'wildboar') {
      info = "멧돼지가";
    } else if (info == 'human') {
      info = "낯선이가";
    } else if (info == 'dog') {
      info = "들개가";
    } else if (info == 'waterdeer') {
      info = "물사슴이";
    } else if (info == 'racoon') {
      info = "너구리가";
    } else {
      info = info;
    }

    return Column(
      children: [
        Container(
          width: 130,
          height: info == "No" ? 215 : 50,
          child: CommonFormFieldSmall(date: date, info: info),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
