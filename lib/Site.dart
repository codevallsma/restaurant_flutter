import 'dart:ffi';

import 'package:flutter/material.dart';

class Site extends StatelessWidget{
  final String ocupacio;
  final String emplacament;
  final int taules;
  final int cadires;
  final double superficie;
  final String nomRestaurant;

  static final String public = 'Terrasses en Via Pública';

  Site(this.ocupacio, this.emplacament, this.taules, this.cadires, this.superficie, this.nomRestaurant);

  @override
  Widget build(BuildContext context) {
    return Card(

      // Con esta propiedad modificamos la forma de nuestro card
      // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

      // Con esta propiedad agregamos margen a nuestro Card
      // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
      margin: EdgeInsets.all(15),

      // Con esta propiedad agregamos elevación a nuestro card
      // La sombra que tiene el Card aumentará
      elevation: 10,

      // La propiedad child anida un widget en su interior
      // Usamos columna para ordenar un ListTile y una fila con botones
      child: Column(
        children: <Widget>[

          // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
          ListTile(
            contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
            title: Text('${this.nomRestaurant}'),
            subtitle: Text('${this.emplacament}'),
            leading: printLeading()
          ),

          // Usamos una fila para ordenar los botones del card
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Image.asset('assets/images/surface-24.png'),
              Text('   ${this.superficie} km2      '),
              Image.asset('assets/images/table-24.png'),
              Text('   x ${this.taules}      '),
              Image.asset('assets/images/chair-24.png'),
              Text('   x ${this.cadires}   '),
            ],
          )
        ],
      ),
    );
  }

  Icon printLeading(){
    if(this.ocupacio == public){
      return Icon(Icons.public);
    }else{
      return Icon(Icons.public_off);
    }
  }

}