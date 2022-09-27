import 'package:cached_network_image/cached_network_image.dart';
import 'package:carkeeper/commons/common_form_field.dart';
import 'package:carkeeper/firebase/record_data_list.dart';
import 'package:carkeeper/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  var _snapshot = FirebaseFirestore.instance.collection('pictures').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Car Keeper",
            style: h5(mColor: Color(0xFF06A66C)),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: _snapshot,
            builder: (context, snapshot) {
              if (snapshot.data?.size == 0) {
                // snapshot 데이터가 비어있으면
                return Container(
                  // 즉, 컬렉션에 아무것도 없으면 No Data를 출력한다.
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: Text(
                      "No Data",
                      style: h4(mColor: Color(0xFF06A66C)),
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                // snapshot 데이터를 가져오고 있을 때
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFF06A66C)),
                  ),
                );
              } else {
                if (recordInfo.isEmpty ||
                    snapshot.data?.docs.last['pic'] != recordInfo.last['pic']) {
                  // recordInfo가 비어있거나 또는
                  // 해당 데이터에서 인원이 감지된 시간과 recordInfo에 전에 저장된 최근 데이터의 인원이 감지된 시간이 다르면
                  recordInfo.add(snapshot.data?.docs.last.data());
                  // recordInfo에 해당 Snapshot의 Data를 넣는다.
                }
                print(recordInfo);
                return Align(
                  // recordInfo에 들어간 데이터만큼 record_page에 해당 데이터들을 넣는다.
                  alignment: Alignment.center,
                  child: ListView.builder(
                    itemCount: recordInfo.length,
                    itemBuilder: (context, index) {
                      return _buildRecordContainer(
                        recordInfo[index]['pic'],
                        recordInfo[index]['time'],
                        recordInfo[index]['type'],
                      );
                    },
                  ),
                );
              }
            }));
  }

  Column _buildRecordContainer(String imageUrl, String date, String info) {
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
    return Column(
      children: [
        SizedBox(height: 25),
        Container(
          alignment: Alignment.center,
          width: 300,
          height: 200,
          child: CachedNetworkImage(
            // cachedNetworkImage를 통해 한번 로딩되면 다음 접속할때는 바로 뜨게 한다.
            fit: BoxFit.cover,
            imageUrl: imageUrl,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
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
            color: Color(0xFF06A66C),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
