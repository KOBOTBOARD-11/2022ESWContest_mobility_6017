import 'package:carkeeper/commons/confirm.dart';
import 'package:carkeeper/components/home_page_components/picture_page_components.dart';
import 'package:carkeeper/pages/home_screen_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../styles.dart';

class PauseCompo extends StatefulWidget {
  const PauseCompo({Key? key}) : super(key: key);

  @override
  State<PauseCompo> createState() => _PauseCompoState();
}

class _PauseCompoState extends State<PauseCompo> {
  HomeScreenPage home = new HomeScreenPage();
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        CheckDialogYesOrNo(
            context, "정말로 종료하시겠습니까?", "모든 내용이 초기화됩니다.", Colors.white);
      },
      child: Container(
        decoration: buttonStyle1(),
        alignment: Alignment.center,
        width: 120,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.pause,
              size: 40,
              color: Color(0xFF06A66C),
            ),
            Text(
              '사용 정지',
              style: subtitle2(mColor: Color(0xFF06A66C)),
            ),
          ],
        ),
      ),
    );
  }
}
