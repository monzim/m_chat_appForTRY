import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:m_chat_app/helper/authenticate.dart';
import 'package:m_chat_app/helper/constants.dart';
import 'package:m_chat_app/helper/helperfunctions.dart';
import 'package:m_chat_app/services/auth.dart';
import 'package:m_chat_app/services/database.dart';
import 'package:m_chat_app/views/conversation_screen.dart';
import 'package:m_chat_app/views/search.dart';
import 'package:m_chat_app/widgets/widget.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return ChatRoomsTile(
                      snapshot.data.documents[index].data["chatroomId"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      snapshot.data.documents[index].data["chatroomId"]);
                })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();

    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameInSharedPrefrence();
    databaseMethods.getChatRooms(Constants.myName).then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#45485A"),
      appBar: AppBar(
        backgroundColor: HexColor("#C27E8C"),
        shadowColor: Colors.deepOrange[300],
        title: Text(
          'MChats',
          style: TextStyle(
            fontFamily: 'Texturina-Variable',
            fontSize: 20,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Image.asset(
            "assets/images/lll-1154.png",
            height: 50,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.auto_awesome_mosaic),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InfoAboutAppPage()));
                print('menu clicked');
              }),
          GestureDetector(
            onTap: () {
              authMethods.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.arrow_forward_ios),
            ),
          ),
          SizedBox(width: 10)
        ],
      ),
      body: chatRoomList(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: HexColor("#1990FF"),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SeachScreen(),
              ));
        },
        child: Icon(Icons.person_search, color: Colors.black),
      ),
    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomsTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoomId)));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HexColor("#45485A"),
                      borderRadius: BorderRadius.circular(40)),
                  child: Text(
                    '${userName.substring(0, 1).toUpperCase()}',
                    style: mediumTexteStyle(),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 4.5),
                Text(
                  userName.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
