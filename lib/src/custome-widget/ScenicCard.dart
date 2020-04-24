import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/utils/Screen.dart';

typedef OnPressCallback = void Function(Widget selectedItem, double posX, double posY);

Widget _buildImage(double width, double height, String url, double price, String name) {
  return Column(
    children: <Widget>[
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              url,
              fit: BoxFit.fitHeight,
              width: width,
              height: height,
            ),
          ),
          Container(
            width: width,
            child: Stack(
              children: <Widget>[
                Opacity(
                  opacity: 0.6,
                  child: Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(8.0), bottomRight: Radius.circular(8.0)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.white, Colors.black])),
                    alignment: Alignment.center,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 30.0,
                  child: Text(
                    '￥' + price.toString(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Text(name),
      )
    ],
  );
}

class ScenicCard extends StatelessWidget {
  ScenicCard(
      {@required this.title,
      @required this.discount,
      @required this.prices,
      @required this.names,
      @required this.imageUrls,
      @required this.score,
      @required this.address,
      @required this.arriveTime,
      this.onDelete,
      this.tags = const <Widget>[]});

  final String title;
  final Widget discount;
  final List<Widget> tags;
  final List<String> imageUrls;
  final List<double> prices;
  final List<String> names;
  final String score;
  final String address;
  final String arriveTime;
  final OnPressCallback onDelete;

  double _globlePositionX = 0.0; //点击位置的横坐标
  double _globlePositionY = 0.0; //点击位置的纵坐标

  @override
  Widget build(BuildContext context) {
    final imageWidth = (Screen.width(context) - 60.0) / 3.0;
    final imageHeight = imageWidth - 20.0;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: InkWell(
        child: Card(
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 12.0),
                            child: Text(title, style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600)),
                          ),
                          DecoratedBox(
                            decoration:
                                BoxDecoration(gradient: LinearGradient(colors: [Colors.orange[200], Colors.orange])),
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                '外卖',
                                style: TextStyle(fontSize: 12.0, color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //卡片删除
                    Container(
                      height: 12.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: GestureDetector(
                        onTap: () => onDelete(this, _globlePositionX, _globlePositionY),
                        onTapDown: (TapDownDetails downDetails) => {
                          _globlePositionX = downDetails.globalPosition.dx,
                          _globlePositionY = downDetails.globalPosition.dy,
                        },
                        child: Icon(Icons.close, size: 10.0),
                      ),
                      // child: IconButton(
                      //   padding: EdgeInsets.zero,
                      //   onPressed: () => onDelete(this),
                      //   icon: Icon(
                      //     Icons.close,
                      //     size: 10.0,
                      //   ),
                      // ),
                    )
                  ],
                ),
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            score,
                            style: TextStyle(color: Colors.orange, fontSize: 12.0),
                          ),
                          Text(address, style: TextStyle(color: Colors.black, fontSize: 12.0))
                        ],
                      ),
                    ),
                    Text(
                      arriveTime,
                      style: TextStyle(color: Colors.black, fontSize: 12.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: <Widget>[discount],
                ),
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: tags,
                ),
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildImage(imageWidth, imageHeight, imageUrls[0], prices[0], names[0]),
                    _buildImage(imageWidth, imageHeight, imageUrls[1], prices[1], names[1]),
                    _buildImage(imageWidth, imageHeight, imageUrls[2], prices[2], names[2]),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
