import 'package:flutter/material.dart';

class MyTag extends StatelessWidget {
  MyTag({@required this.tag, this.isEmphasize = false, this.radius = 3.0});

  final String tag;
  final bool isEmphasize;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: new EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        border: Border.all(color: isEmphasize ? Colors.red : Colors.black, width: 0.5),
        color: isEmphasize ? Colors.red : Colors.white,
        borderRadius: BorderRadius.circular((radius)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 3.0),
        child: Text(
          tag,
          style: TextStyle(fontSize: 10.0, color: isEmphasize ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
