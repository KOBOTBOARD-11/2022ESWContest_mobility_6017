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
        Opacity(
          opacity: 0.6,
          child: Image.asset(
            "assets/hyundai_peli.jpg",
            fit: BoxFit.cover,
            height: 315,
            width: double.infinity,
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
            SizedBox(height: 170),
            TimerBuilder.periodic(
              const Duration(seconds: 1),
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      formatDate(DateTime.now(),
                          [yy, "/", mm, "/", dd, " \n", am, " ", hh, ':', nn]),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                );
              },
            ),
            Container(
              width: double.infinity,
              height: 2,
              color: Colors.grey,
            ),
          ],
        ),
      ],
    );
  }
}
