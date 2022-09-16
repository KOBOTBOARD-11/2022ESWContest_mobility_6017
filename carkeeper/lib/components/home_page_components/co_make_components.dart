import 'package:carkeeper/styles.dart';
import 'package:flutter/material.dart';

class CoMakeCompo extends StatefulWidget {
  @override
  State<CoMakeCompo> createState() => _CoMakeCompoState();
}

class _CoMakeCompoState extends State<CoMakeCompo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      height: 180,
      color: Colors.black,
      child: Text(
        'co',
        style: h5(mColor: Colors.white),
      ),
    );
  }
}
