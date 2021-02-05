import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api_example/Site.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'network/api_service.dart';
import 'network/model/SingletonApiToken.dart';
import 'network/model/SingletonUserDetails.dart';

class Category extends StatelessWidget {
  final int id;
  final String categoria;
  final int numRestaurants;
  final items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13];

  Category(this.id, this.categoria, this.numRestaurants);

  @override
  Widget build(BuildContext buildContext) {
    return InkWell(
        onTap: () {
          if (this.numRestaurants != 0) {
            _showMyDialog(buildContext, this.id, this.categoria);
          }
        },
        child: Card(
          // Con esta propiedad modificamos la forma de nuestro card
          // Aqui utilizo RoundedRectangleBorder para proporcionarle esquinas circulares al Card
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),

          // Con esta propiedad agregamos margen a nuestro Card
          // El margen es la separación entre widgets o entre los bordes del widget padre e hijo
          margin: EdgeInsets.all(15),

          color: choseCardColor(),

          // Con esta propiedad agregamos elevación a nuestro card
          // La sombra que tiene el Card aumentará
          elevation: 10,

          // La propiedad child anida un widget en su interior
          // Usamos columna para ordenar un ListTile y una fila con botones
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Usamos ListTile para ordenar la información del card como titulo, subtitulo e icono
              ListTile(
                contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                title: new Center(child: new Text('${this.categoria}')),
                subtitle: new Center(
                    child: new Text('Num Restaurants: ${this.numRestaurants}')),
              ),
            ],
          ),
        ));
  }

  Future<void> _showMyDialog(
      BuildContext context, int categoryId, String categoria) {
    List<Site> _sites = [];

    Provider.of<ApiService>(context, listen: false)
        .getLikedRestaurantsByCategory(SingletonUserDetails().id, categoryId,
            SingletonApiToken().getTokenHeader())
        .then((sitesList) {
      for (int i = 0; i < sitesList.length; i++) {
        _sites.add(new Site(
            sitesList[i].ocupacio,
            sitesList[i].emplacamament,
            sitesList[i].taules,
            sitesList[i].cadires,
            sitesList[i].superficieOcupada,
            sitesList[i].restaurantName));
      }

      return showDialog<void>(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return new MyAlertDialog(
              title: new Text('Restaurants ${categoria}'),
              content: new ListView.builder(
                itemCount: _sites.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  return Site(
                      _sites[index].ocupacio,
                      _sites[index].emplacament,
                      _sites[index].taules,
                      _sites[index].cadires,
                      _sites[index].superficie,
                      _sites[index].nomRestaurant);
                },
                shrinkWrap: true,
              ),
            );
          });
    });
  }

  Color choseCardColor() {
    if (this.numRestaurants == 0) {
      return Colors.grey;
    } else {
      return Colors.white;
    }
  }
}

class MyAlertDialog extends StatelessWidget {
  /// Creates an alert dialog.
  ///
  /// Typically used in conjunction with [showDialog].
  ///
  /// The [contentPadding] must not be null. The [titlePadding] defaults to
  /// null, which implies a default that depends on the values of the other
  /// properties. See the documentation of [titlePadding] for details.
  const MyAlertDialog({
    Key key,
    this.title,
    this.titlePadding,
    this.content,
    this.contentPadding = const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 15.0),
    this.actions,
    this.semanticLabel,
  })  : assert(contentPadding != null),
        super(key: key);

  /// The (optional) title of the dialog is displayed in a large font at the top
  /// of the dialog.
  ///
  /// Typically a [Text] widget.
  final Widget title;

  /// Padding around the title.
  ///
  /// If there is no title, no padding will be provided. Otherwise, this padding
  /// is used.
  ///
  /// This property defaults to providing 24 pixels on the top, left, and right
  /// of the title. If the [content] is not null, then no bottom padding is
  /// provided (but see [contentPadding]). If it _is_ null, then an extra 20
  /// pixels of bottom padding is added to separate the [title] from the
  /// [actions].
  final EdgeInsetsGeometry titlePadding;

  /// The (optional) content of the dialog is displayed in the center of the
  /// dialog in a lighter font.
  ///
  /// Typically, this is a [ListView] containing the contents of the dialog.
  /// Using a [ListView] ensures that the contents can scroll if they are too
  /// big to fit on the display.
  final Widget content;

  /// Padding around the content.
  ///
  /// If there is no content, no padding will be provided. Otherwise, padding of
  /// 20 pixels is provided above the content to separate the content from the
  /// title, and padding of 24 pixels is provided on the left, right, and bottom
  /// to separate the content from the other edges of the dialog.
  final EdgeInsetsGeometry contentPadding;

  /// The (optional) set of actions that are displayed at the bottom of the
  /// dialog.
  ///
  /// Typically this is a list of [FlatButton] widgets.
  ///
  /// These widgets will be wrapped in a [ButtonBar], which introduces 8 pixels
  /// of padding on each side.
  ///
  /// If the [title] is not null but the [content] _is_ null, then an extra 20
  /// pixels of padding is added above the [ButtonBar] to separate the [title]
  /// from the [actions].
  final List<Widget> actions;

  /// The semantic label of the dialog used by accessibility frameworks to
  /// announce screen transitions when the dialog is opened and closed.
  ///
  /// If this label is not provided, a semantic label will be infered from the
  /// [title] if it is not null.  If there is no title, the label will be taken
  /// from [MaterialLocalizations.alertDialogLabel].
  ///
  /// See also:
  ///
  ///  * [SemanticsConfiguration.isRouteName], for a description of how this
  ///    value is used.
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    String label = semanticLabel;

    if (title != null) {
      children.add(new Padding(
        padding: titlePadding ??
            new EdgeInsets.fromLTRB(
                24.0, 24.0, 24.0, content == null ? 20.0 : 0.0),
        child: new DefaultTextStyle(
          style: Theme.of(context).textTheme.title,
          child: new Semantics(child: title, namesRoute: true),
        ),
      ));
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          label = semanticLabel;
          break;
        case TargetPlatform.android:
        case TargetPlatform.fuchsia:
          label = semanticLabel ??
              MaterialLocalizations.of(context)?.alertDialogLabel;
      }
    }

    if (content != null) {
      children.add(new Flexible(
        child: new Padding(
          padding: contentPadding,
          child: new DefaultTextStyle(
            style: Theme.of(context).textTheme.subhead,
            child: content,
          ),
        ),
      ));
    }

    if (actions != null) {
      children.add(new ButtonTheme.bar(
        child: new ButtonBar(
          children: actions,
        ),
      ));
    }

    Widget dialogChild = new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );

    if (label != null)
      dialogChild =
          new Semantics(namesRoute: true, label: label, child: dialogChild);

    return new Dialog(child: dialogChild);
  }
}
