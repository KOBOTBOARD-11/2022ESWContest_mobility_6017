import 'package:carkeeper/pages/face_register_page.dart';
import 'package:carkeeper/pages/home_screen_page.dart';
import 'package:carkeeper/pages/record_page.dart';
import 'package:carkeeper/pages/stream_page.dart';
import 'package:flutter/material.dart';

class CarKeeperPage extends StatefulWidget {
  const CarKeeperPage({Key? key}) : super(key: key);

  @override
  State<CarKeeperPage> createState() => _CarKeeperPageState();
}

class _CarKeeperPageState extends State<CarKeeperPage> {
  int _selectedIndex = 1;
  final List<Widget> _widgetOptions = <Widget>[
    RecordPage(),
    HomeScreenPage(),
    FaceRegisterPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet, color: Color(0xFF06A66C)),
            label: '감지 내역',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF06A66C)),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: Color(0xFF06A66C)),
            label: '사용자 등록',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF06A66C),
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
