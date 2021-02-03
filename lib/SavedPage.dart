import 'package:api_example/Site.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SavedPage();
  }
}

class _SavedPage extends State<SavedPage> {
  List<Site> _sites = [];

  void initState() {
    super.initState();
    _sites = readSites(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Expanded(child:  ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _sites.length,
              itemBuilder: (BuildContext context, int index){
                return Site(_sites[index].ocupacio, _sites[index].emplacament, _sites[index].taules, _sites[index].cadires, _sites[index].superficie, _sites[index].nomRestaurant);
              }
          )),
        ]);
  }

  List<Site> readSites(BuildContext context) {
    List<Site> aux = [];
    aux.add(new Site('Terrasses en Via Pública','Carrer de Sant Joan de la Salle, 42, 08022 Barcelona',2,4,5.2,'El xili'));
    aux.add(new Site('Terrasses en Espai Privat d\'Ús Públic','Passeig de Sant Gervasi, 47, 08022 Barcelona',4,8,11.4,'El Chikilicuatre'));
    return aux;
  }
}