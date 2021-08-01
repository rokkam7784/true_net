// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:true_net/Constants/Colors.dart';
// import 'package:true_net/Constants/constUserData.dart';
// import 'package:true_net/Widget/database.dart';
// import 'package:true_net/chat/PersonalChat/personalMessages.dart';
// import 'package:true_net/chat/new_message.dart';
//
// class ConversationScreen extends StatefulWidget {
//   final String chatRoomId;
//   final String username;
//   final String userImage;
//   ConversationScreen(this.chatRoomId, this.username, this.userImage);
//   @override
//   _ConversationScreenState createState() => _ConversationScreenState();
// }
//
// class _ConversationScreenState extends State<ConversationScreen> {
//   DatabaseMethods databaseMethods = new DatabaseMethods();
//
//   final _controller = new TextEditingController();
//   var _enteredMessage = '';
//
//   QuerySnapshot? searchSnapshot;
//
//   void _sendMessage() async {
//     FocusScope.of(context).unfocus();
//     final user = FirebaseAuth.instance.currentUser!;
//     final userData = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(user.uid)
//         .get();
//     // FirebaseFirestore.instance.collection('Chat').add(
//     //   {
//     //     'text': _enteredMessage,
//     //     'createdAt': Timestamp.now(),
//     //     'userId': user.uid,
//     //     'username': userData['username'],
//     //     'userImage': userData['image_url'],
//     //   },
//     // );
//     FirebaseFirestore.instance
//         .collection('ChatRoom')
//         .doc(widget.chatRoomId)
//         .collection('chats')
//         .add({
//       'Message': _enteredMessage,
//       'createdAt': Timestamp.now(),
//       'sendBy': userData['username'],
//       'userId': user.uid,
//       'userImage': userData['image_url'],
//     });
//
//     setState(() {
//       _enteredMessage = '';
//       _controller.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Kclr21,
//       appBar: AppBar(
//         toolbarHeight: MediaQuery.of(context).size.height * .12,
//         title: Row(
//           children: [
//             CircleAvatar(
//               radius: 32,
//               backgroundColor: Kclr21,
//               child: CircleAvatar(
//                 radius: 29,
//                 backgroundColor: Kclr22,
//                 backgroundImage: NetworkImage(widget.userImage),
//               ),
//             ),
//             SizedBox(
//               width: 8,
//             ),
//             Text(widget.username),
//           ],
//         ),
//         // centerTitle: true,
//         backgroundColor: Color(0xffFD0054),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('images/ChatBg (9).png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         constraints: BoxConstraints.expand(),
//         child: Column(
//           children: [
//             Expanded(
//               child: PersonalMessages(widget.chatRoomId),
//             ),
//             Container(
//               alignment: Alignment.bottomCenter,
//               decoration: BoxDecoration(
//                 color: Kclr01,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(30),
//                 ),
//               ),
//               margin: EdgeInsets.fromLTRB(5, 8, 5, 5),
//               padding: EdgeInsets.fromLTRB(5, 0, 10, 3),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Container(
//                         child: CircleAvatar(
//                           backgroundColor: Kclr21,
//                           radius: 28,
//                           child: CircleAvatar(
//                             backgroundImage: NetworkImage(Constants.myImageUrl),
//                             radius: 25,
//                           ),
//                         ),
//                         margin: EdgeInsets.fromLTRB(3, 7, 3, 0),
//                       ),
//                       SizedBox(
//                         width: 8,
//                       ),
//                       Expanded(
//                         child: TextField(
//                           // controller: _controller,
//                           decoration: InputDecoration(
//                             labelText: "Send a message ...",
//                             labelStyle:
//                                 new TextStyle(color: Kclr22, fontSize: 20),
//                             enabledBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Kclr21),
//                             ),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Kclr21),
//                             ),
//                             border: UnderlineInputBorder(
//                               borderSide: BorderSide(color: Kclr21),
//                             ),
//                           ),
//                           onChanged: (value) {
//                             setState(
//                               () {
//                                 _enteredMessage = value;
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: _enteredMessage.trim().isEmpty
//                             ? null
//                             : _sendMessage,
//                         icon: Icon(
//                           Icons.send,
//                           size: 35,
//                         ),
//                         color: Kclr22,
//                       )
//                     ],
//                   ),
//                   SizedBox(
//                     height: 5,
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 5,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//TODO New start
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:true_net/Constants/Colors.dart';
import 'package:true_net/Constants/constUserData.dart';
import 'package:true_net/Widget/database.dart';
import 'package:true_net/chat/PersonalChat/personalMessages.dart';
import 'package:true_net/chat/PersonalChat/personalNewMessage.dart';
import 'package:true_net/chat/new_message.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  final String username;
  final String userImage;
  ConversationScreen(
      {required this.chatRoomId,
      required this.username,
      required this.userImage});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  void initState() {
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen(
      (message) {
        print(message);
        return;
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print(message);
        return;
      },
    );
    fbm.subscribeToTopic('chats');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kclr21,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .12,
        title: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Kclr21,
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Kclr22,
                backgroundImage: NetworkImage(widget.userImage),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.username,
              //TODO styling conversation screen name
              style: GoogleFonts.libreBaskerville(
                wordSpacing: 1,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Kclr21,
              ),
            )
          ],
        ),
        // centerTitle: true,
        backgroundColor: Color(0xffFD0054),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/ChatBg (9).png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: Column(
          children: [
            Expanded(
              child: PersonalMessages(widget.chatRoomId),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Kclr01,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              margin: EdgeInsets.fromLTRB(5, 8, 5, 5),
              padding: EdgeInsets.fromLTRB(5, 0, 10, 3),
              child: Column(
                children: [
                  PersonalNewMessage(
                    widget.chatRoomId,
                    // widget.username,
                    // widget.userImage,
                  ),
                  SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
