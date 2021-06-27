import 'package:chat/Model/ChatModel.dart';
import 'package:chat/Pages/CallPage.dart';
import 'package:chat/Pages/CameraPage.dart';
import 'package:chat/Pages/ChatPage.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key? key, required this.chatmodels, required this.sourcechat})
      : super(key: key);

  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  // int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 45, fontWeight: FontWeight.bold);
  // static const List<Widget> _widgetOptions = <Widget>[
  //   CameraPage(),
  //   ChatPage(

  //     chatmodels: ,

  //   ),
  //   Text(
  //     'Index 2: Calls',
  //     style: optionStyle,
  //   ),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          // IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (BuildContext contesxt) {
              return [
                PopupMenuItem(
                  child: Text("Starred messages"),
                  value: "Starred messages",
                ),
                PopupMenuItem(
                  child: Text("Settings"),
                  value: "Settings",
                ),
              ];
            },
          )
        ],
        title: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Chat App",
              style: TextStyle(
                  fontFamily: 'Mali',
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Center(child: Image(image: AssetImage('assets/chatting.jpg'))),
          ],
        ),
        toolbarHeight: 300,

        // body: Center(
        //   child: _widgetOptions.elementAt(_selectedIndex),
        // ),

        // bottomNavigationBar: BottomNavigationBar(
        //   backgroundColor: Colors.deepOrange[100],
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.camera_alt_outlined,
        //         size: 30,
        //       ),
        //       label: "Upload Media",
        //       backgroundColor: Colors.cyan,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.chat_bubble_outline_rounded, size: 30),
        //       label: 'Messages',
        //       backgroundColor: Colors.yellow,
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.phone, size: 30),
        //       label: 'Calls',
        //       backgroundColor: Colors.green,
        //     ),
        //   ],
        //   elevation: 50.0,
        //   currentIndex: _selectedIndex,
        //   selectedItemColor: Colors.black,
        //   onTap: _onItemTapped,
        // ),
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.pink,
          indicatorWeight: 5.0,
          tabs: [
            Tab(
              icon: Icon(Icons.camera_alt),
            ),
            Tab(
              text: "CHATS",
            ),
            // Tab(
            //   text: "CALLS",
            // )
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          CameraPage(),
          ChatPage(
            chatmodels: widget.chatmodels,
            sourcechat: widget.sourcechat,
          ),
          // Text("Calls"),
        ],
      ),
    );
  }
}
