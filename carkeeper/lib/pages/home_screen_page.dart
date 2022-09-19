import 'package:carkeeper/components/home_page_components/record_components.dart';
import 'package:carkeeper/components/home_page_components/stream_components.dart';
import 'package:carkeeper/styles.dart';
import 'package:flutter/material.dart';

import '../components/home_page_components/co_make_components.dart';
import '../components/home_page_components/face_components.dart';

class HomeScreenPage extends StatefulWidget {
  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Car Keeper",
          style: h5(mColor: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 30),
        children: [
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              CoMakeCompo(),
              SizedBox(
                height: 20,
              ),
              StreamCompo(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RecordCompo(),
                  SizedBox(
                    width: 10,
                  ),
                  FaceCompo(),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
