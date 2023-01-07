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
