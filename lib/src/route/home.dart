import 'dart:developer';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/src/route/city.dart';
import 'package:flutter_app/src/custome-widget/ImageButton.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({@required this.screenWidth});

  final double screenWidth;
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String curCity = '广州';

  AppBar _buildHomeAppBar() {
    return AppBar(
        elevation: 4,
        backgroundColor: Colors.teal,
        flexibleSpace: SafeArea(
          //可伸缩的空闲区域
          //适配刘海，自动避开刘海，IOS底部导航的非显示区域
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // 天气
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.cloud_queue,
                      size: 15.0,
                      color: Colors.white,
                    ),
                    Text('26',
                        style: TextStyle(color: Colors.white, fontSize: 14.0))
                  ],
                ),
              ),
              // 地点
              InkWell(
                //水波纹特效
                onTap: () => Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => CityWidget())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      curCity,
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                    Icon(Icons.keyboard_arrow_down,
                        color: Colors.white, size: 14.0),
                  ],
                ),
              ),
              //搜索框
              Expanded(
                child: GestureDetector(
                  //GestureDetector捕获手势
                  onTap: null,
                  child: Container(
                    height: 42.0,
                    child: Card(
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(22.0)),
                      ),
                      color: Colors.teal[400], //背景色
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(Icons.search, color: Colors.white, size: 20.0),
                            Text(
                              '暖暖下午茶，点个外卖',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: PopupMenuButton(
                  //弹出菜单按钮
                  child: Icon(
                    //按钮图标
                    Icons.add,
                    size: 26,
                    color: Colors.white,
                  ),
                  itemBuilder: (context) => <PopupMenuEntry>[
                        PopupMenuItem(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.image),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("扫一扫"),
                              ],
                            ),
                          ),
                        ),
                        PopupMenuItem(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.scanner),
                                SizedBox(
                                  width: 20,
                                ),
                                Text('付款码')
                              ],
                            ),
                          ),
                        ),
                      ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> _refresh() async {}

  @override
  Widget build(BuildContext context) {
    final bodyHeader = _initBodyHeader();
    return Scaffold(
      appBar: _buildHomeAppBar(),
      body: Container(
        child: Column(
          children: <Widget>[bodyHeader],
        ),
        // child: RefreshIndicator(
        //     child: AnimatedList(itemBuilder: (context, index, animation) {
        //       return bodys[index];
        //     }),
        //     onRefresh: () => Future.delayed(Duration(seconds: 2), _refresh)),
      ),
    );
  }

  //构建一行功能按钮
  List<Widget> _buildTitle(
      List<String> strs, List<String> urls, List<String> tips, double width) {
    List<Widget> titleList = <Widget>[];
    for (int i = 0; i < strs.length; i++) {
      titleList.add(Flexible(
        flex: 1,
        child: MyImageButton(
          image: Icon(Icons.scanner),
          // image: Image.asset(
          //   urls[i],
          //   width: width,
          //   height: width,
          // ),
          title: strs[i],
          tip: !tips[i].isNotEmpty ? tips[i] : null,
        ),
      ));
    }
    return titleList;
  }

  Widget _initBodyHeader() {
    final screenWidth = widget.screenWidth;
    const header = <String>['扫一扫', '付款码', '骑车', '乘公交'];
    const headerUrl = <String>['Scanner', 'Scanner', 'Scanner', 'Scanner'];
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _buildTitle(header, headerUrl, [], screenWidth / 7),
      ),
    );
  }

  // List<Widget> _initBody() {
  //   final screenWidth = widget.screenWidth;
  //   const header = <String>['扫一扫', '付款码', '骑车', '乘公交'];
  //   const headerUrl = <String>[];
  //   return <Widget>[
  //     Container(
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: _buildTitle(header, headerUrl, [], screenWidth / 7),
  //       ),
  //     ),
  //     Container()
  //   ];
  // }
}
