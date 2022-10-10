import 'package:flutter/material.dart';

import '../styles.dart';

class CommonFormField extends StatefulWidget {
  final date;
  final info;

  const CommonFormField({required this.date, required this.info});
  @override
  State<CommonFormField> createState() => _CommonFormFieldState(date, info);
}

class _CommonFormFieldState extends State<CommonFormField> {
  final dateText;
  final infoText;

  _CommonFormFieldState(this.dateText, this.infoText);
  @override
  Widget build(BuildContext context) {
    var sColor;
    if (infoText == '맷돼지') {
      sColor = Colors.brown;
    } else if (infoText == '사람') {
      sColor = Colors.blue;
    } else if (infoText == '들개') {
      sColor = Colors.grey;
    } else if (infoText == '고라니') {
      sColor = Colors.yellow;
    } else if (infoText == '너구리') {
      sColor = Colors.black;
    } else {
      sColor = Color(0xFF06A66C);
    }
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dateText.substring(2, 21),
            style: subtitle3(mColor: const Color(0xFF06A66C)),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$infoText",
                  style: subtitle3(mColor: sColor),
                ),
                TextSpan(
                  text: "이/가 감지되었습니다.",
                  style: subtitle3(mColor: const Color(0xFF06A66C)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 1),
        ],
      ),
    );
  }
}
