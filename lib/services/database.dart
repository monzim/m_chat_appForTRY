import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:m_chat_app/views/chatRoomsScreen.dart';

class DatabaseMethods {
  getUserByUseName(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  uploadUserInfo(userMap) {
    Firestore.instance.collection('users').add(userMap).catchError((e) {
      print(e.toString());
    });
  }
}

createChatRoom(String chatroomId, chatRoomMap) {
  Firestore.instance
      .collection('ChatRoom')
      .document(chatroomId)
      .setData(chatRoomMap)
      .catchError((e) {
    print(e.toString());
  });
}
