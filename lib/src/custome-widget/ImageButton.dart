import 'package:flutter/material.dart';
import 'package:flutter_app/src/custome-widget/MyTag.dart';

class MyImageButton extends StatelessWidget {
  MyImageButton(
      {@required this.image,
      @required this.title,
      this.width,
      this.tip,
      this.color});

  final Widget image;
  final String title;
  final double width;
  final String tip;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Stack(
        children: <Widget>[
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 12,
                ),
                image,
                SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 14.0, color: color != null ? color : null),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: tip != null
                ? MyTag(
                    tag: tip,
                    isEmphasize: true,
                    radius: 15.0,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
