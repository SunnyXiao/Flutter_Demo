import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeWidgetState();
  }
}

class HomeWidgetState extends State<HomeWidget> {
  String curCity = '广州';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
            height: 60,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: <Widget>[
                GestureDetector(
                    child: Text(
                      curCity,
                      style: TextStyle(fontSize: 14),
                    ),
                    onTap: null),
                Icon(Icons.keyboard_arrow_down),
                Expanded(
                    flex: 1,
                    child: TextField(
                      decoration: InputDecoration(hintText: '晚饭外卖点什么，来选选'),
                    )),
              ],
            ))
      ],
    );
  }
}
