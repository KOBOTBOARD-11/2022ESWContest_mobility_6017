import 'package:flutter/material.dart';

import '../styles.dart';

class CommonFormFieldSmall extends StatefulWidget {
  final date;
  final info;

  const CommonFormFieldSmall({required this.date, required this.info});
  @override
  State<CommonFormFieldSmall> createState() =>
      _CommonFormFieldSmallState(date, info);
}

class _CommonFormFieldSmallState extends State<CommonFormFieldSmall> {
  final dateText;
  final infoText;

  _CommonFormFieldSmallState(this.dateText, this.infoText);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xFF06A66C)),
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dateText.substring(2, 21),
            style: overLine(mColor: Color(0xFF06A66C)),
          ),
          Text(
            "${infoText} 감지",
            style: overLine(mColor: Color(0xFF06A66C)),
          ),
        ],
      ),
    );
  }
}
