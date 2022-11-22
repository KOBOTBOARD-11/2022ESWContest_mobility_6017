import 'dart:io';
import 'package:carkeeper/pages/camera_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../styles.dart';

class FaceRegisterPage extends StatefulWidget {
  const FaceRegisterPage({Key? key}) : super(key: key);

  @override
  _FaceRegisterPageState createState() => _FaceRegisterPageState();
}

class _FaceRegisterPageState extends State<FaceRegisterPage> {
  File? _cameraVideo;
  final picker = ImagePicker();
  // 이미지를 보여주는 위젯
  Widget showGuideLine() {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("assets/face_register_guide_image.gif"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "1.  등록하러 가기를 누르시고 \n\t화면의 영상처럼\n\t얼굴을 15초간 찍어주세요.",
                  style: subtitle3(mColor: Colors.black),
                ),
                const SizedBox(height: 5),
                Text(
                  "2.  빨간 버튼을 누르시면\n\t촬영이 시작됩니다.\n\t20초 뒤에 자동으로 촬영이 끝나요.",
                  style: subtitle3(mColor: Colors.black),
                ),
                const SizedBox(height: 5),
                Text(
                  "3.  업로드 버튼을 눌러서\n\t영상을 전송하면 등록 끝!",
                  style: subtitle3(mColor: Colors.black),
                ),
              ],
            ),
          ],
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
              mColor: const Color(0xFF06A66C),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            showGuideLine(),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CameraPage()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: const Color(0xFF06A66C),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "등록하러 가기",
                    style: h5(mColor: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future getVideo(ImageSource imageSource) async {
    final video = await picker.pickVideo(source: imageSource);
    setState(() {
      _cameraVideo = File(video!.path);
    });
  }

  Future uploadFile(BuildContext context) async {
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
