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
      sColor = Color(0xFF0064ff);
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF06A66C)),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        width: 300,
        height: 50,
        child: Column(
          children: [
            SizedBox(height: 8),
            Text(
              '${gasName} 수치',
              style: subtitle3(mColor: sColor),
            ),
            Container(
              width: 150,
              height: 5,
              color: Color(0xFF06A66C),
            ),
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
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.5,
                blurRadius: 5,
                offset: Offset(0, 1),
              )
            ]),
        alignment: Alignment.center,
        width: 300,
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${gasName}',
              style: subtitle3(mColor: Color(0xFF06A66C)),
            ),
            Container(
              width: 200,
              height: 2,
              color: Color(0xFF06A66C),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    SizedBox(height: 5),
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
                  style: subtitle3(mColor: sColor),
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
        sColor = Color(0xFF0064ff);
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
        sColor = Color(0xFF0064ff);
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
        sColor = Color(0xFF0064ff);
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
