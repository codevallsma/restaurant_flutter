import 'package:api_example/network/model/SingletonUserDetails.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _backgroundColor = Colors.white;
  final _profileUrl ='https://ssl.gstatic.com/images/branding/product/2x/avatar_circle_blue_512dp.png';
  // 'https://pbs.twimg.com/profile_images/947228834121658368/z3AHPKHY_400x400.jpg';

  bool isFavourite = false;
  _togglFavourites() {
    setState(() {
      isFavourite = !isFavourite;
    });
  }

  get _userName => Text(
    SingletonUserDetails().username,
    style: TextStyle(
        color: Theme.of(context).primaryColor, fontSize: 24.0, fontWeight: FontWeight.bold),
  );

  get _userRole => Text(
    'User',
    style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 16.0,
        fontWeight: FontWeight.w500),
  );

  get _userDescription => Text(
    'Looking for restaurants!',
    style: TextStyle(
        color: Colors.cyan[700],
        fontSize: 20.0,
        fontWeight: FontWeight.w500),
  );

  get _userAvatar => Hero(
    tag: 'Ajith',
    child: CircleAvatar(
      maxRadius: 80.0,
      backgroundImage: NetworkImage(_profileUrl),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Container(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _userAvatar,
            SizedBox(height: 10.0),
            _userName,
            SizedBox(height: 5.0),
            _userRole,
            _userDescription,
          ],
        ),
      ),
    );
  }
}

_launchURL() async {
  const url = 'https://ajith.page';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
