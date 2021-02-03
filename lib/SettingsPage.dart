
import 'package:api_example/Authentication/authentication_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AlertDialog changePassword = AlertDialog(
      title: Text('Change Password'),
      contentPadding: EdgeInsets.zero,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
                labelText: 'NEW Password',
                labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
                // hintText: 'EMAIL',
                // hintStyle: ,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Theme.of(context).primaryColor))),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Return"),
          ),
          RaisedButton(
            onPressed: () {
              //TODO: REALITZAR PETICIÓ CANVIAR CONTRASENYA
              Navigator.of(context).pop();
            },
            child: Text("Change"),
          ),

        ])
    );

    final AlertDialog changeEmail = AlertDialog(
        title: Text('Change Email'),
        contentPadding: EdgeInsets.zero,
        content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'NEW Email',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    // hintText: 'EMAIL',
                    // hintStyle: ,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor))),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Return"),
              ),
              RaisedButton(
                onPressed: () {
                  //TODO: REALITZAR PETICIÓ CANVIAR MAIL
                  Navigator.of(context).pop();
                },
                child: Text("Change"),
              ),

            ])
    );

    final AlertDialog changeUsername = AlertDialog(
        title: Text('Change username'),
        contentPadding: EdgeInsets.zero,
        content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                    labelText: 'NEW Username',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    // hintText: 'EMAIL',
                    // hintStyle: ,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor))),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Return"),
              ),
              RaisedButton(
                onPressed: () {
                  //TODO: REALITZAR PETICIÓ CANVIAR USUARI
                  Navigator.of(context).pop();
                },
                child: Text("Change"),
              ),

            ])
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
              child: Text(
                'Settings',
                style:
                TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold),
              ),
            ),

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
                child: new Text("Change Username".toUpperCase()),
                onPressed: () {
                  showDialog<void>(context: context, builder: (context) => changeUsername);
                },
                splashColor: Color.fromRGBO(55, 131, 148, 1),
              )),

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
                  child: new Text("Change Password".toUpperCase()),
                  onPressed: () {
                    showDialog<void>(context: context, builder: (context) => changePassword);
                  },
                  splashColor: Color.fromRGBO(55, 131, 148, 1),
                )),

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
                  child: new Text("Change Email".toUpperCase()),
                  onPressed: () {
                    showDialog<void>(context: context, builder: (context) => changeEmail);
                  },
                  splashColor: Color.fromRGBO(55, 131, 148, 1),
            )),

            Container(
              height: 40.0,
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black,
                        style: BorderStyle.solid,
                        width: 1.0),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.0)),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child:

                  Center(
                    child: Text('Go Back',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat')),
                  ),


                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}