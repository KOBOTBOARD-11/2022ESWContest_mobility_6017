import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../styles.dart';

bool videoSelect = false;

class FaceRegisterPage extends StatefulWidget {
  @override
  _FaceRegisterPageState createState() => _FaceRegisterPageState();
}

class _FaceRegisterPageState extends State<FaceRegisterPage> {
  File? _cameraVideo;
  final picker = ImagePicker();
  String albumName = 'Media';
  // 이미지를 보여주는 위젯
  Widget showGuideLine() {
    return Container(
        color: const Color(0xffd0cece),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Center(
          child: Text('가이드 라인'),
        ));
    //: Image.file(File(_image!.path))));
  }

  @override
  Widget build(BuildContext context) {
    // 화면 세로 고정
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Car Keeper",
            style: h5(
              mColor: Color(0xFF06A66C),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25.0),
            showGuideLine(),
            SizedBox(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: "video",
                  child: Icon(Icons.video_camera_front_outlined),
                  onPressed: () {
                    getVideo(ImageSource.gallery);
                  },
                ),
                FloatingActionButton(
                  heroTag: "upload",
                  child: Icon(Icons.upload),
                  onPressed: () {
                    _uploadFile(context);
                  },
                )
              ],
            )
          ],
        ));
  }

  Future getVideo(ImageSource imageSource) async {
    final video = await picker.pickVideo(source: imageSource);
    setState(() {
      _cameraVideo = File(video!.path);
    });
  }

  void takeVideo() async {
    videoSelect = true;
    XFile? file = await picker.pickVideo(
      source: ImageSource.camera,
    );
    print(file);
    GallerySaver.saveVideo(file!.path).then((bool? success) {
      setState(() {
        print("save video");
      });
    });
  }

  Future _uploadFile(BuildContext context) async {
    try {
      // 스토리지에 업로드할 파일 경로
      final firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('post_video') //'post'라는 folder를 만들고
          .child('${DateTime.now().millisecondsSinceEpoch}.mp4');

      // 파일 업로드
      final uploadTask = firebaseStorageRef.putFile(
          _cameraVideo!, SettableMetadata(contentType: 'video/mp4'));

      // 완료까지 기다림
      await uploadTask.whenComplete(() => null);

      // 업로드 완료 후 url
      final downloadUrl = await firebaseStorageRef.getDownloadURL();
      print(downloadUrl);
      videoSelect = false;
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
