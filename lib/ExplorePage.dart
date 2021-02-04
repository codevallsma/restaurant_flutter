import 'dart:async';

import 'package:api_example/network/Restaurant.dart';
import 'package:api_example/network/api_service.dart';
import 'package:api_example/network/model/SingletonApiToken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/services.dart';


class ExplorePage extends StatefulWidget {
  @override
  _ExplorePage createState() => _ExplorePage();
}

class _ExplorePage extends State<ExplorePage> {
  final Set<Marker> _markers = Set();
  final double _zoom = 10;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(41.390205, 2.154007), zoom: 10);
  MapType _defaultMapType = MapType.normal;
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  Position _currentPosition;
  PageController _pageController;
  int prevPage;
  List<Restaurant> restaurants = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }


  _getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((value){
        _currentPosition = value;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController=controller;
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }
  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }
  moveCamera() {
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: restaurants[_pageController.page.toInt()].locationCords(),
        zoom: 50.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
  _coffeeShopList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://media-cdn.tripadvisor.com/media/photo-s/05/9a/1e/25/image-restaurant.jpg"),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurants[index].restaurantName,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  restaurants[index].emplacamament,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  width: 170.0,
                                  child: Text(
                                    "numero de cadires:"+restaurants[index].cadires.toString(),
                                    style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.w300),
                                  ),
                                )
                              ])
                        ]))))
          ])),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 50.0,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              markers: _markers,
              mapType: _defaultMapType,
              myLocationEnabled: true,
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialPosition,
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder(
                    future: _getMarkers(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      _getCurrentLocation();

                      return PageView.builder(
                        controller: _pageController,
                        itemCount: restaurants.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _coffeeShopList(index);
                        },
                      );
                    },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    child: Icon(Icons.layers),
                    elevation: 5,
                    backgroundColor: Colors.teal[200],
                    onPressed: () {
                      _changeMapType();
                      print('Changing the Map Type');
                    }),
                /*FloatingSearchBar.builder(
                  itemCount: 100,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text(index.toString()),
                    );
                  },
                  trailing: CircleAvatar(
                    child: Text("RD"),
                  ),
                  /*drawer: Drawer(
                    child: Container(),
                  ),*/
                  onChanged: (String value) {},
                  onTap: () {},
                  decoration: InputDecoration.collapsed(
                    hintText: "Search...",
                  ),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  _getMarkers() async {
    setState(() {

    });
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((value){
      _currentPosition = value;
      restaurants = [];
      this._markers.clear();
      Provider.of<ApiService>(context, listen: false)
          .getKNearestRestaurants(_currentPosition.latitude, _currentPosition.longitude,4, SingletonApiToken().getTokenHeader())
          .then((restaurantsList){
        restaurantsList.forEach((restaurant) {
          //adding the marker
          this._markers.add(Marker(
              markerId: MarkerId(restaurant.id.toString()),
              draggable: false,
              infoWindow:
              InfoWindow(title: restaurant.restaurantName, snippet: restaurant.emplacamament),
              position: restaurant.locationCords()));
          // storing the nearby restaurants
          restaurants.add(restaurant);
        });
      }).catchError((onError){
        Fluttertoast.showToast(
            msg: "Error on receiving user data ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Theme.of(context).primaryColor,
            textColor: Colors.white,
            timeInSecForIosWeb: 1
        );
      });
    });
  }
}