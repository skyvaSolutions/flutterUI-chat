import 'package:chat/CustomUI/OwnMessageCard.dart';
import 'package:chat/CustomUI/ReplyCard.dart';
import 'package:chat/Model/ChatModel.dart';
import 'package:chat/Model/MessageModel.dart';
import 'package:chat/screens/CameraScreen.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
//import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  const IndividualPage(
      {Key? key, required this.chatModel, required this.sourcechat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourcechat;

  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  late IO.Socket socket;
  bool sendButton = false;
  bool show = false;
  List<MessageModel> messages = [];

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io("http://192.168.0.5:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });

    socket.connect();
    socket.emit("signin", widget.sourcechat.id);
    socket.onConnect((data) {
      print("Connected");
      socket.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket.connected);
  }

  void sendMessage(String message, int sourceId, int targetId) {
    setMessage("source", message);
    socket.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Widget emojiSelect() {
    //   return EmojiPicker(
    //       rows: 4,
    //       columns: 7,
    //       onEmojiSelected: (emoji, category) {
    //         print(emoji);
    //       });
    // }

    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.yellow[800],
          leadingWidth: 70,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: Colors.black,
                ),
                CircleAvatar(
                  child: SvgPicture.asset(
                    "assets/person1.svg",
                    color: Colors.white,
                    height: 36,
                    width: 36,
                  ),
                  radius: 20,
                  backgroundColor: Colors.blueGrey[100],
                )
              ],
            ),
          ),
          title: InkWell(
            onTap: () {},
            child: Container(
              // margin: EdgeInsets.all(1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chatModel.name,
                    style: TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  // Text(
                  //   'last seen today at 7:46',
                  //   style: TextStyle(fontSize: 13),
                  // )
                ],
              ),
            ),
          ),
          actions: [
            //IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.call,
                  color: Colors.black,
                )),
            PopupMenuButton<String>(
              onSelected: (value) {
                print(value);
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              itemBuilder: (BuildContext contesxt) {
                return [
                  PopupMenuItem(
                    child: Text("View"),
                    value: "View Contact",
                  ),
                  PopupMenuItem(
                    child: Text("Mute Notifications"),
                    value: "Mute Notifications",
                  ),
                  PopupMenuItem(
                    child: Text("Documents, links"),
                    value: "Documents",
                  ),
                  PopupMenuItem(
                    child: Text("Search"),
                    value: "Search",
                  ),
                  PopupMenuItem(
                    child: Text("Settings"),
                    value: "Settings",
                  ),
                ];
              },
            )
          ],
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
        child: Column(
          children: [
            Expanded(
              // height: MediaQuery.of(context).size.height - 150,
              child: ListView.builder(
                      controller: _scrollController,
                      itemCount: messages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == messages.length) {
                          return Container(
                            height: 70,
                          );
                        }
                        if (messages[index].type == "source") {
                          return OwnMessageCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        } else {
                          return ReplyCard(
                            message: messages[index].message,
                            time: messages[index].time,
                          );
                        }
                      },
                    ),
                  ),
                // children: [
                //   OwnMessageCard(message: "Hey, Anna here!", time: "5:08"),
                //   ReplyCard(message: "Hi, How are you", time: "5:10"),
                //   OwnMessageCard(message: "I'm good, what's up?", time: "5:14"),
                //   ReplyCard(message: "Nothign much, though!", time: "5:16"),
                //   OwnMessageCard(message: "Oh, okay!", time: "5:20"),
                //   ReplyCard(message: "How's the weather there?", time: "5:23"),
                //   OwnMessageCard(
                //       message: "It's pretty cool and chilling!", time: "5:31"),
                //   ReplyCard(message: "Well, that sounds good!", time: "5:36")
                // ],
              
          
            
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 55,
                          child: Card(
                            margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              controller: _controller,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  setState(() {
                                    sendButton = true;
                                  });
                                } else {
                                  setState(() {
                                    sendButton = false;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                fillColor: Colors.cyan[200],
                                border: InputBorder.none,
                                hintText: 'Type a message...',
                                prefixIcon: IconButton(
                                  icon: Icon(
                                    Icons.emoji_emotions,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {},
                                ),
                                suffixIcon: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.attach_file),
                                      color: Colors.black,
                                      onPressed: () {
                                        showModalBottomSheet(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (builder) => bottomSheet());
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      color: Colors.black,
                                      onPressed: () {
                                        CameraScreen();
                                      },
                                    ),
                                  ],
                                ),
                                contentPadding: EdgeInsets.all(5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8,
                              right: 2,
                            ),
                            child: CircleAvatar(
                                backgroundColor: Colors.yellow[800],
                                radius: 23,
                                child: IconButton(
                                  icon: Icon(
                                    sendButton ? Icons.send : Icons.mic,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (sendButton) {
                                      _scrollController.animateTo(
                                                  _scrollController
                                                      .position.maxScrollExtent,
                                                  duration:
                                                      Duration(milliseconds: 300),
                                                  curve: Curves.easeOut);
                                      sendMessage(_controller.text,
                                          widget.sourcechat.id, widget.chatModel.id);
                                      _controller.clear();
                                      setState(() {
                                          sendButton = false;
                                        });
                                    }
                                  },
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
              //emojiSelect(),
            ),
          ],
        ),
        onWillPop: () {
                if (show) {
                  setState(() {
                    show = false;
                  });
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
      ),
      ),
      // ),
    );
  }

  Widget bottomSheet() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(width: 40),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(width: 40),
                  iconCreation(Icons.insert_photo, Colors.purple, "Gallery"),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.location_pin, Colors.orange, "Location"),
                  SizedBox(width: 40),
                  iconCreation(Icons.info, Colors.blue, "Info"),
                  SizedBox(width: 40),
                  iconCreation(Icons.link, Colors.teal, "Links"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icon, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
