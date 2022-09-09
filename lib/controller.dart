import 'package:mobx/mobx.dart';

class Controller {
  final heartsList = Observable(['❤', '❤', '❤']);

  void add() {
    runInAction(() {
      heartsList.value = [...heartsList.value, '❤'];
    });
  }

  void remove() {
    runInAction(() {
      heartsList.value = List.of(heartsList.value)..removeLast();
    });
  }
}
