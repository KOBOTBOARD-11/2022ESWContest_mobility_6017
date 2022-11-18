import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
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

  Column _camera(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.9,
            child: CameraPreview(_cameraController)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () async {
                await _cameraController.startVideoRecording();
              },
              child: const Icon(Icons.play_arrow, size: 40),
            ),
            MaterialButton(
              onPressed: () async {
                // final path = join((await getTemporaryDirectory()).path,
                //     '${DateTime.now()}.mp3');
                final file = await _cameraController.stopVideoRecording();
                uploadFile(file.path);
                print(file.path);
              },
              child: const Icon(Icons.play_arrow, size: 40),
            ),
          ],
        ),
      ],
    );
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

  Future uploadFile(String path) async {
    File? file = File(path);
    try {
      // 스토리지에 업로드할 파일 경로
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('post_video') //'post'라는 folder를 만들고
          .child('${DateTime.now().millisecondsSinceEpoch}.mp4');

      // 파일 업로드
      final uploadTask = firebaseStorageRef.putFile(
          file, SettableMetadata(contentType: 'video/mp4'));

      // 완료까지 기다림
      await uploadTask.whenComplete(() => null);

      // 업로드 완료 후 url
      final downloadUrl = await firebaseStorageRef.getDownloadURL();

      //문서 작성
      await FirebaseFirestore.instance.collection('FaceID').doc('user').set({
        'VideoURL': downloadUrl,
        'Time': DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }
}
