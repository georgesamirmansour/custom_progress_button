import 'package:flutter/material.dart';

class CustomIconButton {
  final String? text;
  final Widget? icon;
  final Color color;

  const CustomIconButton({
    this.text,
    this.icon,
    required this.color,
  });
}

Widget buildChildWithIcon(
    CustomIconButton iconButton, double iconPadding, TextStyle textStyle) {
  return buildChildWithIC(
      iconButton.text, iconButton.icon, iconPadding, textStyle);
}

Widget buildChildWithIC(
    String? text, Widget? icon, double gap, TextStyle textStyle) {
  var children = <Widget>[];
  children.add(icon ?? Container());
  if (text != null) {
    children.add(Padding(padding: EdgeInsets.all(gap)));
    children.add(buildText(text, textStyle));
  }

  return Wrap(
    direction: Axis.horizontal,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: children,
  );
}

Widget buildText(String text, TextStyle style) {
  return Text(text, style: style);
}
