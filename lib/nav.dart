import 'package:api_example/ExplorePage.dart';
import 'package:api_example/LoginOrSignUp.dart';
import 'package:api_example/ProfilePage.dart';
import 'package:api_example/SavedPage.dart';
import 'package:api_example/SettingsPage.dart';
import 'package:api_example/ui/profile/prrofile_screen.dart';
import 'package:flutter/material.dart';
import 'package:api_example/rutes.dart';
import 'package:provider/provider.dart';
import 'package:api_example/Authentication/authentication_Service.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    ExplorePage(),
    ProfileScreen(),
    SavedPage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('ChefSafeNew'),
        leading: new IconButton(
            icon: new Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(createRouteWithSlide(SettingsPage()));
            }),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: new IconButton(
                icon: new Icon(Icons.logout),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, "/LoginOrSignUp", (r) => false);
                }),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on,
            ),
            title: Text(
              'Explore',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            title: Text(
              'Profile',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.inbox,
            ),
            title: Text(
              'Saved',
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),
    );
  }
}
