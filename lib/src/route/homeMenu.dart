import 'package:flutter/material.dart';
import 'package:flutter_app/src/route/animationDemo.dart';

typedef onTapCallBack = void Function();

class HomeMenu extends StatelessWidget {
  static show(BuildContext context) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        // 无动画的切换
        opaque: false,
        transitionDuration: Duration(seconds: 0),
        pageBuilder: (context, anim1, anim2) => HomeMenu(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[Positioned(right: 10, top: 100, child: HomeMenuAlert())],
        ),
      ),
    );
  }
}

class HomeMenuAlert extends StatelessWidget {
  final double paddingDd = 4.0;

  void _openMyPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AnimatedWidgetsTest()));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.black87,
        clipBehavior: Clip.antiAlias,
        elevation: 0.0,
        shape: ShapedBoarder(borderRadius: BorderRadius.all(Radius.circular(paddingDd)), padding: paddingDd),
        child: Container(
          color: Colors.black87,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: SizedBox(
            width: 90.0,
            height: 144.0,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                _buildAlertItem(Icons.image, "扫一扫", () => {_openMyPage(context)}),
                Divider(color: Colors.white70),
                _buildAlertItem(Icons.scanner, "付款码", () => {_openMyPage(context)}),
                Divider(color: Colors.white70),
                _buildAlertItem(Icons.scanner, "开发票", () => {_openMyPage(context)}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlertItem(IconData iconData, String title, onTapCallBack onPressEvent) {
    return GestureDetector(
      onTap: () => {onPressEvent()},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.white,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

class ShapedBoarder extends RoundedRectangleBorder {
  ShapedBoarder({@required this.padding, side = BorderSide.none, borderRadius = BorderRadius.zero})
      : super(side: side, borderRadius: borderRadius);

  final double padding;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..moveTo(rect.right - 12, rect.top - 8)
      ..lineTo(rect.topRight.dx - 18, rect.top) // 顶点
      ..lineTo(rect.topRight.dx - 6, rect.top)
      ..addRRect(
        borderRadius.resolve(textDirection).toRRect(
              Rect.fromLTWH(rect.left, rect.top, rect.width, rect.height - padding),
            ),
      );
  }
}
