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

enum AdapType {
  ADA_2,
  ADA_3,
  ADA_4,
  ADA_5
}
extension AdapTypeExt on AdapType {
  int get count {
    switch(this) {
      case AdapType.ADA_2:
        return 2;
      case AdapType.ADA_3:
        return 3;
      case AdapType.ADA_4:
        return 4;
      case AdapType.ADA_5:
        return 5;
      default:
        return 1;
    }
  }
}