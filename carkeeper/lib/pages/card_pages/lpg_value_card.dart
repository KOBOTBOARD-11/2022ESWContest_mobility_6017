import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../commons/common_form_card.dart';

class LPGCard extends StatefulWidget {
  @override
  State<LPGCard> createState() => _LPGCardState();
}

class _LPGCardState extends State<LPGCard> {
  var _snapshot = FirebaseFirestore.instance
      .collection('gas_sensor')
      .doc("detect_lpg")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _snapshot,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) {
            return CommonFormCard(gasName: "LPG", amount: null);
          } else {
            var amt = snapshot.data?["ppm"];
            return CommonFormCard(gasName: "LPG", amount: amt);
          }
        });
  }
}
