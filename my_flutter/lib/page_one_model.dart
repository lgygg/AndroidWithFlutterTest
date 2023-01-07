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
