import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'websockets.dart';

class VideoStream extends StatefulWidget {
  const VideoStream({Key? key}) : super(key: key);
  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  late WebSocket _socket;
  late List<String> cameraInfo;
  bool _isConnected = true;
  bool isFullscreen = false;
  void ChangeScreenSize() {
    setState(() {
      isFullscreen = !isFullscreen;
    });
  }

  @override
  void initState() {
    _socket = WebSocket("ws://192.168.25.33:6000");
    _socket.connect();
  }
  // void disconnect() {
  //   _socket.disconnect();
  //   setState(() {
  //     _isConnected = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10.0,
            ),
            _isConnected
                ? StreamBuilder(
                    stream: _socket.stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        print('socket does not have data!');
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        return const Center(
                          child: Text("Connection Closed !"),
                        );
                      }
                      //? Working for single frames
                      if (isFullscreen) {
                        return Image.memory(
                          Uint8List.fromList(
                            base64Decode(
                              (snapshot.data.toString()),
                            ),
                          ),
                          gaplessPlayback: true,
                          excludeFromSemantics: true,
                        );
                      } else {
                        return Image.memory(
                            Uint8List.fromList(
                              base64Decode(
                                (snapshot.data.toString()),
                              ),
                            ),
                            width: double.infinity,
                            gaplessPlayback: true,
                            excludeFromSemantics: true);
                      }
                    },
                  )
                : const Text("통신이 원활하지 않습니다."),
            isFullscreen
                ? ElevatedButton(
                    onPressed: ChangeScreenSize,
                    child: const Text("X"),
                  )
                : ElevatedButton(
                    onPressed: ChangeScreenSize,
                    child: const Text("확대하기"),
                  )
          ],
        ),
      ),
    );
  }
}
