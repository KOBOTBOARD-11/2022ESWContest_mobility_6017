import 'package:carkeeper/components/home_page_components/picture_page_components.dart';
import 'package:carkeeper/components/home_page_components/record_components.dart';
import 'package:carkeeper/components/home_page_components/stream_components.dart';
import 'package:carkeeper/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../components/home_page_components/calendar_components.dart';
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 10),
              PicturePageComponents(),
              SizedBox(height: 10),
              CoMakeCompo(),
              SizedBox(height: 10),
              Row(
                children: [
                  Column(
                    children: [
                      CalendarComponents(),
                      SizedBox(height: 10),
                      Container(
                        constraints: BoxConstraints(minHeight: 230),
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0xFF06A66C),
                          ),
                        ),
                        height: 230,
                        child: RecordCompo(),
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
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
    );
  }
}
