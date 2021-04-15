import 'package:flutter/material.dart';

class AdaptiveItem {
  final double height;
  final Widget? content;
  final Color? bgColor;
  AdaptiveItem({required this.height, this.content, this.bgColor = Colors.transparent});
}
extension AdaptiveWidget on AdaptiveItem {
  Widget get asWidget => Container(
    height: height,
    child: content,
    color: bgColor,
  );

}