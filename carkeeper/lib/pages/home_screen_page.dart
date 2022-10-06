import 'package:carkeeper/components/home_page_components/picture_page_components.dart';
import 'package:carkeeper/components/home_page_components/record_components.dart';
import 'package:carkeeper/components/home_page_components/stream_components.dart';
import 'package:carkeeper/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../components/home_page_components/co_make_components.dart';
import '../components/home_page_components/pause_components.dart';
import '../main.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => HomeScreenPageState();
}

class HomeScreenPageState extends State<HomeScreenPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initialzationSettingsIOS = const IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    var initializationSettings = InitializationSettings(
        android: initialzationSettingsAndroid, iOS: initialzationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: selectionNotification,
    );
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 0.5,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void setAni() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFe9e9e9),
            ],
            stops: [
              0.5,
              1,
            ],
          )),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              PicturePageComponents(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 100, child: CoMakeCompo()),
                  Container(
                    width: double.infinity,
                    height: 0.5,
                    color: Colors.grey,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        bottom: 10,
                        left: 10,
                        right: 10,
                      ),
                      decoration: buttonStyle1(),
                      height: 265,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const SizedBox(width: 35),
                                Text(
                                  "감지 내역",
                                  style: subtitle2(
                                      mColor: const Color(0xFF06A66C)),
                                ),
                                const SizedBox(width: 15),
                                Column(
                                  children: [
                                    const SizedBox(height: 1),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(90),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 0,
                                            blurRadius: 1,
                                            offset: const Offset(0, 1),
                                          )
                                        ],
                                      ),
                                      child: RotationTransition(
                                        turns: Tween(begin: 0.0, end: 2.0)
                                            .animate(_controller),
                                        child: InkWell(
                                          child: const Icon(
                                            Icons.refresh,
                                            size: 20,
                                            color: Color(0xFF06A66C),
                                          ),
                                          onTap: () {
                                            setState(() {
                                              _controller.forward(from: 0);
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 130,
                            height: 1,
                            color: const Color(0xFF06A66C),
                          ),
                          const SizedBox(height: 5),
                          Container(
                              constraints: const BoxConstraints(maxHeight: 215),
                              child: RecordCompo()),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        StreamCompo(),
                        const SizedBox(height: 10),
                        const PauseCompo(),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
