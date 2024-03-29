import 'package:api_example/SignIn.dart';
import 'package:api_example/SignUp.dart';
import 'package:api_example/SplashScreen.dart';
import 'package:api_example/nav.dart';
import 'package:flutter/material.dart';

import 'package:api_example/LoginOrSignUp.dart';
import 'package:api_example/primaryColors.dart';
import 'package:api_example/ExplorePage.dart';
import 'package:api_example/Authentication/authentication_Service.dart';
import 'package:api_example/network/api_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:logging/logging.dart';

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) => {
    print("${rec.level.name}: ${rec.time} : ${rec.message}")
  });
}

Future<void> main() async {
  _setupLogging();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiService>(
        create: (context) => ApiService.create(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: generateMaterialColor(Color.fromRGBO(55, 131, 148, 1)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginOrSignUp(),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/SignIn': (context) => SignIn(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/SignUp': (context) => SignUp(),
          '/ExplorePage': (context) => ExplorePage(),
          '/Nav': (context) => Nav(),
          '/Splash': (context) => SplashScreen(),
          '/LoginOrSignUp': (context) => LoginOrSignUp(),
        },
      ),
    );
  }
}

