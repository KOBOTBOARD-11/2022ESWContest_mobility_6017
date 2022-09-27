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
          opacity: 0.9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              "assets/hyundai_peli.jpg",
              fit: BoxFit.cover,
              height: 300,
              width: double.infinity,
            ),
          ),
        ),
        TimerBuilder.periodic(
          const Duration(seconds: 1),
          builder: (context) {
            return Column(
              children: [
                SizedBox(height: 205),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      formatDate(DateTime.now(),
                          [mm, "/", dd, " \n", hh, ':', nn, ':', ss, ' ', am]),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
