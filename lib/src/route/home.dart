import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/src/route/city.dart';
import 'package:flutter_app/src/custome-widget/ImageButton.dart';
import 'package:flutter_app/src/custome-widget/SlideAnimationWidget.dart';
import 'package:flutter_app/src/custome-widget/ScenicCard.dart';
import 'package:flutter_app/src/custome-widget/MyTag.dart';
import 'package:flutter_app/src/custome-widget/Discounts.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({@required this.screenWidth});

  final double screenWidth;
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String curCity = '广州';
  // List<Widget> _list;

  AppBar _buildHomeAppBar() {
    return AppBar(
        elevation: 0.0,
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
                    Text('26', style: TextStyle(color: Colors.white, fontSize: 14.0))
                  ],
                ),
              ),
              // 地点
              InkWell(
                //水波纹特效
                onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CityWidget())),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      curCity,
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 14.0),
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
                              style: TextStyle(fontSize: 14.0, color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    final bodyNav = _initNav();
    return Scaffold(
      appBar: _buildHomeAppBar(),
      body: Container(
        color: Colors.black12,
        child: ListView(children: bodyNav),
      ),
    );
  }

  //构建一行功能按钮
  List<Widget> _buildTitle(
      List<String> strs, List<Map<String, dynamic>> urls, List<String> tips, double width, Color color) {
    List<Widget> titleList = <Widget>[];
    for (int i = 0; i < strs.length; i++) {
      var imgData = urls[i];
      var iconOrImage = imgData['type'] == 'Icon'
          ? Icon(imgData['Icon'])
          : Image.asset(
              imgData['Icon'],
              width: imgData['width'] == null ? width : imgData['width'],
              height: imgData['height'] == null ? width : imgData['height'],
              color: color != null ? color : null,
            );
      titleList.add(
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: null,
            child: MyImageButton(
              image: iconOrImage,
              title: strs[i],
              tip: tips.isNotEmpty && tips[i].isNotEmpty ? tips[i] : null,
              color: color != null ? color : null,
            ),
          ),
        ),
      );
    }
    return titleList;
  }

  Widget _initBodyHeader() {
    final screenWidth = widget.screenWidth;
    const header = <String>['扫一扫', '付款码', '骑车', '乘公交'];
    List<Map<String, dynamic>> headerUrl = [
      {'Icon': 'images/scanning.png', 'type': 'Image', 'width': 30.0, 'height': 30.0},
      {'Icon': 'images/barcode.webp', 'type': 'Image', 'width': 30.0, 'height': 30.0},
      {'Icon': 'images/downhill-cycle.webp', 'type': 'Image', 'width': 30.0, 'height': 30.0},
      {'Icon': 'images/bus.png', 'type': 'Image', 'width': 30.0, 'height': 30.0}
    ];
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      color: Colors.teal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildTitle(header, headerUrl, [], screenWidth / 7, Colors.white),
      ),
    );
  }

  //构建推荐卡片
  Widget _buildCard1() {
    return ScenicCard(
        onDelete: null,
        discount: Discounts(['28减2', '39减4', '首单减14']),
        score: "4.8分",
        address: " | 月售2884 | 配送￥5 | 人均￥30",
        title: "故宫博物院（故宫) (5A)",
        arriveTime: "55分钟送达",
        tags: <Widget>[
          MyTag(tag: "网红地打卡"),
          MyTag(tag: "帝王宫殿"),
          MyTag(tag: "5A景点"),
        ],
        imageUrls: <String>[
          "http://p0.meituan.net/travel/83544ca4b38bbe0f7644982c3528defd117921.jpg@660w_500h_1e_1c",
          "http://p1.meituan.net/poi/e732ed2314a1a2619e6c3254fd2f1fd0112611.jpg",
          "http://p0.meituan.net/poi/e7d94c4d609e5dd4d71bcea6a5eb0c5e220371.jpg"
        ],
        prices: <double>[
          30.0,
          27.0,
          21.0
        ],
        names: <String>[
          '多肉蒲桃',
          '多肉茫茫',
          '烤焦鲜奶'
        ]);
  }

  List<Widget> _initNav() {
    final screenWidth = widget.screenWidth;
    const header = <String>['外卖', '美食', '酒店住所', '休闲/玩乐', '电影/演出'];
    List<Map<String, dynamic>> headerUrl = [
      {'Icon': 'images/scanning.png', 'type': 'Image', 'width': 50.0, 'height': 50.0},
      {'Icon': 'images/eat-circle-orange-512.webp', 'type': 'Image', 'width': 50.0, 'height': 50.0},
      {'Icon': 'images/downhill-cycle.webp', 'type': 'Image', 'width': 50.0, 'height': 50.0},
      {'Icon': 'images/bus.png', 'type': 'Image', 'width': 50.0, 'height': 50.0},
      {'Icon': 'images/bus.png', 'type': 'Image', 'width': 50.0, 'height': 50.0}
    ];
    const title2 = <String>[
      "打车",
      "丽人/美发",
      "跑腿代购",
      "借钱/信用卡",
      "火车票/机票",
    ];
    List<Map<String, dynamic>> url2 = [
      {'type': 'Image', 'Icon': 'images/car.png', 'width': 26.0, 'height': 26.0},
      {'type': 'Image', 'Icon': "images/beauty.png", 'width': 26.0, 'height': 26.0},
      {'type': 'Image', 'Icon': "images/beauty.png", 'width': 26.0, 'height': 26.0},
      {'type': 'Image', 'Icon': "images/beauty.png", 'width': 26.0, 'height': 26.0},
      {'type': 'Image', 'Icon': "images/plane_takeoff.png", 'width': 26.0, 'height': 26.0},
    ];
    return <Widget>[
      _initBodyHeader(),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildTitle(header, headerUrl, [], screenWidth / 7, null),
        ),
      ),
      SizedBox(
        height: 16.0,
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _buildTitle(title2, url2, [], screenWidth / 7, null),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 30.0, bottom: 0.0),
        child: SlideAnimationWidget(
          height: 180,
        ),
      ),
      Text('猜你喜欢'),
      _buildCard1()
    ];
  }
}
