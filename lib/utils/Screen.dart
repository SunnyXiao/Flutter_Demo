import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Screen {
  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static navigationBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top + 44;
  }

  static statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static bottomSafeHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static updateStatusBarStyle(SystemUiOverlayStyle style) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}
