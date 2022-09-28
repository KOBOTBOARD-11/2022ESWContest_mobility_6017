import 'package:carkeeper/components/home_page_components/picture_page_components.dart';
import 'package:carkeeper/components/home_page_components/record_components.dart';
import 'package:carkeeper/components/home_page_components/stream_components.dart';
import 'package:carkeeper/pages/record_page.dart';
import 'package:carkeeper/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../components/home_page_components/co_make_components.dart';
import '../components/home_page_components/face_components.dart';
import '../main.dart';

class HomeScreenPage extends StatefulWidget {
  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  int _selectedIndex = 0;
  void initState() {
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    var initialzationSettingsIOS = IOSInitializationSettings(
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Car Keeper",
          style: h5(mColor: Color(0xFF06A66C)),
        ),
      ),
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
              1,
              1,
            ],
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                PicturePageComponents(),
                SizedBox(height: 100, child: CoMakeCompo()),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Color(0xFF06A66C),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      constraints: BoxConstraints(minHeight: 230),
                      padding: EdgeInsets.only(
                        bottom: 10,
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 5,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      height: 260,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const RecordPage()));
                              },
                              child: Text(
                                "감지 내역",
                                style: subtitle2(mColor: Color(0xFF06A66C)),
                              ),
                            ),
                          ),
                          Container(
                            width: 130,
                            height: 1,
                            color: Color(0xFF06A66C),
                          ),
                          SizedBox(height: 10),
                          RecordCompo(),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        StreamCompo(),
                        SizedBox(height: 10),
                        FaceCompo(),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
