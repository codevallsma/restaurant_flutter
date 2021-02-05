import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'network/api_service.dart';
import 'network/model/SingletonApiToken.dart';
import 'network/model/SingletonUserDetails.dart';

class Site extends StatefulWidget {
  final int id;
  final String ocupacio;
  final String emplacament;
  final int taules;
  final int cadires;
  final double superficie;
  final String nomRestaurant;

  Site(this.id, this.ocupacio, this.emplacament, this.taules, this.cadires,
      this.superficie, this.nomRestaurant);

  _Site createState() => _Site(this.id, this.ocupacio, this.emplacament,
      this.taules, this.cadires, this.superficie, this.nomRestaurant);
}

class _Site extends State<Site> {
  final int id;
  final String ocupacio;
  final String emplacament;
  final int taules;
  final int cadires;
  final double superficie;
  final String nomRestaurant;

  bool isPressed = false;
  Icon icona = new Icon(Icons.star_border);

  static final String public = 'Terrasses en Via Pública';

  _Site(this.id, this.ocupacio, this.emplacament, this.taules, this.cadires,
      this.superficie, this.nomRestaurant);

  void initState() {
    super.initState();

    Provider.of<ApiService>(context, listen: false)
        .getLikedRestaurants(
            SingletonUserDetails().id, SingletonApiToken().getTokenHeader())
        .then((sitesList) {
      for (int i = 0; i < sitesList.length; i++) {
        if (sitesList[i].id == this.id) {
          isPressed = true;
          setState(() {
            icona = new Icon(Icons.star);
          });
          break;
        }
      }
    });
  }

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
            leading: printLeading(),
            trailing: IconButton(icon: icona, onPressed: _buttonPressed()),
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

  _buttonPressed() {
    isPressed = !isPressed;
    if (isPressed) {
      setState(() {
        icona = new Icon(Icons.star);
      });
      Provider.of<ApiService>(context, listen: false).postLikedRestaurant(
          SingletonUserDetails().id,
          this.id,
          SingletonApiToken().getTokenHeader());
    } else {
      setState(() {
        icona = new Icon(Icons.star_border);
      });
      icona = new Icon(Icons.star_border);
      Provider.of<ApiService>(context, listen: false).deleteLikedRestaurant(
          SingletonUserDetails().id,
          this.id,
          SingletonApiToken().getTokenHeader());
    }
  }

  Icon printLeading() {
    if (this.ocupacio == public) {
      return Icon(Icons.public);
    } else {
      return Icon(Icons.public_off);
    }
  }

/*
  IconButton printTrailing(BuildContext context) {
    Icon icona = new Icon(Icons.star);
    Provider.of<ApiService>(context, listen: false)
        .getLikedRestaurants(
            SingletonUserDetails().id, SingletonApiToken().getTokenHeader())
        .then((sitesList) {
      for (int i = 0; i < sitesList.length; i++) {
        if (sitesList[i].id == this.id) {
          icona = new Icon(Icons.star);
          return IconButton(
              icon: icona,
              onPressed: () {
                setState(() {
                  icona = new Icon(Icons.star_border);
                });
                Provider.of<ApiService>(context, listen: false)
                    .deleteLikedRestaurant(SingletonUserDetails().id, this.id,
                        SingletonApiToken().getTokenHeader())
                    .then((value) => null);
              });
        } else {
          icona = new Icon(Icons.star_border);
          return IconButton(
              icon: icona,
              onPressed: () {
                setState(() {
                  icona = new Icon(Icons.star);
                });
                Provider.of<ApiService>(context, listen: false)
                    .postLikedRestaurant(SingletonUserDetails().id, this.id,
                        SingletonApiToken().getTokenHeader())
                    .then((value) => null);
              });
        }
      }
    });
  }*/
}
