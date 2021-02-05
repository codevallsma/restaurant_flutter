import 'package:api_example/Category.dart';
import 'package:api_example/Site.dart';
import 'package:api_example/network/api_service.dart';
import 'package:api_example/network/model/SingletonApiToken.dart';
import 'package:api_example/network/model/SingletonUserDetails.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SavedPage();
  }
}

class _SavedPage extends State<SavedPage> {
  var _searchview = new TextEditingController();
  final SearchBarController<Category> _searchBarController =
      SearchBarController();
  bool isPortrait;
  int sharedValue = 0;
  List<Site> _sites = [];
  List<Site> _filteredSites = [];
  List<Category> _categories = [];
  List<Category> _filteredCategories = [];
  String _query;
  bool _firstSearch = true;

  void initState() {
    super.initState();
    readSites(context);
    readCategories(context);

    _searchview.addListener(() {
      if (_searchview.text.isEmpty) {
        //Notify the framework that the internal state of this object has changed.
        setState(() {
          _firstSearch = true;
          _query = "";
        });
      } else {
        setState(() {
          _firstSearch = false;
          _query = _searchview.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Column(children: <Widget>[
      SizedBox(height: 10),
      CupertinoSegmentedControl<int>(
          children: {
            0: Container(
              color: sharedValue == 0
                  ? Color.fromRGBO(55, 131, 148, 1)
                  : Colors.white,
              padding: EdgeInsets.all(8),
              child: Text('Restaurants'),
            ),
            1: Container(
              color: sharedValue == 1
                  ? Color.fromRGBO(55, 131, 148, 1)
                  : Colors.white,
              padding: EdgeInsets.all(8),
              child: Text('Categories'),
            )
          },
          onValueChanged: (int val) {
            setState(() {
              sharedValue = val;
            });
          },
          groupValue: sharedValue),
      SizedBox(height: 10),
      _createSearchView(),
      SizedBox(height: 10),
      _firstSearch ? _createListView() : _performSearch()
      //listTye(),
    ]);
  }

  //Create a SearchView
  Widget _createSearchView() {
    return new Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchview,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  //Create a ListView widget
  Widget _createListView() {
    if (sharedValue == 1) {
      return new Flexible(
        child: new GridView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: _categories.length,
          itemBuilder: (BuildContext context, int index) {
            return Category(_categories[index].id, _categories[index].categoria,
                _categories[index].numRestaurants);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
        ),
      );
    } else {
      return new Flexible(
        child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: _sites.length,
            itemBuilder: (BuildContext context, int index) {
              return Site(
                  _sites[index].ocupacio,
                  _sites[index].emplacament,
                  _sites[index].taules,
                  _sites[index].cadires,
                  _sites[index].superficie,
                  _sites[index].nomRestaurant);
            }),
      );
    }
  }

  //Perform actual search
  Widget _performSearch() {
    _filteredCategories = [];
    _filteredSites = [];

    if (sharedValue == 1) {
      for (int i = 0; i < _categories.length; i++) {
        if (_categories[i]
            .categoria
            .toLowerCase()
            .contains(_query.toLowerCase())) {
          _filteredCategories.add(_categories[i]);
        }
      }
      return _createFilteredListView();
    } else {
      for (int i = 0; i < _sites.length; i++) {
        if (_sites[i]
            .nomRestaurant
            .toLowerCase()
            .contains(_query.toLowerCase())) {
          _filteredSites.add(_sites[i]);
        }
      }
      return _createFilteredListView();
    }
  }

  //Create the Filtered ListView
  Widget _createFilteredListView() {
    if (sharedValue == 1) {
      return new Flexible(
        child: new GridView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: _filteredCategories.length,
          itemBuilder: (BuildContext context, int index) {
            return Category(
                _filteredCategories[index].id,
                _filteredCategories[index].categoria,
                _filteredCategories[index].numRestaurants);
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
        ),
      );
    } else {
      return new Flexible(
        child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: _filteredSites.length,
            itemBuilder: (BuildContext context, int index) {
              return Site(
                  _filteredSites[index].ocupacio,
                  _filteredSites[index].emplacament,
                  _filteredSites[index].taules,
                  _filteredSites[index].cadires,
                  _filteredSites[index].superficie,
                  _filteredSites[index].nomRestaurant);
            }),
      );
    }
  }

  void readCategories(BuildContext context) {
    Category aux;

    _categories.removeRange(0, _categories.length);
    Provider.of<ApiService>(context, listen: false)
        .getAllCategories(SingletonApiToken().getTokenHeader())
        .then((categoriesList) {
      for (int i = 0; i < categoriesList.length; i++) {
        Provider.of<ApiService>(context, listen: false)
            .getLikedRestaurantsByCategory(SingletonUserDetails().id,
                categoriesList[i].id, SingletonApiToken().getTokenHeader())
            .then((restaurantListPerCategory) {
          _categories.add(new Category(categoriesList[i].id,
              categoriesList[i].categoria, restaurantListPerCategory.length));
          if (_categories.length == categoriesList.length) {
            for (int i = 0; i < _categories.length; ++i) {
              for (int j = i + 1; j < _categories.length; ++j) {
                if (_categories[i].numRestaurants <
                    _categories[j].numRestaurants) {
                  aux = _categories[i];
                  _categories[i] = _categories[j];
                  _categories[j] = aux;
                }
              }
            }
          }
        });
      }
    });
  }

  void readSites(BuildContext context) {
    _sites.removeRange(0, _sites.length);
    Provider.of<ApiService>(context, listen: false)
        .getLikedRestaurants(
            SingletonUserDetails().id, SingletonApiToken().getTokenHeader())
        .then((sitesList) {
      setState(() {
        for (int i = 0; i < sitesList.length; i++) {
          _sites.add(new Site(
              sitesList[i].ocupacio,
              sitesList[i].emplacamament,
              sitesList[i].taules,
              sitesList[i].cadires,
              sitesList[i].superficieOcupada,
              sitesList[i].restaurantName));
        }
      });
    });
  }

  Expanded listTye() {
    if (sharedValue == 0) {
      return Expanded(
          child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: _sites.length,
              itemBuilder: (BuildContext context, int index) {
                return Site(
                    _sites[index].ocupacio,
                    _sites[index].emplacament,
                    _sites[index].taules,
                    _sites[index].cadires,
                    _sites[index].superficie,
                    _sites[index].nomRestaurant);
              }));
    } else {
      return Expanded(
          child: GridView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: _categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Category(_categories[index].id, _categories[index].categoria,
              _categories[index].numRestaurants);
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
      ));
    }
  }

  Future<List<Category>> getCategoriesWithName(String text) {
    return Future.delayed(Duration(seconds: 0), () {
      List<Category> aux = [];
      for (int i = 0; i < _categories.length; i++) {
        if (_categories[i]
                .categoria
                .toLowerCase()
                .indexOf(text.toLowerCase()) !=
            -1) {
          aux.add(_categories[i]);
        }
      }
      return aux;
    });
  }
}
