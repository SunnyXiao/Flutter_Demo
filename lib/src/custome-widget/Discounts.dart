import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Discounts extends StatelessWidget {
  Discounts(this.discountsTage);

  final List<String> discountsTage;
  @override
  Widget build(BuildContext context) {
    if (discountsTage.length > 0) {
      final tagList = _buildTag(discountsTage);
      return Container(
        child: Row(children: tagList),
      );
    } else {
      return null;
    }
  }

  List<Widget> _buildTag(List<String> tags) {
    List<Widget> tagList = <Widget>[];
    final tagTitle = Container(
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.orange[400], Colors.red]),
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text('优惠', style: TextStyle(color: Colors.white, fontSize: 10.0)),
    );
    tagList.add(tagTitle);
    for (int i = 0, _len = tags.length; i < _len; i++) {
      tagList
          .add(Text(i == _len - 1 ? tags[i] : tags[i] + ', ', style: TextStyle(color: Colors.black, fontSize: 12.0)));
    }
    return tagList;
  }
}
