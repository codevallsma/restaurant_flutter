import 'package:api_example/SignIn.dart';
import 'package:api_example/SignUp.dart';
import 'package:flutter/material.dart';

import 'package:api_example/LoginOrSignUp.dart';
import 'package:api_example/primaryColors.dart';
import 'package:api_example/HomePage.dart';
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
  await Firebase.initializeApp();
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
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<AuthenticationService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: generateMaterialColor(Color.fromRGBO(55, 131, 148, 1)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AuthenticationWrapper(),
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/SignIn': (context) => SignIn(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/SignUp': (context) => SignUp(),
          '/HomePage': (context) => HomePage(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    log('data: $firebaseUser');
    if (firebaseUser != null) {
      return HomePage();
    }
    return LoginOrSignUp();
  }
}