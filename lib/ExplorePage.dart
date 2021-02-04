import 'dart:async';

import 'package:api_example/network/api_service.dart';
import 'package:api_example/network/model/SingletonApiToken.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(41.412372, 2.161697)));
    _getCurrentLocation();
  }

  void getMarkers(){
    Provider.of<ApiService>(context, listen: false)
        .getKNearestRestaurants(_currentPosition.latitude, _currentPosition.longitude,4, SingletonApiToken().getTokenHeader())
        .then((value){

        });
  }
  _onMarkersRecieved(){

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
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: _drawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: _markers,
            mapType: _defaultMapType,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
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
                FloatingActionButton(
                    child: Icon(Icons.location_on),
                    elevation: 5,
                    backgroundColor: Colors.teal[200],
                    onPressed: () {
                      _getCurrentLocation();
                      print('Zooming to location');
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

  Widget _drawer(){
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("xyz"),
            accountEmail: Text("xyz@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("xyz"),
            ),
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("abc"),
              )
            ],
          ),
        ],
      ),
    );
  }
}