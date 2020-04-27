import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/route/home/homeMenu.dart';
import 'package:flutter_app/src/custome-widget/ImageButton.dart';
// import 'package:flutter_app/src/custome-widget/SlideAnimationWidget.dart';
import 'package:flutter_app/src/custome-widget/ScenicCard.dart';
import 'package:flutter_app/src/custome-widget/MyTag.dart';
import 'package:flutter_app/src/custome-widget/Discounts.dart';
import 'package:flutter_app/src/custome-widget/HomeDeleteDialog.dart';
import 'package:flutter_app/src/route/home/homeBanner.dart';
import 'package:flutter_app/src/models/banner_entity.dart';
import 'package:flutter_app/src/api/home_api_service.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({@required this.screenWidth, String city}) {
    curCity = city;
  }

  final double screenWidth;
  String curCity;

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  BannerEntity _entity;
  String curCity = '广州';
  String barcode = "";
  ScrollController _controller = new ScrollController();
  List<ScenicCard> scenicCard = new List<ScenicCard>();

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
                onTap: () {
                  _jumpToCitysWidget();
                  // Navigator.pushNamed(context, '/Citys');
                },
                // onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CityWidget())),
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
                child: GestureDetector(
                  onTap: () {
                    _onTapMenu();
                  },
                  child: Icon(
                    //按钮图标
                    Icons.add,
                    size: 26,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBannerData();
    _controller = ScrollController();
    _controller.addListener(() {});
    var data = ScenicCard(
        onDelete: _showDeleteDialog,
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
    setState(() {
      scenicCard.add(data);
      scenicCard.add(data);
    });
  }

  void _jumpToCitysWidget() async {
    var selectCity = await Navigator.pushNamed(context, '/Citys', arguments: curCity);
    if (selectCity == null) return;
  }

  Future<void> getBannerData() async {
    try {
      var response = await HomeApiService.getBannerData();
      String jsonSrc = json.encode(response);
      //var map = await json.decode(jsonSrc);
      Map<String, dynamic> map = await json.decode(jsonSrc);
      BannerEntity bannerEntity = BannerEntity.fromJson(map);
      setState(() {
        _entity = bannerEntity;
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> _refresh() async {
    // setState(() {
    //   scenicCard.clear();
    // });
  }

  @override
  Widget build(BuildContext context) {
    final bodyNav = _initBody();
    return Scaffold(
      appBar: _buildHomeAppBar(),
      // drawer: new MyDrawer(),
      body: Container(
        color: Color.fromRGBO(240, 240, 240, 0.4),
        child: RefreshIndicator(
          onRefresh: () => Future.delayed(Duration(seconds: 2), _refresh),
          child: new ListView.builder(
            controller: _controller, //绑定滚动控制器，key等
            itemCount: bodyNav.length + scenicCard.length,
            itemBuilder: (context, index) {
              if (index >= bodyNav.length) {
                return scenicCard[index - bodyNav.length];
              } else {
                return bodyNav[index];
              }
            },
          ),
        ),
      ),
    );
  }

  _onTapMenu() async {
    HomeMenu.show(context);
  }

  //构建一行功能按钮
  List<Widget> _buildTitle(
      List<Map<String, dynamic>> strs, List<Map<String, dynamic>> urls, List<String> tips, double width, Color color) {
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
            onTap: strs[i]['fn'] == null ? null : strs[i]['fn'],
            child: MyImageButton(
              image: iconOrImage,
              title: strs[i]['text'],
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
    List<Map<String, dynamic>> header = [
      {'text': '扫一扫', 'fn': null},
      {'text': '付款码', 'fn': null},
      {'text': '骑车', 'fn': null},
      {'text': '乘公交', 'fn': null}
    ];
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

  List<Widget> _initBody() {
    final screenWidth = widget.screenWidth;
    List<Map<String, dynamic>> header = [
      {'text': '外卖', 'fn': null},
      {'text': '美食', 'fn': null},
      {'text': '酒店住所', 'fn': null},
      {'text': '休闲/玩乐', 'fn': null},
      {'text': '电影/演出', 'fn': null}
    ];
    List<Map<String, dynamic>> headerUrl = [
      {'Icon': 'images/homepage_icon_light_takeout_b.png', 'type': 'Image', 'width': 50.0, 'height': 50.0},
      {'Icon': 'images/homepage_icon_light_food_b.png', 'type': 'Image', 'width': 50.0, 'height': 50.0},
      {'Icon': 'images/homepage_icon_light_hotel_b.png', 'type': 'Image', 'width': 50.0, 'height': 50.0},
      {'Icon': 'images/homepage_icon_light_amusement_b.png', 'type': 'Image', 'width': 50.0, 'height': 50.0},
      {'Icon': 'images/homepage_icon_light_movie_b.png', 'type': 'Image', 'width': 50.0, 'height': 50.0}
    ];
    List<Map<String, dynamic>> title2 = [
      {'text': '打车', 'fn': null},
      {'text': '丽人/美发', 'fn': null},
      {'text': '跑腿代购', 'fn': null},
      {'text': '借钱/信用卡', 'fn': null},
      {'text': '火车票/机票', 'fn': null}
    ];
    List<Map<String, dynamic>> url2 = [
      {'type': 'Image', 'Icon': 'images/car.png', 'width': 26.0, 'height': 26.0},
      {'type': 'Image', 'Icon': "images/icon_homepage_beautyCategory.png", 'width': 26.0, 'height': 26.0},
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
        child: HomeBanner(entity: _entity),
        // child: SlideAnimationWidget(
        //   height: 180,
        // ),
      ),
      Container(
        padding: EdgeInsets.only(top: 30.0, bottom: 14.0, left: 10.0, right: 10.0),
        child: Text('猜你喜欢'),
      ),
    ];
  }

  //推荐卡片中关闭对话框里的圆角边框按钮
  Widget _buildMyButton(String title) {
    return GestureDetector(
      onTap: () => {print('dd')},
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.5),
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 12.0, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(Widget selectedItem, double dx, double dy) {
    var dialog = HomeDeleteDialog(
      dx: dx,
      dy: dy,
      titlePadding: EdgeInsets.only(top: 20),
      title: Column(
        children: <Widget>[
          Text(
            "选择具体理由，会减少相关推荐呦",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildMyButton("去过了"),
              SizedBox(
                width: 10,
              ),
              _buildMyButton("不感兴趣"),
              SizedBox(
                width: 10,
              ),
              _buildMyButton("价格不合适"),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CupertinoColors.lightBackgroundGray,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Text(
                "不感兴趣",
                style: TextStyle(fontSize: 12, color: Colors.teal),
              ),
            ),
          ),
        ],
      ),
    );

    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }
}
