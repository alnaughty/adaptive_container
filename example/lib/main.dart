import 'package:flutter/material.dart';
import 'package:adaptive_container/adaptive_container.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: AdaptiveContainer(
              type: AdapType.ADA_3,
              children: [
                AdaptiveItem(
                    height: 200,
                    bgColor: Colors.blue,
                    content: Center(
                      child: Text("TEST R 1",style: Theme.of(context).textTheme.headline4,),
                    )
                ),
                AdaptiveItem(
                    height: 200,
                    bgColor: Colors.red,
                    content: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("TEST R 2",style: Theme.of(context).textTheme.headline4,),
                      ),
                    )
                ),
                AdaptiveItem(
                    height: 200,
                    bgColor: Colors.yellow,
                    content: Center(
                      child: Text("TEST R 3",style: Theme.of(context).textTheme.headline4,),
                    )
                ),
                AdaptiveItem(
                    bgColor: Colors.green,
                    content: Center(
                      child: Text("TEST COL 3 R1",style: Theme.of(context).textTheme.headline4,),
                    )
                ),
              ],
            )
        )
    );
  }
}
