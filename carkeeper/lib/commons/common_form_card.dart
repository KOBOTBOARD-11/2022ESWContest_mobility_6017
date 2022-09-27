import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

var status;
var sColor;

class CommonFormCard extends StatelessWidget {
  final gasName;
  final amount;

  const CommonFormCard({required this.gasName, required this.amount});

  @override
  Widget build(BuildContext context) {
    if (amount == null) {
      status = "안전";
      sColor = Color(0xFF0057FF);
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF06A66C)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        width: 300,
        height: 60,
        child: Column(
          children: [
            SizedBox(height: 8),
            Text(
              '${gasName} 수치',
              style: subtitle3(mColor: sColor),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "측정중",
                  style: subtitle2(),
                ),
              ],
            )
          ],
        ),
      );
    } else {
      checkGasName(gasName);
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF06A66C)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        width: 300,
        height: 60,
        child: Column(
          children: [
            SizedBox(height: 7),
            Text(
              '${gasName}',
              style: subtitle1(mColor: Color(0xFF06A66C)),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      "${amount}",
                      style: h5(mColor: sColor),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "ppm",
                      style: subtitle2(mColor: Color(0xFF06A66C)),
                    )
                  ],
                ),
                Text(
                  "${status}",
                  style: subtitle1(mColor: sColor),
                )
              ],
            )
          ],
        ),
      );
    }
  }

  void checkGasName(String gasName) {
    if (gasName == "일산화탄소(CO)") {
      if (amount < (40)) {
        status = "안전";
        sColor = Color(0xFF0057FF);
      } else if (40 <= amount && amount < 800) {
        status = "주의";
        sColor = Color(0xFFFF8A00);
      } else {
        status = "위험";
        sColor = Color(0xFFFF0000);
      }
    } else if (gasName == "메탄가스(CH4)") {
      if (amount < (1000)) {
        status = "안전";
        sColor = Color(0xFF0057FF);
      } else if (1000 <= amount && amount < 2500) {
        status = "주의";
        sColor = Color(0xFFFF8A00);
      } else {
        status = "위험";
        sColor = Color(0xFFFF0000);
      }
    } else {
      if (amount < (1000)) {
        status = "안전";
        sColor = Color(0xFF0057FF);
      } else if (1000 <= amount && amount < 2500) {
        status = "주의";
        sColor = Color(0xFFFF8A00);
      } else {
        status = "위험";
        sColor = Color(0xFFFF0000);
      }
    }
  }
}
