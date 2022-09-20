import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../commons/common_form_card.dart';

class Ch4ValueCard extends StatefulWidget {
  @override
  State<Ch4ValueCard> createState() => _Ch4ValueCardState();
}

class _Ch4ValueCardState extends State<Ch4ValueCard> {
  var _snapshot = FirebaseFirestore.instance
      .collection('gas_sensor')
      .doc("detect_ch4")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _snapshot,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return CommonFormCard(gasName: "메탄가스(CH4)", amount: null);
          } else {
            var amt = snapshot.data?["ppm"];
            return CommonFormCard(gasName: "메탄가스(CH4)", amount: amt);
          }
        });
  }
}
