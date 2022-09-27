import 'package:carkeeper/commons/common_form_field_small.dart';
import 'package:carkeeper/pages/record_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../commons/common_form_field.dart';
import '../../firebase/record_data_list.dart';
import '../../styles.dart';

class RecordCompo extends StatefulWidget {
  @override
  State<RecordCompo> createState() => _RecordCompoState();
}

class _RecordCompoState extends State<RecordCompo> {
  // @override
  // Widget build(BuildContext context) {
  //   return SingleChildScrollView(
  //       scrollDirection: Axis.vertical,
  //       child: Column(
  //         children: [
  //           _buildRecordContainer("['2022.09.27 19:57:23']", "wildboar"),
  //           _buildRecordContainer("['2022.09.27 19:57:23']", "wildboar"),
  //           _buildRecordContainer("['2022.09.27 19:57:23']", "wildboar"),
  //           _buildRecordContainer("['2022.09.27 19:57:23']", "wildboar"),
  //         ],
  //       ));
  // }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
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
  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //     //shrinkWrap: true,
  //     itemCount: recordInfo.length,
  //     itemBuilder: (context, index) {
  //       return _buildRecordContainer(
  //         recordInfo[index]['time'],
  //         recordInfo[index]['type'],
  //       );
  //     },
  //   );
  // }

  TextButton _buildRecordContainer(String date, String info) {
    if (info == 'wildboar') {
      info = "멧돼지";
    } else if (info == 'human') {
      info = "외부인";
    } else if (info == 'dog') {
      info = "들개";
    } else if (info == 'waterdeer') {
      info = "물사슴";
    } else if (info == 'racoon') {
      info = "너구리";
    }
    return TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const RecordPage()));
      },
      child: Column(
        children: [
          Container(
            width: 130,
            height: 50,
            child: CommonFormFieldSmall(date: date, info: info),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
