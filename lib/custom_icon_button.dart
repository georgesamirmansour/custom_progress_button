import 'package:flutter/material.dart';

// A custom class representing an icon button with optional text and color.
class CustomIconButton {
  // The optional text to display alongside the icon.
  final String? text;

  // The optional icon widget to display.
  final Widget? icon;

  // The color of the icon button.
  final Color color;

  const CustomIconButton({
    this.text,
    this.icon,
    required this.color,
  });
}

/// A utility function to build a widget containing an icon and optional text with a specified gap.
///
/// Parameters:
/// - [iconButton]: The custom icon button that contains the icon, optional text, and color.
/// - [iconPadding]: The padding between the icon and the text, if text is provided.
/// - [textStyle]: The style for the text, if text is provided.
///
/// Returns:
/// A widget containing the icon and optional text wrapped with appropriate padding.
Widget buildChildWithIcon(
    CustomIconButton iconButton, double iconPadding, TextStyle textStyle) {
  return buildChildWithIC(
      iconButton.text, iconButton.icon, iconPadding, textStyle);
}

/// A utility function to build a widget containing text and an icon with a specified gap.
///
/// Parameters:
/// - [text]: The text to display.
/// - [icon]: The icon widget to display.
/// - [gap]: The padding between the text and the icon.
/// - [textStyle]: The style for the text.
///
/// Returns:
/// A widget containing the provided text and icon wrapped with appropriate padding.
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

/// A utility function to build a text widget with the provided text and text style.
///
/// Parameters:
/// - [text]: The text to display.
/// - [style]: The style for the text.
///
/// Returns:
/// A text widget displaying the provided text with the specified style.
Widget buildText(String text, TextStyle style) {
  return Text(text, style: style);
}

