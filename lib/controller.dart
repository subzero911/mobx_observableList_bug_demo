import 'package:mobx/mobx.dart';

class Controller {
  final heartsList = ObservableList.of(['❤', '❤', '❤']);

  void add() {
    runInAction(() {
      heartsList.add('❤');
    });
  }

  void remove() {
    runInAction(() {
      heartsList.removeLast();
    });
  }
}
