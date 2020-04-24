import 'package:flutter/material.dart';
import 'package:flutter_app/src/route/city/innerCountry.dart';
import 'package:flutter_app/src/route/city/outerCountry.dart';

class CityWidget extends StatefulWidget {
  @override
  _CityWidget createState() => _CityWidget();
}

class _CityWidget extends State<CityWidget> with SingleTickerProviderStateMixin {
  String curCity;

  List<String> hotCitys = ['北京', '上海', '广州', '深圳', '成都', '武汉', '杭州', '重庆', '郑州', '南京', '西安', '苏州', '长沙', '天津', '福州'];
  List tabs = ["国内", "国际/港澳台"];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    curCity = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Color(0xE3FFFFFF),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.teal),
        title: GestureDetector(
          //GestureDetector捕获手势
          onTap: null,
          child: Container(
            height: 36.0,
            width: 280,
            child: Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(22.0)),
              ),
              color: Color.fromRGBO(240, 240, 240, 1), //背景色
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.search, color: Colors.black, size: 20.0),
                    Text(
                      '城市名/拼音',
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              child: TabBar(
                labelColor: Colors.teal,
                indicatorColor: Colors.teal,
                unselectedLabelColor: Colors.black,
                controller: _tabController,
                tabs: tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _tabController,
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[new InnerCountryWidget(), new OuterCountryWidget()],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
