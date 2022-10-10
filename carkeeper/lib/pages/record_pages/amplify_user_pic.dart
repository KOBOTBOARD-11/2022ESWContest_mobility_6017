import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class AmplifyUserPic extends StatelessWidget {
  final userImageSrc;

  const AmplifyUserPic({required this.userImageSrc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 50),
          ExtendedImage.network(
            userImageSrc,
            cache: false,
          ),
          Opacity(
            opacity: 0.5,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.cancel_outlined,
                size: 50,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
