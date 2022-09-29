import 'package:carkeeper/pages/face_register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../styles.dart';

class FaceCompo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FaceRegisterPage()));
      },
      child: Container(
        decoration: buttonStyle1(),
        alignment: Alignment.center,
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.people_alt_outlined,
              size: 40,
              color: Color(0xFF06A66C),
            ),
            Text(
              '사용자 등록',
              style: subtitle2(mColor: Color(0xFF06A66C)),
            ),
          ],
        ),
      ),
    );
  }
}
