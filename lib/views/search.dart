import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:m_chat_app/helper/constants.dart';
import 'package:m_chat_app/services/database.dart';
import 'package:m_chat_app/views/conversation_screen.dart';
import 'package:m_chat_app/widgets/widget.dart';

class SeachScreen extends StatefulWidget {
  @override
  _SeachScreenState createState() => _SeachScreenState();
}

class _SeachScreenState extends State<SeachScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchTextEditingController =
      new TextEditingController();

  QuerySnapshot searchSnapshot;

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            itemCount: searchSnapshot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SearchTitle(
                userName: searchSnapshot.documents[index].data['name'],
                userEmail: searchSnapshot.documents[index].data['email'],
              );
            })
        : Container();
  }

  initiateSearch() {
    databaseMethods
        .getUserByUseName(searchTextEditingController.text)
        .then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  // create chatroom, send user to the comversation screen, pushreplacement
  createChatRoomAndStartConversation({String userName}) {
    if (userName != Constants.myName) {
      String chatRoomId = getChatRoomId(userName, Constants.myName);

      List<String> users = [userName, Constants.myName];

      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatroomId": chatRoomId
      };

      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(chatRoomId)));
    } else {
      print('You cannot send message to yourself');
    }
  }

  // ignore: non_constant_identifier_names
  Widget SearchTitle({String userName, String userEmail}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: HexColor("#FFFFFF"),
        borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
              Text(
                userEmail,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              createChatRoomAndStartConversation(userName: userName);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(30)),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Message',
                style: mediumTexteStyle(),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#BEBDBD"),
      appBar: AppBar(
        backgroundColor: HexColor("##59484B"),
        centerTitle: true,
        shadowColor: Colors.black87,
        title: Image.asset(
          "assets/images/lll-1154.png",
          height: 50,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor("#636161"),
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                          controller: searchTextEditingController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'search user here...',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        icon: Icon(Icons.search),
                        splashRadius: 20,
                        // color: Colors.blue,
                        iconSize: 35,
                        onPressed: () {
                          initiateSearch();
                        }),
                  ],
                ),
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
