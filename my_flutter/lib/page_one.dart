import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_flutter/page_one_model.dart';

class PageOne extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return PageOneState();
  }
}

class PageOneState extends State<PageOne> {
  final pageOneMode = PageOneMode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Observer(
              builder: (BuildContext context) {
                return Text(
                  '${pageOneMode.value}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Observer(
              builder: (BuildContext context) {
                return Text(
                  '${pageOneMode.value2}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          pageOneMode.sleep5Increment();
          pageOneMode.setValue2(5);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
