import 'package:carkeeper/styles.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';

import '../../commons/confirm.dart';

class PicturePageComponents extends StatefulWidget {
  @override
  State<PicturePageComponents> createState() => _PicturePageComponentsState();
}

bool selected = false;
var alignment = Alignment.bottomLeft;

class _PicturePageComponentsState extends State<PicturePageComponents>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var Height = MediaQuery.of(context).size.height;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 2000),
      curve: Curves.fastLinearToSlowEaseIn,
      height: selected ? Height * 0.4 : Height * 0.9,
      child: Stack(
        children: [
          Opacity(
            opacity: selected ? 1 : 0.5,
            child: ShaderMask(
              shaderCallback: (Rect bound) {
                return const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.white],
                    stops: [0, 1]).createShader(bound);
              },
              blendMode: BlendMode.dstIn,
              child: AnimatedPadding(
                padding: selected
                    ? const EdgeInsets.symmetric(horizontal: 8.0)
                    : const EdgeInsets.symmetric(horizontal: 0),
                duration: const Duration(milliseconds: 2000),
                child: AnimatedContainer(
                  height: selected ? Height * 0.4 : Height * 0.9,
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: ClipRRect(
                    borderRadius: selected
                        ? BorderRadius.circular(30)
                        : BorderRadius.circular(0),
                    child: Image.asset(
                      "assets/hyundai_peli.jpg",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: selected
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.spaceEvenly,
            children: [
              AnimatedDefaultTextStyle(
                style: selected
                    ? h4(mColor: const Color(0xFF06A66C))
                    : bigSize1(mColor: const Color(0xFF06A66C)),
                duration: const Duration(milliseconds: 800),
                child: const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Text("Car Keeper")),
              ),
              AnimatedAlign(
                alignment: alignment,
                duration: const Duration(milliseconds: 800),
                child: selected
                    ? TimerBuilder.periodic(
                        const Duration(seconds: 1),
                        builder: (context) {
                          return Padding(
                            padding: selected
                                ? const EdgeInsets.only(right: 12.0)
                                : const EdgeInsets.only(
                                    left: 12.0, bottom: 12.0),
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 800),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.end,
                              child: Text(
                                formatDate(DateTime.now(),
                                    [mm, "/", dd, " \n", am, " ", hh, ':', nn]),
                              ),
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: InkWell(
                          onTap: () {
                            CheckDialogYesOrNo(
                                context,
                                "사용자 등록 페이지에서\n 등록을 완료하셨습니까?",
                                "안하셨다면 \n등록을 완료해주세요!",
                                const Color(0xFF06A66C));
                          },
                          child: AnimatedContainer(
                            decoration:
                                buttonStyle2(mColor: const Color(0xFF06A66C)),
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 800),
                            child: Text(
                              "START",
                              style: h4(mColor: Colors.white),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
