import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/home_page_components/picture_page_components.dart';
import '../firebase/record_data_list.dart';
import '../pages/home_screen_page.dart';
import '../styles.dart';

CheckDialogYesOrNo(BuildContext context, String mainContent, String subContent,
    Color mColor) async {
  HomeScreenPageState? parent =
      context.findAncestorStateOfType<HomeScreenPageState>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        //Dialog Main Title
        //
        content: SizedBox(
          height: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                mainContent,
                style: subtitle3(),
                textAlign: TextAlign.center,
              ),
              Text(
                subContent,
                style: subtitle3(mColor: Colors.grey),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                // 버튼 클릭시 CheckDialogConfirm로 가서 확인 Dialog를 보여준다.
                color: mColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color(0xFF06A66C),
                  ),
                ),
                child: Text(
                  "예",
                  style: subtitle3(
                      mColor: mColor == Colors.white
                          ? const Color(0xFF06A66C)
                          : Colors.white),
                ),
                onPressed: () async {
                  if (mainContent == "사용자 등록 페이지에서\n 등록을 완료하셨습니까?") {
                    await FirebaseFirestore.instance
                        .collection("CarKeeper")
                        .doc("observer")
                        .set({
                      'mode': 'on',
                    });
                  } else {
                    await FirebaseFirestore.instance
                        .collection("CarKeeper")
                        .doc("observer")
                        .update({
                      'mode': 'off',
                    });
                    recordInfo.clear();
                    await FirebaseFirestore.instance
                        .collection('pictures')
                        .doc('pic')
                        .delete();
                  }
                  parent!.setState(() {
                    Navigator.pop(context);
                    selected = !selected;
                    alignment = alignment == Alignment.bottomLeft
                        ? Alignment.topRight
                        : Alignment.bottomLeft;
                  });
                },
              ),
              MaterialButton(
                color: mColor == Colors.white
                    ? const Color(0xFF06A66C)
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Color(0xFF06A66C),
                  ),
                ),
                child: Text(
                  "아니요",
                  style: subtitle3(
                      mColor: mColor == Colors.white
                          ? Colors.white
                          : const Color(0xFF06A66C)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  if (subContent == "모든 내용이 초기화됩니다.") {
                    recordInfo.clear();
                    FirebaseFirestore.instance
                        .collection('pictures')
                        .doc('pic')
                        .delete();
                  }
                },
              )
            ],
          )
        ],
      );
    },
  );
}
