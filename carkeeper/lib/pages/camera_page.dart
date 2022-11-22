import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:carkeeper/commons/confirm.dart';
import 'package:carkeeper/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late Timer _timer;
  int _timeCount = 0;
  bool isPlayed = false;
  bool isPaused = false;
  late bool _cameraInitialized = false;
  late CameraController _cameraController;
  @override
  void initState() {
    super.initState();
    readyToCamera();
  }

  @override
  void dispose() {
    if (_cameraController != null) {
      _cameraController.dispose();
    }
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _cameraInitialized
          ? _camera(context)
          : const Center(
              child: CircularProgressIndicator(
                  backgroundColor: Color(0xFF06A66C),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Color(0xFF06A66C)))),
    );
  }

  Stack _camera(BuildContext context) {
    int secondCount = _timeCount ~/ 100;
    return Stack(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CameraPreview(_cameraController)),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF06A66C)),
              color: Colors.white),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.1,
          child: Center(
            child: isPlayed
                ? Text(
                    '$secondCount',
                    style: h1(mColor: const Color(0xFF06A66C)),
                  )
                : title(isPaused ? "촬영이 완료되었습니다." : "20초 동안 촬영합니다."),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              MaterialButton(
                onPressed: () => setState(() {
                  startVideo();
                  isPlayed = true;
                }),
                child: Icon(
                  CupertinoIcons.largecircle_fill_circle,
                  size: 100,
                  color: isPlayed ? Colors.transparent : Colors.redAccent,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _startTime() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        _timeCount++;
        _stopTime();
      });
    });
  }

  void _stopTime() {
    if (_timeCount >= 1600) {
      _timer.cancel();
      _timeCount = 0;
      isPlayed = false;
      isPaused = true;
      stopVideo();
    }
  }

  Future<void> startVideo() async {
    await _cameraController.startVideoRecording();
    _startTime();
  }

  Future<void> stopVideo() async {
    final file = await _cameraController.stopVideoRecording();
    CheckDialogUpload(context, file.path);
  }

  Future<void> readyToCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      print("not camera");
      return;
    }
    late CameraDescription frontCamera;
    for (final camera in cameras) {
      if (camera.lensDirection == CameraLensDirection.front) {
        frontCamera = camera;
        break;
      }
    }
    _cameraController = CameraController(
        frontCamera, ResolutionPreset.max // 가장 높은 해상도의 기능을 쓸 수 있도록 합니다.
        );
    _cameraController.initialize().then((value) {
      setState(() => _cameraInitialized = true);
    });
  }

  Text title(String info) {
    return Text(info, style: h3(mColor: const Color(0xFF06A66C)));
  }
}
