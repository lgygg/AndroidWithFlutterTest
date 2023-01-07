import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Counter = _Counter with _$Counter;
// 导入了 mobx.dart，这样就可以访问 Store 以及其他功能
// 使用了part 语法组合此类的自动生成的部分。我们暂时还没使用到生成器
// 暴露 Counter 类，该类将与生成的与 MobX 绑定的 _$Counter 类一起使用
// 使用 Store 类创建一个 _Counter ，并定一个 @observable 属性和 @actions 以确定 Store 可以与之交互的区域
// counter.g.dart文件没生成的时候使用命令：flutter packages pub run build_runner build
// counter.g.dart文件生成后使用命令更新：flutter packages pub run build_runner watch
abstract class _Counter with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }

  @action
  void decrement() {
    value--;
  }

  @action
  void set(int value) {
    this.value = value;
  }
}


