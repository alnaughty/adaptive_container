library adaptive_container;

import 'package:adaptive_container/adaptive_item.dart';
export 'package:adaptive_container/adaptive_item.dart';
import 'package:flutter/material.dart';

class AdaptiveContainer extends StatelessWidget {
  final List<AdaptiveItem> children;
  final ScrollPhysics physics;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final AdapType? type;

  AdaptiveContainer(
      {this.type = AdapType.ADA_2,
      required this.children,
      this.physics = const ClampingScrollPhysics(),
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisAlignment = MainAxisAlignment.start});

  //Process to get the child allowed in a the Column
  List<List<AdaptiveItem>> getContent(maxCount, List<AdaptiveItem> toCheck) {
    List<List<AdaptiveItem>> result = [];
    while (result.length < children.length / maxCount.floor()) {
      List<AdaptiveItem> sub = [];
      int temp = 0;
      while (sub.length < maxCount) {
        try {
          sub.add(toCheck[temp]);
          toCheck.removeAt(temp);
        } catch (e) {
          break;
        }
      }
      result.add(sub);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, constraint) {
      //This is to control the max child count based on the type the user has chosen
      if (children.length > 0) {
        int maxChildCount = this.type!.count;
        if (maxChildCount > 1) {
          if (constraint.maxWidth < 650) {
            maxChildCount = 1;
          } else {
            if (constraint.maxWidth < 900) {
              maxChildCount = (maxChildCount / 1.7).floor();
            } else {
              if (constraint.maxWidth < 1200) {
                maxChildCount = (maxChildCount / 2).floor();
              } else {
                if (constraint.maxWidth < 1600) {
                  maxChildCount = (maxChildCount / 1.3).floor();
                }
              }
            }
          }
        } else {
          maxChildCount = 1;
        }

        List<List<AdaptiveItem>> content =
            getContent(maxChildCount, List<AdaptiveItem>.from(children));
        return Container(
          width: _size.width,
          child: Scrollbar(
            child: SingleChildScrollView(
                physics: physics,
                child: Column(
                  children: [
                    for (var colList in content) ...{
                      Container(
                        width: constraint.maxWidth,
                        child: Row(
                          crossAxisAlignment: crossAxisAlignment,
                          mainAxisAlignment: mainAxisAlignment,
                          children: [
                            for (var child in colList) ...{
                              if (constraint.maxWidth < 800) ...{
                                Expanded(
                                  child: child.asWidget,
                                )
                              } else ...{
                                if (child.width != null) ...{
                                  child.asWidget
                                } else ...{
                                  Expanded(
                                    child: child.asWidget,
                                  )
                                }
                              }
                            }
                          ],
                        ),
                      )
                    }
                  ],
                )),
          ),
        );
      }
      return Container(
        width: _size.width,
        child: Center(
          child: Text(
            "INVALID CHILDREN LENGTH",
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      );
    });
  }
}
