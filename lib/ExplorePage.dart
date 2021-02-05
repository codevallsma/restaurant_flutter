import 'dart:async';

import 'package:api_example/network/Restaurant.dart';
import 'package:api_example/network/api_service.dart';
import 'package:api_example/network/model/SingletonApiToken.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'network/model/SingletonUserDetails.dart';


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

  Future<List<Restaurant>> restaurantList;

  bool isPressed = false;
  Icon icona = new Icon(Icons.star_border);

  @override
  void initState() {
    super.initState();
    //_getMarkers();
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
    submit();

    Provider.of<ApiService>(context, listen: false)
        .getLikedRestaurants(
        SingletonUserDetails().id, SingletonApiToken().getTokenHeader())
        .then((sitesList) {
      for (int i = 0; i < sitesList.length; i++) {
        if (sitesList[i].id == restaurants[i].id) {
          isPressed = true;
          setState(() {
            icona = new Icon(Icons.star);
          });
          break;
        }
      }
    });
  }


  _getCurrentLocation() async {
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((value){
      _currentPosition = value;
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(_currentPosition.latitude, _currentPosition.longitude), zoom: 16.0),
        ),
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController=controller;
    _getCurrentLocation();
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
        zoom: 16.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
  void submit() async {
    _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation).then((value){
      _currentPosition = value;
      restaurants = [];
      this._markers.clear();
      Future<List<Restaurant>> restas = Provider.of<ApiService>(context, listen: false)
          .getKNearestRestaurants(_currentPosition.latitude, _currentPosition.longitude,4, SingletonApiToken().getTokenHeader());
      setState(() {
        restaurantList = restas;
      });
      return;
    });
  }
  _restaurantList(index) {
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
                          Expanded(child:
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                          Expanded(child:
                                Row(children: [
                                  Text(
                                    restaurants[index].restaurantName,
                                    style: TextStyle(
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(icon: icona, onPressed: () => _buttonPressed(index)),
                                ],)),
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
                          )
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
              child:restaurantList ==null ? Container(
                              alignment: FractionalOffset.center,
                              child: CircularProgressIndicator())
                  : FutureBuilder<List<Restaurant>>(
                  future: restaurantList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return _buildResults(snapshot.data.toList());
                    } else {
                      return Container(
                          alignment: FractionalOffset.center,
                          child: CircularProgressIndicator());
                    }
                  }),

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
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buttonPressed(int index) {
    isPressed = !isPressed;
    if (isPressed) {
      setState(() {
        icona = new Icon(Icons.star);
      });
      Provider.of<ApiService>(context, listen: false).postLikedRestaurant(
          SingletonUserDetails().id,
          this.restaurants[index].id,
          SingletonApiToken().getTokenHeader());
    } else {
      setState(() {
        icona = new Icon(Icons.star_border);
      });
      Provider.of<ApiService>(context, listen: false).deleteLikedRestaurant(
          SingletonUserDetails().id,
          this.restaurants[index].id,
          SingletonApiToken().getTokenHeader());
    }
  }

  PageView _buildResults(List<Restaurant> restaurantResults){
    restaurants = restaurantResults;

    Provider.of<ApiService>(context, listen: false)
        .getLikedRestaurants(
        SingletonUserDetails().id, SingletonApiToken().getTokenHeader())
        .then((sitesList) {
      for (int i = 0; i < sitesList.length; i++) {
        if (sitesList[i].id == restaurants[i].id) {
          isPressed = true;
          setState(() {
            icona = new Icon(Icons.star);
          });
          break;
        }
      }
    });

    restaurantResults.forEach((restaurant) {
      //adding the marker
      this._markers.add(Marker(
          markerId: MarkerId(restaurant.id.toString()),
          draggable: false,
          infoWindow:
          InfoWindow(title: restaurant.restaurantName, snippet: restaurant.emplacamament),
          position: restaurant.locationCords()));
    });
    return PageView.builder(
      controller: _pageController,
      itemCount: restaurants.length,
      itemBuilder: (BuildContext context, int index) {
        return _restaurantList(index);
      },
    );
  }
}