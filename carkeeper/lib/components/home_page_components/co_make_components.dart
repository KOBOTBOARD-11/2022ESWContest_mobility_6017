import 'package:carkeeper/commons/common_form_card.dart';
import 'package:carkeeper/pages/card_pages/ch4_value_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../pages/card_pages/co_value_card.dart';
import '../../pages/card_pages/lpg_value_card.dart';

class CoMakeCompo extends StatefulWidget {
  @override
  State<CoMakeCompo> createState() => _CoMakeCompoState();
}

class _CoMakeCompoState extends State<CoMakeCompo> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        CoValueCard(),
        Ch4ValueCard(),
        LPGCard(),
      ],
      options: CarouselOptions(
        height: 78,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 10),
        initialPage: 0,
        viewportFraction: 0.8,
        enlargeCenterPage: true,
      ),
    );
  }
}
