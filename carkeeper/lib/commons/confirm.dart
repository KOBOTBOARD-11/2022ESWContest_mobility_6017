import 'package:flutter/material.dart';

import '../components/home_page_components/picture_page_components.dart';
import '../pages/home_screen_page.dart';
import '../styles.dart';

CheckDialogYesOrNo(
    BuildContext context, String mainContent, String subContent, Color mColor) {
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
        content: Container(
          height: 130,
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
              FlatButton(
                // 버튼 클릭시 CheckDialogConfirm로 가서 확인 Dialog를 보여준다.
                color: mColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color(0xFF06A66C),
                  ),
                ),
                child: Text(
                  "예",
                  style: subtitle3(
                      mColor: mColor == Colors.white
                          ? Color(0xFF06A66C)
                          : Colors.white),
                ),
                onPressed: () {
                  parent!.setState(() {
                    Navigator.pop(context);
                    selected = !selected;
                    alignment = alignment == Alignment.bottomLeft
                        ? Alignment.topRight
                        : Alignment.bottomLeft;
                  });
                },
              ),
              FlatButton(
                color:
                    mColor == Colors.white ? Color(0xFF06A66C) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Color(0xFF06A66C),
                  ),
                ),
                child: Text(
                  "아니요",
                  style: subtitle3(
                      mColor: mColor == Colors.white
                          ? Colors.white
                          : Color(0xFF06A66C)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          )
        ],
      );
    },
  );
}