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
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dateText.substring(2, 21),
            style: subtitle3(mColor: Color(0xFF06A66C)),
          ),
          Text(
            "${infoText} 감지되었습니다.",
            style: subtitle3(mColor: Color(0xFF06A66C)),
          ),
          SizedBox(height: 1),
        ],
      ),
    );
  }
}
