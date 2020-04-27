import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/banner_entity.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeBanner extends StatefulWidget {
  HomeBanner({Key key, this.bannerHeight = 180, this.entity}) : super(key: key);

  final double bannerHeight;
  final BannerEntity entity;

  @override
  _HomeBannerWidget createState() => _HomeBannerWidget();
}

class _HomeBannerWidget extends State<HomeBanner> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<Data> datas = List();
    if (widget.entity != null) {
      datas = widget.entity.data;
    }

    // TODO: implement build
    return new Container(
//      constraints: new BoxConstraints.loose(new Size(
//          MediaQuery.of(context).size.width - 15)),
      height: datas.isEmpty ? 0 : widget.bannerHeight,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: datas.isEmpty
          ? Container()
          : new Swiper(
              onTap: (index) {},
              containerHeight: widget.bannerHeight,
              autoplay: true,
              itemBuilder: (BuildContext context, int index) {
                return new CachedNetworkImage(
                  imageUrl: datas[index].bigImgTypeUrl,
                  fit: BoxFit.fill,
                );
              },
              itemCount: datas.length,
              pagination: new SwiperPagination(),
            ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
