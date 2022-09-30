import 'package:carkeeper/styles.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

class PicturePageComponents extends StatefulWidget {
  @override
  State<PicturePageComponents> createState() => _PicturePageComponentsState();
}

class _PicturePageComponentsState extends State<PicturePageComponents> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (Rect bound) {
            return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.white],
                stops: [0, 1]).createShader(bound);
          },
          blendMode: BlendMode.dstIn,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                "assets/hyundai_peli.jpg",
                fit: BoxFit.cover,
                height: 315,
                width: double.infinity,
              ),
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 10),
            Text(
              "Car Keeper",
              style: h4(
                mColor: Color(0xFF06A66C),
              ),
            ),
            SizedBox(height: 150),
            TimerBuilder.periodic(
              const Duration(seconds: 1),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      formatDate(DateTime.now(),
                          [mm, "/", dd, " \n", am, " ", hh, ':', nn]),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
