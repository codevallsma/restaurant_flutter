import 'package:api_example/network/model/SingletonUserDetails.dart';
import 'package:flutter/material.dart';
import 'package:api_example/size_config.dart';

import 'info.dart';
import 'profile_menu_item.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Info(
            image: "assets/images/avatar_circle_blue_512dp.png",
            name: SingletonUserDetails().username,
            email: SingletonUserDetails().username,
          ),
          SizedBox(height: SizeConfig.defaultSize * 2), //20
          ProfileMenuItem(
            iconSrc: "assets/icons/bookmark_fill.svg",
            title: "Saved Restaurants",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/chef_color.svg",
            title: "Super Plan",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/language.svg",
            title: "Change Language",
            press: () {},
          ),
          ProfileMenuItem(
            iconSrc: "assets/icons/info.svg",
            title: "Help",
            press: () {},
          ),
        ],
      ),
    );
  }
}
