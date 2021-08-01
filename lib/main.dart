import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_net/Screens/homeScreen.dart';

import 'Constants/Colors.dart';
import 'Screens/chatRoomScreen.dart';
import 'Screens/authScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //TODO 1: First, you have to call Firebase.initializeApp(); early in your app
    // .initializeApp() returns a Future,
    // hence we use a FutureBuilder to either show the SplashScreen()
    // if we're still waiting for app initialization or to show or regular StreamBuilder-based output if the app was initialized.

    // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (context, appSnapshot) {
        if (!appSnapshot.hasData) {
          return Container();
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.hasData) {
                  return HomeScreen();
                }
                return AuthScreen();
              },
            ),
          );
        }
      },
    );
  }
}
