// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/route/home.dart';
import 'package:flutter_app/src/route/order.dart';
import 'package:flutter_app/src/route/mine.dart';
import 'package:flutter_app/utils/Screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter demo",
      //theme: defaultTargetPlatform == TargetPlatform.iOS
      // ? PlatformTheme.iOS
      // : PlatformTheme.android, // 根据平台选择，可自定义主题
      home: TabScaffold(),
    );
  }
}

class TabScaffold extends StatefulWidget {
  @override
  _TabScaffold createState() => _TabScaffold();
}

class _TabScaffold extends State<TabScaffold> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //刷新界面
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Screen.width(context);
    final bodys = [
      HomeWidget(screenWidth: screenWidth),
      OrderWidget(),
      MineWidget()
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('订单')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text('我的'))
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
      body: bodys[_selectedIndex],
    );
  }
}
