import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sqlite_bloc/drink.dart';
import 'flask_network.dart';

class DrinkBloc {
  int id;
  final _drinkController = BehaviorSubject<List<Drink>>();

  Stream<List<Drink>> get drinkStream =>
      Observable.fromFuture(Api().getDrinks());
  StreamSink<List<Drink>> get inDrink => _drinkController.sink;

  final _dcontroller = BehaviorSubject<int>.seeded(1);
  Stream<Drink> get dStream => Observable.fromFuture(Api().getDrinkById(id));
  StreamSink<int> get inD => _dcontroller.sink;
  //* Listen for change and call listener handler
  DrinkBloc() {
    _dcontroller.listen(_addIn(id));
    inD.add(id);
  }
  _addIn(int id) {
    id = id;
  }

  void dispose() {
    _drinkController.close();
    _dcontroller.close();
  }
}
