import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/Screen.dart';
import 'package:flutter_app/src/custome-widget/Triangle.dart';

class HomeDeleteDialog extends StatelessWidget {
  const HomeDeleteDialog(
      {Key key,
      this.title,
      this.titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      this.children,
      this.contentPadding = const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 16.0),
      this.backgroundColor,
      this.dx,
      this.dy})
      : assert(titlePadding != null),
        assert(contentPadding != null),
        super(key: key);

  final Widget title;
  final EdgeInsetsGeometry titlePadding;
  final List<Widget> children;
  final EdgeInsetsGeometry contentPadding;
  final Color backgroundColor;
  final double dx;
  final double dy;

  Widget _renderBoy(theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13.0)),
      ),
      constraints: BoxConstraints(minWidth: 280.0),
      child: Column(
        children: <Widget>[
          if (title != null)
            Padding(
              padding: titlePadding,
              child: DefaultTextStyle(
                style: theme.textTheme.title,
                child: title,
              ),
            ),
          if (children != null)
            Flexible(
              child: SingleChildScrollView(
                padding: contentPadding,
                child: ListBody(children: children),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double h = Screen.height(context);
    final double trangileH = 30.0;

    Widget dialogChild = Stack(
      overflow: Overflow.visible,
      fit: StackFit.loose,
      children: <Widget>[
        Positioned(
            left: -23.0,
            right: -23.0,
            top: dy < h / 2 ? dy : null,
            bottom: dy < h / 2 ? null : (h - dy + trangileH),
            child: _renderBoy(theme)),
        Positioned(
          right: 0,
          top: dy < h / 2 ? dy - trangileH : null,
          bottom: dy < h / 2 ? null : (h - dy),
          child: ClipPath(
            clipper: Triangle(dir: dy - h / 2),
            child: Container(
              width: trangileH,
              height: trangileH,
              color: Colors.white,
              child: null,
            ),
          ),
        ),
      ],
      //
    );

    if (title == null)
      dialogChild = Semantics(
        namesRoute: true,
        label: 'label',
        child: dialogChild,
      );

    return Dialog(
      backgroundColor: Colors.transparent,
      // elevation: elevation,
      child: dialogChild,
    );
  }
}
