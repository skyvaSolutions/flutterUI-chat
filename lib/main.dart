import 'package:camera/camera.dart';
import 'package:chat/Pages/LandingPage.dart';
import 'package:chat/screens/CameraScreen.dart';
import 'package:chat/screens/LoginScreen.dart';

import 'package:chat/screens/homeScreen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: Colors.lightBlue,
        ),
        home: LandingPage());
  }
}
