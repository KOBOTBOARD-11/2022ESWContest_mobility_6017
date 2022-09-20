import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../commons/common_form_card.dart';

class CoValueCard extends StatefulWidget {
  @override
  State<CoValueCard> createState() => _CoValueCardState();
}

class _CoValueCardState extends State<CoValueCard> {
  var _snapshot = FirebaseFirestore.instance
      .collection('gas_sensor')
      .doc("detect_co")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _snapshot,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return CommonFormCard(gasName: "일산화탄소(CO)", amount: null);
          } else {
            var amt = snapshot.data?["ppm"];
            return CommonFormCard(gasName: "일산화탄소(CO)", amount: amt);
          }
        });
  }
}
