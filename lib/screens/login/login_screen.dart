import 'package:bniapp/screens/main/main_screen.dart';
import 'package:bniapp/utils/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showSpinner = false;
  AppState _appState = AppState.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        // JCC: builder agregado para el uso de SnackBar
        builder: (BuildContext context) {
          return ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          height: 128,
                          child: Image.asset('images/bni_logo.jpg'),
                        ),
                      ),
                    ),
                    Text(
                      'Perú',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Roboto',
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(
                      width: 128,
                      height: 64,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.person),
                          labelText: 'Usuario',
                        ),
                        onChanged: (value) {
                          email = value;
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () async {
                            setState(() {
                              showSpinner = true;
                            });
                            try {
                              FirebaseUser user =
                                  (await _auth.signInWithEmailAndPassword(
                                          email: email.trim(),
                                          password: password))
                                      .user;
                              if (user != null) {
                                await _appState.loadAppState();
                                Navigator.pushNamed(context, MainScreen.id);
                              }
                            } catch (e) {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Email o password incorrecto'),
                                duration: Duration(seconds: 2),
                              ));
                              print(e); // TODO
                            } finally {
                              setState(() => showSpinner = false);
                            }
                          },
                          child: Text('INGRESAR'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
