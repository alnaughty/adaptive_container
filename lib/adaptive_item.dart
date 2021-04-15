import 'package:flutter/material.dart';

class AdaptiveItem {
  final double? height;
  final double? width;
  final Widget? content;
  final Color? bgColor;
  AdaptiveItem({this.height, this.content, this.bgColor = Colors.transparent, this.width});
}
extension AdaptiveWidget on AdaptiveItem {
  Widget get asWidget => Container(
    height: height,
    width: width,
    child: content,
    color: bgColor,
  );

}