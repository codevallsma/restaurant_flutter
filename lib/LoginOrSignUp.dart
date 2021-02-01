import 'package:api_example/SignIn.dart';
import 'package:api_example/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:api_example/Animation/FadeAnimation.dart';
import 'package:api_example/rutes.dart';



class LoginOrSignUp extends StatefulWidget {
  LoginOrSignUp({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _LoginOrSignUpState createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 500,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 500,
                    width: width,
                    child: FadeAnimation(1, Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/sign_up.png'),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1.7, Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(55, 131, 148, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ]
                    ),
                  )),
                  FadeAnimation(1.9, Container(
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(top: 30.0),
                                width: double.infinity,
                                height: 40.0,
                                child:new MaterialButton(
                                minWidth: 300.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Color.fromRGBO(55, 131, 148, 1))),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                child: new Text("Sign in ".toUpperCase()),
                                  onPressed: () {
                                    Navigator.of(context).push(createRouteWithSlide(SignIn()));
                                  },
                                splashColor: Color.fromRGBO(55, 131, 148, 1),
                              )),
                            Container(
                                width: double.infinity,
                                height: 40.0,
                                margin: const EdgeInsets.only(top: 20.0),
                                child:new MaterialButton(
                                  minWidth: 300.0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Color.fromRGBO(55, 131, 148, 1))),
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  child: new Text("Sign up ".toUpperCase()),
                                  onPressed: () => { Navigator.of(context).push(createRouteWithSlide(SignUp()))},
                                  splashColor: Color.fromRGBO(55, 131, 148, 1),
                                )),

                          ],
                        )
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



/*child: new MaterialButton(
height: 40.0,
minWidth: 300.0,
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(18.0),
side: BorderSide(color: Color.fromRGBO(55, 131, 148, 1))),
color: Theme.of(context).primaryColor,
textColor: Colors.white,
child: new Text("push"),
onPressed: () => {},
splashColor: Colors.redAccent,
)*/
/*
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(
                                  color: Colors.grey[200]
                              ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Username",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        )
                      ],
                    ),
 */


