import 'package:flutter/material.dart';
import 'package:sqlite_bloc/drink_bloc.dart';
import 'drink.dart';
import 'flask_network.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: DrinkBloc(),
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: DrinkListView(),
      ),
    );
  }
}

class DrinkListView extends StatefulWidget {
  const DrinkListView({
    Key key,
  }) : super(key: key);

  @override
  _DrinkListViewState createState() => _DrinkListViewState();
}

class _DrinkListViewState extends State<DrinkListView> {
  final api = Api();
  int _id;
  Drink _dr;
  TextEditingController _idController = TextEditingController();

  Future<Drink> loadDrink(int id) async {
    var dr = await api.getDrinkById(id);
    _id = id;
    _dr = dr;
    return _dr;
  }

  @override
  void initState() {
    loadDrink(3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<DrinkBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Coffee Shop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 300,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<List<Drink>>(
              stream: bloc.drinkStream,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  // loadDrinks();
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      Drink drink = snapshot.data[index];
                      return _buildDrinkList(drink);
                    },
                  );
                }
              },
            ),
          ),
          //*
          SizedBox(
            height: 10,
          ),
          Container(
            height: 300,
            child: FutureBuilder<Drink>(
              future: loadDrink(_id),
              builder: (BuildContext context, AsyncSnapshot<Drink> snapshot) {
                _id = snapshot.data.id;
                print(snapshot.data);
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        child: TextField(
                          controller: _idController,
                          keyboardType: TextInputType.number,
                          decoration:
                              InputDecoration(hintText: 'Enter a number'),
                        ),
                      ),
                      FlatButton(
                        onPressed: () async {
                          _id = int.parse(_idController.text);

                          await loadDrink(_id);
                          setState(() {});
                        },
                        child: Text('Generate ID'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            snapshot.data.id.toString(),
                            style: TextStyle(fontSize: 25),
                          ),
                          Text(
                            snapshot.data.name,
                            style: TextStyle(fontSize: 25),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                // return Text(snapshot.data.name);
              },
            ),
          ),
        ],
      ),
    );
  }

  _buildDrinkList(Drink drink) {
    return Container(
      margin: EdgeInsets.all(8),
      height: 200,
      width: 400,
      decoration: BoxDecoration(
          color: drink.id.isOdd
              ? Colors.teal.withOpacity(0.1)
              : Colors.orange.withOpacity(0.3),
          borderRadius: BorderRadius.only(
            bottomLeft:
                drink.id.isOdd ? Radius.circular(22) : Radius.circular(8),
            topLeft: drink.id.isOdd ? Radius.circular(8) : Radius.circular(22),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 7, spreadRadius: 7),
          ]),
      child: Stack(
        children: <Widget>[
          Container(
            width: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.grey.withOpacity(0.5), BlendMode.colorBurn),
                    alignment: Alignment.center,
                    image: NetworkImage(drink.image),
                    fit: BoxFit.fill)),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 12),
              child: Text('\$${drink.price.toString()}',
                  style: TextStyle(color: Colors.black, fontSize: 24)),
            ),
          ),
          Positioned(
            right: 40,
            top: 80,
            child: Container(
              margin: EdgeInsets.only(left: 30),
              child: Center(
                child: Text(drink.name,
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 22,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, right: 32, bottom: 15),
              child: Text('qty : ${drink.qty.toString()}',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 22)),
            ),
          ),
        ],
      ),
    );
  }
}
