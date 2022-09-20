import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../styles.dart';

class CommonFormCard extends StatelessWidget {
  final gasName;
  final amount;

  const CommonFormCard({required this.gasName, required this.amount});

  @override
  Widget build(BuildContext context) {
    var mColor;
    var status;
    var sColor;
    //print("hi $amt");
    if (amount == null) {
      mColor = Color(0xFFDCECFF);
      status = "안전";
      sColor = Color(0xFF0057FF);
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: mColor),
        alignment: Alignment.center,
        width: 300,
        height: 180,
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              '${gasName} 수치',
              style: h5(),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "측정중",
                  style: bigSize1(),
                ),
                SizedBox(width: 10),
              ],
            )
          ],
        ),
      );
    } else {
      if (amount < (10)) {
        mColor = Color(0xFFDCECFF);
        status = "안전";
        sColor = Color(0xFF0057FF);
      } else if (10 <= amount && amount < 50) {
        mColor = Color(0xFFFFF3DC);
        status = "주의";
        sColor = Color(0xFFFF8A00);
      } else {
        mColor = Color(0xFFFFDCDC);
        status = "위험";
        sColor = Color(0xFFFF0000);
      }
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: mColor),
        alignment: Alignment.center,
        width: 300,
        height: 180,
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(
              '${gasName} 수치',
              style: h5(),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      "${amount}",
                      style: bigSize1(),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "ppm",
                      style: body2(),
                    )
                  ],
                ),
                Text(
                  "${status}",
                  style: h4(mColor: sColor),
                )
              ],
            )
          ],
        ),
      );
    }
  }
}
