library adaptive_container;
import 'package:adaptive_container/adaptive_item.dart';
export 'package:adaptive_container/adaptive_item.dart';
import 'package:flutter/material.dart';


class AdaptiveContainer extends StatelessWidget {
  final List<AdaptiveItem> children;
  final ScrollPhysics physics;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  AdaptiveContainer({required this.children, this.physics = const ClampingScrollPhysics(), this.crossAxisAlignment = CrossAxisAlignment.start, this.mainAxisAlignment = MainAxisAlignment.start});

  List<List<AdaptiveItem>> getContent(maxCount, List<AdaptiveItem> toCheck) {
    List<List<AdaptiveItem>> result = [];
    while (result.length < children.length/maxCount.floor()) {
      List<AdaptiveItem> sub = [];
      int temp = 0;
      while(sub.length < maxCount) {
        try{
          sub.add(toCheck[temp]);
          toCheck.removeAt(temp);
        }catch(e){
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
    return LayoutBuilder(
        builder: (context, constraint) {
          if(children.length > 0){
            int maxChildCount = 2;
            if(constraint.maxWidth < 800) {
              maxChildCount = 1;
            }
            List<List<AdaptiveItem>> content = getContent(maxChildCount, List<AdaptiveItem>.from(children));
            return Container(
              width: _size.width,
              child: Scrollbar(
                child: SingleChildScrollView(
                    physics: physics,
                    child: Column(
                      children: [
                        for(var colList in content)...{
                          Container(
                            width: constraint.maxWidth,
                            child: Row(
                              crossAxisAlignment: crossAxisAlignment,
                              mainAxisAlignment: mainAxisAlignment,
                              children: [
                                for(var child in colList)...{
                                  if(constraint.maxWidth < 800)...{
                                    Expanded(
                                      child: child.asWidget,
                                    )
                                  } else
                                    ...{
                                      if(child.width != null)...{
                                        child.asWidget
                                      } else
                                        ...{
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
                    )
                ),
              ),
            );
          }
          return Container(
            width: _size.width,
            child: Center(
              child: Text("INVALID CHILDREN LENGTH", style: Theme.of(context).textTheme.headline4,),
            ),
          );

        }
    );
  }
}



