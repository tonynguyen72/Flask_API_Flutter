import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:sqlite_bloc/drink.dart';

import 'flask_network.dart';

class DrinkBloc {
  int _id;
  final _drinkController = BehaviorSubject<List<Drink>>();

  Stream<List<Drink>> get drinkStream =>
      Observable.fromFuture(Api().getDrinks());
  StreamSink<List<Drink>> get inDrink => _drinkController.sink;

  final _controller = BehaviorSubject<int>.seeded(1);
  Stream<Drink> get dStream => Observable.fromFuture(Api().getDrink(id: _id));
  StreamSink<int> get inD => _controller.sink;
  //* Listen for change and call listener handler
  DrinkBloc() {
   _controller.listen(_addIn(_id));
  }
   _addIn(int id) {
    _id = id;
  }

  void dispose() {
    _drinkController.close();
    _controller.close();
  }
}
