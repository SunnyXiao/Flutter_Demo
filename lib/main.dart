import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/src/tabScaffold.dart';
import 'package:flutter_app/src/route/city/city.dart';
import 'package:flutter_app/src/route/search.dart';

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
      home: TabScaffold(),
      routes: {'/Citys': (context) => CityWidget(), '/Search': (context) => SearchPage()},
      // initialRoute: '/home',
    );
  }
}
