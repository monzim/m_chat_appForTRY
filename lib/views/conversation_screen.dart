import 'package:flutter/material.dart';
import 'package:m_chat_app/helper/constants.dart';
import 'package:m_chat_app/services/database.dart';
import 'package:hexcolor/hexcolor.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods detabaseMethods = new DatabaseMethods();
  TextEditingController messageController = new TextEditingController();

  Stream chatMessageStream;

  // ignore: non_constant_identifier_names
  Widget ChatMessageList() {
    return StreamBuilder(
      stream: chatMessageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                reverse: false,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data.documents[index].data["message"],
                      snapshot.data.documents[index].data["sendBy"] ==
                          Constants.myName);
                })
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text,
        "sendBy": Constants.myName,
        "time": DateTime.now().microsecondsSinceEpoch,
      };
      detabaseMethods.addConversationMessgaes(widget.chatRoomId, messageMap);
      messageController.text = "";
    }
  }

  @override
  void initState() {
    detabaseMethods.getConversationMessgaes(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#292F40"),
      appBar: AppBar(
        backgroundColor: HexColor("#45485A"),
        title: Image.asset(
          "assets/images/lll-1154.png",
          height: 50,
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 155,
              width: MediaQuery.of(context).size.width,
              child: ChatMessageList(),
            ),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, bottom: 1),
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor("#45485A"),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                // height: MediaQuery.of(context).size.height - 675,
                // width: MediaQuery.of(context).size.width,
                // color: Color(0x54FFFFFF),
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: messageController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Message...',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        sendMessage();
                      },
                      child: Container(
                          height: 40,
                          width: 40,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                const Color(0x36FFFFFF),
                                const Color(0x0FFFFFFF)
                              ]),
                              borderRadius: BorderRadius.circular(40)),
                          child: Image.asset("assets/images/send.png")),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.only(
          left: isSendByMe ? 20 : 24, right: isSendByMe ? 20 : 20),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isSendByMe

                  //  const Color(0xff007EF4),
                  //   cconst Color(0xff007EF4)
                  // ]
                  //     : [
                  //   const Color(0x1AFFFFFF),
                  //   const Color(0x1AFFFFFF)

                  //  ? [const Color(0xff007EF4), HexColor("#9BD1DC")]
                  // : [HexColor("#CFD7E3"), HexColor("#686C72")],

                  ? [const Color(0xff007EF4), const Color(0xff007EF4)]
                  : [HexColor("#CFD7E3"), HexColor("#686C72")],
            ),
            borderRadius: isSendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))),
        child: Text(
          message,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 17,
              fontFamily: 'overpass'),
        ),
      ),
    );
  }
}
