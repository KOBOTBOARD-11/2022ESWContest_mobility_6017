import 'package:flutter/material.dart';

import '../styles.dart';

class CommonFormCard extends StatefulWidget {
  final gasName;
  final amount;

  const CommonFormCard({required this.gasName, required this.amount});

  @override
  State<CommonFormCard> createState() => _CommonFormCardState(gasName, amount);
}

class _CommonFormCardState extends State<CommonFormCard> {
  final gas;
  final amt;
  var mColor;
  var status;
  var sColor;
  _CommonFormCardState(this.gas, this.amt);
  @override
  Widget build(BuildContext context) {
    print(amt);
    if (amt < (10)) {
      mColor = Color(0xFFDCECFF);
      status = "안전";
      sColor = Color(0xFF0057FF);
    } else if (10 <= amt && amt < 50) {
      mColor = Color(0xFFFFF3DC);
      status = "주의";
      sColor = Color(0xFFFF8A00);
    } else {
      mColor = Color(0xFFFFDCDC);
      status = "위험";
      sColor = Color(0xFFFF0000);
    }
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), color: mColor),
      alignment: Alignment.center,
      width: 300,
      height: 180,
      child: Column(
        children: [
          SizedBox(height: 10),
          Text(
            '${gas} 수치',
            style: h5(),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    "${amt}",
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
