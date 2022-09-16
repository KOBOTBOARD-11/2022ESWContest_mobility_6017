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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              dateText,
              style: subtitle3(mColor: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              infoText,
              style: subtitle3(mColor: Colors.white),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
