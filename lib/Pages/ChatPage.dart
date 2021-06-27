import 'package:chat/CustomUI/CustomCard.dart';
import 'package:chat/Model/ChatModel.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.chatmodels, required this.sourcechat})
      : super(key: key);
  final List<ChatModel> chatmodels;
  final ChatModel sourcechat;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: ListView.builder(
          itemCount: widget.chatmodels.length,
          itemBuilder: (context, index) => CustomCard(
                chatModel: widget.chatmodels[index],
                sourcechat: widget.sourcechat,
              )),
    );
  }
}
