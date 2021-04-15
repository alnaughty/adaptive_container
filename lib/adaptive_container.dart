library adaptive_container;
import 'package:adaptive_container/adaptive_item.dart';
export 'package:adaptive_container/adaptive_item.dart';
import 'package:flutter/material.dart';


class AdaptiveContainer extends StatelessWidget {
  final List<AdaptiveItem> children;
  AdaptiveContainer({@required this.children});

  List getContent(maxCount, List<AdaptiveItem> toCheck) {
    List result = [];
    while (result.length < children.length/maxCount.floor()) {
      List sub = [];
      int temp = 0;
      while(sub.length < maxCount) {
        try{
          sub.add(toCheck[temp].asWidget);
          toCheck.removeAt(temp);
        }catch(e){
          break;
        }
      }
      result.add(sub);
    }
    print(result);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraint) {
          if(children.length > 0){
            int maxChildCount = 2;
            if(constraint.maxWidth < 800) {
              maxChildCount = 1;
            }
            List content = getContent(maxChildCount, List<AdaptiveItem>.from(children));
            print(maxChildCount);
            return Container(
              width: double.infinity,
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for(var colList in content)...{
                        Container(
                          width: constraint.maxWidth,
                          child: Row(
                            children: [
                              for(var child in colList)...{
                                Expanded(
                                  child: Container(
                                    child: child,
                                  ),
                                )
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
          return Center(
            child: Text("INVALID CHILDREN LENGTH", style: Theme.of(context).textTheme.headline4,),
          );

        }
    );
  }
}



