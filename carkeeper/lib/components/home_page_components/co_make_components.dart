import 'package:carkeeper/commons/common_form_card.dart';
import 'package:carkeeper/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CoMakeCompo extends StatefulWidget {
  @override
  State<CoMakeCompo> createState() => _CoMakeCompoState();
}

class _CoMakeCompoState extends State<CoMakeCompo> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        CommonFormCard(gasName: "일산화탄소(CO)", amount: 10),
        CommonFormCard(gasName: "메탄가스(CH4)", amount: 20),
        CommonFormCard(gasName: "LPG", amount: 55),
      ],
      options: CarouselOptions(
        autoPlay: false,
        aspectRatio: 2.0,
        initialPage: 0,
        enlargeCenterPage: true,
      ),
    );
  }
}
