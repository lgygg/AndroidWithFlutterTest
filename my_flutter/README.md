# my_flutter

# flutter使用mobx

## 引入依赖包
flutter_mobx是最主要的包。

mobx_codegen和build_runner包主要用于生成xxx.g.dart文件，xxx对应文件的名称。而这个文件就是实现mvvm模式的关键，必须要有，当然，你也可以自己手写实现xxx.g.dart文件里的内容。

```
mobx_codegen: ^2.1.1
build_runner: ^2.3.3
flutter_mobx: ^2.0.6+5
```

具体如下：

```
dependencies:
  flutter:
    sdk: flutter

  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2
  flutter_mobx: ^2.0.6+5

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
  mobx_codegen: ^2.1.1
  build_runner: ^2.3.3
  flutter_mobx: ^2.0.6+5
```

## 关于build_runner包

官方解释他的作用是：[build_runner](https://pub.flutter-io.cn/packages/build_runner) 这个 Package 提供了一些用于生成文件的通用命令，这些命令中有的可以用于测试生成的文件，有的可以用于对外提供这些生成的文件以及它们的源代码。

简单理解就是自动生成我们需要的代码文件。

build_runner 中包含下述几个命令：

`build` 命令：
处理一次性构建。

`serve` 命令：运行一个用于开发的服务器。你可以使用 [`webdev serve`](https://dart.cn/tools/webdev#serve) 替代该命令，它会包含一些方便的默认功能。

`test` 命令
用于运行 [测试](https://dart.cn/guides/testing)。

`watch` 命令
启动一个构建服务器用于监听输入文件的编辑。通过处理增量重建来响应代码的修改。

## 创建ViewModel文件

一般的步骤是：

- 创建ViewModel文件。这里我定义文件名为page_one_model.dart

- 导入依赖 package:mobx/mobx.dart，这样就可以访问 Store 以及其他功能

  ```
  import 'package:mobx/mobx.dart';
  ```

- 使用了part 语法，标注指定文件为当前ViewModel文件的一部分。

  ```
  part 'page_one_model.g.dart';
  ```

  目前并不存在page_one_model.g.dart这个文件，part语法的作用是是将page_one_model.g.dart文件里的内容作为page_one_model.dart的一部分。

- 暴露PageOneMode类，该类将与生成的与 MobX 绑定的 PageOneMode 类一起使用

  ```
  class PageOneMode = PageOneModeBase with _$PageOneMode;
  ```

  _$PageOneMode是page_one_model.dart里的类。

  

- 使用 Store 类创建一个 抽象类PageOneModeBase ，并使用 @observable 属性和 @actions 以确定 Store 可以与之交互的区域

- 使用命令生产xxx.g.dart文件

  ```
  // page_one_model.g.dart文件没生成的时候使用命令：flutter packages pub run build_runner build
  // page_one_model.g.dart文件生成后使用,可实现增量重建来响应代码的修改：flutter packages pub run build_runner watch
  ```

page_one_model.dart文件具体内容如下：

```
import 'package:mobx/mobx.dart';

part 'page_one_model.g.dart';

class PageOneMode = PageOneModeBase with _$PageOneMode;

abstract class PageOneModeBase with Store {
  @observable
  int value = 0;
  @observable
  int value2 = 2;
  @action
  void increment() {
    value++;
  }

  @action
  void setValue(int value) {
    this.value = value;
  }

  void sleep5Increment() {
    Future.delayed(const Duration(seconds: 5), () => setValue(value+5));
  }

  @action
  void setValue2(int value) {
    this.value2 = value;
  }
}

```

page_one_model.g.dart文件具体内容如下：

```
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_one_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PageOneMode on PageOneModeBase, Store {
  late final _$valueAtom =
      Atom(name: 'PageOneModeBase.value', context: context);

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$value2Atom =
      Atom(name: 'PageOneModeBase.value2', context: context);

  @override
  int get value2 {
    _$value2Atom.reportRead();
    return super.value2;
  }

  @override
  set value2(int value) {
    _$value2Atom.reportWrite(value, super.value2, () {
      super.value2 = value;
    });
  }

  late final _$PageOneModeBaseActionController =
      ActionController(name: 'PageOneModeBase', context: context);

  @override
  void increment() {
    final _$actionInfo = _$PageOneModeBaseActionController.startAction(
        name: 'PageOneModeBase.increment');
    try {
      return super.increment();
    } finally {
      _$PageOneModeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setValue(int value) {
    final _$actionInfo = _$PageOneModeBaseActionController.startAction(
        name: 'PageOneModeBase.setValue');
    try {
      return super.setValue(value);
    } finally {
      _$PageOneModeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setValue2(int value) {
    final _$actionInfo = _$PageOneModeBaseActionController.startAction(
        name: 'PageOneModeBase.setValue2');
    try {
      return super.setValue2(value);
    } finally {
      _$PageOneModeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
value2: ${value2}
    ''';
  }
}
```

## View调用ViewModel

下面介绍如何使用ViewModel，主要是通过观察者Observer来实现。

- 将需要改变的widget用Observer包裹

```
            Observer(
              builder: (BuildContext context) {
                return Text(
                  '${pageOneMode.value}',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
```

- 触发改变

  调用ViewModel里的方法触发状态改变。

```
FloatingActionButton(
        onPressed: (){
          pageOneMode.sleep5Increment();
          pageOneMode.setValue2(5);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      )
```

具体内容如下：

```
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:my_flutter/page_one_model.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

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
```
