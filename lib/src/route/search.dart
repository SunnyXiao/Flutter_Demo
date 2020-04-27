import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: CupertinoTextField(
                  padding: EdgeInsets.all(8),
                  autofocus: true,
                  style: TextStyle(fontSize: 14),
                  prefix: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 22,
                    ),
                  ),
                  placeholder: "外卖点什么，来选选",
                  placeholderStyle: TextStyle(fontSize: 14, color: Colors.grey, height: 1),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45.0),
                    color: CupertinoColors.lightBackgroundGray,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '取消',
                    style: TextStyle(color: Colors.teal, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
