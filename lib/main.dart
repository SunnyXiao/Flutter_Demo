import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './home.dart';
import './order.dart';
import './mine.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('zh'), // Chinese
      ],
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Hello, Flutter 美团'),
      // routes: {
      //   '/home': (context) => HomeWidget(),
      //   '/order': (context) => OrderWidget(),
      //   '/mine': (context) => MineWidget()
      // },
      // initialRoute: '/home',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final _widgetItems = [HomeWidget(), OrderWidget(), MineWidget()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //刷新界面
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
          BottomNavigationBarItem(
              icon: new Image.asset(
                'images/order.jpg',
                fit: BoxFit.cover,
                width: 18,
              ),
              title: Text('订单')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text('我的'))
        ],
        currentIndex: _selectedIndex,
        fixedColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
      body: Center(child: _widgetItems[_selectedIndex]),
    );
  }
}
