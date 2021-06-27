import 'package:chat/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage('assets/notes.jpg')),
        LoginScreen(),
      ],
    );
  }
}
