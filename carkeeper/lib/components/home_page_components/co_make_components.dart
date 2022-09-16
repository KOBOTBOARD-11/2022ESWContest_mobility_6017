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
        Container(
          alignment: Alignment.center,
          width: 300,
          height: 180,
          color: Colors.black,
          child: Text(
            'co1',
            style: h5(mColor: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 300,
          height: 180,
          color: Colors.black,
          child: Text(
            'co2',
            style: h5(mColor: Colors.white),
          ),
        ),
      ],
      options: CarouselOptions(
        autoPlay: true,
        aspectRatio: 2.0,
        initialPage: 0,
        enlargeCenterPage: true,
      ),
    );
  }
}
