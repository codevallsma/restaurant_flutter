import 'package:api_example/Category.dart';
import 'package:api_example/Site.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SavedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SavedPage();
  }
}

class _SavedPage extends State<SavedPage> {
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Restaurants'),
    1: Text('Categories'),
  };
  int sharedValue = 0;
  List<Site> _sites = [];
  List<Category> _categories = [];

  void initState() {
    super.initState();
    _sites = readSites(context);
    _categories = readCategories(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          CupertinoSegmentedControl<int>(
            children: logoWidgets,
            onValueChanged: (int val){
              setState(() {
                sharedValue = val;
              });
            },
            groupValue: sharedValue
          ),
          listTye(),
        ]);
  }

  List<Category> readCategories(BuildContext context){
    List<Category> aux = [];
    aux.add(new Category(1, 'Mexicano'));
    aux.add(new Category(2, 'Filipino'));
    aux.add(new Category(3, 'Japonés'));
  }

  List<Site> readSites(BuildContext context) {
    List<Site> aux = [];
    aux.add(new Site('Terrasses en Via Pública','Carrer de Sant Joan de la Salle, 42, 08022 Barcelona',2,4,5.2,'El xili'));
    aux.add(new Site('Terrasses en Espai Privat d\'Ús Públic','Passeig de Sant Gervasi, 47, 08022 Barcelona',4,8,11.4,'El Chikilicuatre'));
    return aux;
  }

  Expanded listTye(){
    if(sharedValue == 0){
      Expanded(child:  ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: _sites.length,
          itemBuilder: (BuildContext context, int index){
            return Site(_sites[index].ocupacio, _sites[index].emplacament, _sites[index].taules, _sites[index].cadires, _sites[index].superficie, _sites[index].nomRestaurant);
          }
      ));
    }else{
      Expanded(child:  GridView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: _categories.length,
          itemBuilder: (BuildContext context, int index){
            return Category(_categories[index].id, _categories[index].categoria);
          }, gridDelegate: null,
      ));
    }
  }
}