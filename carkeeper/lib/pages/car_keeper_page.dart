import 'package:carkeeper/pages/face_register_page.dart';
import 'package:carkeeper/pages/home_screen_page.dart';
import 'package:carkeeper/pages/record_page.dart';
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

  late List<GlobalKey<NavigatorState>> _navigatorKeyList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatorKeyList = List.generate(
        _widgetOptions.length, (index) => GlobalKey<NavigatorState>());
  }

  // 메인 위젯
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !(await _navigatorKeyList[_selectedIndex]
            .currentState!
            .maybePop());
      },
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions.map((page) {
            int index = _widgetOptions.indexOf(page);
            return Navigator(
              key: _navigatorKeyList[index],
              onGenerateRoute: (_) {
                return MaterialPageRoute(builder: (context) => page);
              },
            );
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.text_snippet),
              label: '감지 내역',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: '사용자 등록',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF06A66C),
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
