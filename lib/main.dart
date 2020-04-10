import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/src/tabScaffold.dart';

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
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('zh'), // Chinese
      ],
      // theme: ThemeData(primarySwatch: Colors.transparent),
      home: TabScaffold(),
      // routes: {
      //   '/home': (context) => HomeWidget(),
      //   '/order': (context) => OrderWidget(),
      //   '/mine': (context) => MineWidget()
      // },
      // initialRoute: '/home',
    );
  }
}
