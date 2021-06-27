import 'package:chat/Model/ChatModel.dart';
import 'package:chat/screens/IndividualPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key, required this.chatModel, required this.sourcechat})
      : super(key: key);
  final ChatModel chatModel;
  final ChatModel sourcechat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => IndividualPage(
                      chatModel: chatModel,
                      sourcechat: sourcechat,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            // contentPadding: EdgeInsets.only(left: 7, top: 5),
            leading: CircleAvatar(
              radius: 26,
              child: SvgPicture.asset(
                'assets/person1.svg',
                color: Colors.white,
                width: 10,
                height: 25,
              ),
              backgroundColor: Colors.blueGrey[100],
            ),
            title: Text(
              chatModel.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            subtitle: Row(
              children: [
                // Icon(
                //   Icons.done_all,
                //   color: Colors.cyan,
                // ),
                // SizedBox(
                //   width: 3,
                // ),
                // Text(
                //   chatModel.currentMessage,
                //   style: TextStyle(fontSize: 15),
                // ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 0.7,
              height: 6,
            ),
          )
        ],
      ),
    );
  }
}
