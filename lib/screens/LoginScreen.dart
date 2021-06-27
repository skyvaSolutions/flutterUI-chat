import 'package:chat/CustomUI/ButtonCard.dart';
import 'package:chat/Model/ChatModel.dart';
import 'package:chat/screens/homeScreen.dart';

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ChatModel sourceChat;                     
  List<ChatModel> chatmodels = [
    ChatModel(
        name: 'Customer-1',
        icon: "person.svg",
        isGroup: false,
        time: "02:43",
        currentMessage: "",
        id: 1),
    ChatModel(
        name: 'Customer-2',
        icon: "person.svg",
        isGroup: false,
        time: "03:08",
        currentMessage: "",
        id: 2),
    ChatModel(
        name: 'Customer-3',
        icon: "person.svg",
        isGroup: false,
        time: "01:53",
        currentMessage: "",
        id: 3),
    ChatModel(
        name: 'Customer-4',
        icon: "person.svg",
        isGroup: false,
        time: "12:49",
        currentMessage: "",
        id: 4),
    ChatModel(
        name: 'Customer-5',
        icon: "person.svg",
        isGroup: false,
        time: "16:24",
        currentMessage: "",
        id: 5),
    ChatModel(
        name: 'Customer-6',
        icon: "person.svg",
        isGroup: false,
        time: "19:23",
        currentMessage: "",
        id: 6),
    ChatModel(
        name: 'Customer-7',
        icon: "person.svg",
        isGroup: false,
        time: "21:37",
        currentMessage: "",
        id: 7),
    ChatModel(
        name: 'Customer-8',
        icon: "person.svg",
        isGroup: false,
        time: "22:37",
        currentMessage: "",
        id: 8),
    ChatModel(
        name: 'Customer-9',
        icon: "person.svg",
        isGroup: false,
        time: "1:37",
        currentMessage: "",
        id: 9),
    ChatModel(
        name: 'Customer-10',
        icon: "person.svg",
        isGroup: false,
        time: "05:57",
        currentMessage: "",
        id: 10),
  ];

  // ChatModel(
  //   name: "NodeJs Group",
  //   isGroup: true,
  //   currentMessage: "New NodejS Post",
  //   time: "2:00",
  //   icon: "group.svg",
  // ),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 350,
        title: Center(child: Image(image: AssetImage('assets/notes.jpg'))),
      ),
      body: ListView.builder(
        itemCount: chatmodels.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            sourceChat = chatmodels.removeAt(index);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) => Homescreen(
                          chatmodels: chatmodels,
                          sourcechat: sourceChat,
                        )));
          },
          child: ButtonCard(
            icon: Icons.person,
            name: chatmodels[index].name,
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
