import 'package:chat/Pages/ChatPage.dart';
import 'package:chat/screens/LoginScreen.dart';
import 'package:chat/screens/SecondPage.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Image(image: AssetImage('assets/chat.jpg')),
          Text(
            ' Welcome\n      to\nyour Chat',
            style: TextStyle(
                color: Colors.indigo[900],
                fontFamily: "Mali",
                fontSize: 50,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: Divider(
              thickness: 0.8,
              color: Colors.indigo[900],
              height: 8,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              Image(
                image: AssetImage('assets/chitchat.png'),
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 80,
                width: 20,
              ),
              ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.pink[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  onPressed: () {
                    Navigator.push(
                context, MaterialPageRoute(builder: (builder) => LoginScreen()));
                  },
                  child: Text(
                    "Let's go",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Text(
            '                               Chat with the business \n                               and get all your queries resolved instantly',
            style: TextStyle(fontSize: 13),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "Skywa",
            style: TextStyle(
                fontFamily: 'Mali',
                color: Colors.indigo[900],
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
