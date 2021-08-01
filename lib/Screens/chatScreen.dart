import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:true_net/Constants/Colors.dart';
import 'package:true_net/chat/messages.dart';
import 'package:true_net/chat/new_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
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
    fbm.subscribeToTopic('chat');
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
            Container(
              child: Image.asset(
                'images/TRUE.png',
                height: MediaQuery.of(context).size.height * .12,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Text("T.R.U.E", //TODO styling chat screen name
                    style: GoogleFonts.alegreyaSc(
                      wordSpacing: 1,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Kclr21,
                    )),
              ],
            ),
            // SizedBox(
            //   width: 20,
            // ),
            // Image.asset(
            //   'images/TRUE.png',
            //   height: 85,
            // ),
          ],
        ),
        backgroundColor: Color(0xffFD0054),
      ),
      // body: StreamBuilder<QuerySnapshot>(
      //   stream: FirebaseFirestore.instance
      //       .collection('/chats/9IiSfzM1mVMsEm2wK1R7/messages')
      //       .snapshots(),
      //   builder: (ctx, streamSnapshot) {
      //     if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //     final documents = streamSnapshot.data!.docs;
      //     return ListView.builder(
      //       itemCount: documents.length,
      //       itemBuilder: (ctx, index) => Container(
      //         padding: EdgeInsets.all(8),
      //         child: Text(documents[index]["text"]),
      //       ),
      //     );
      //   },
      // ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/ChatBg (9).png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}

// floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           //   FirebaseFirestore.instance
//           //       .collection('/chats/9IiSfzM1mVMsEm2wK1R7/messages')
//           //       .snapshots()
//           //       .listen(
//           //     (data) {
//           //       data.docs.forEach((document) {
//           //         print(document['text']);
//           //       });
//           //     },
//           //   );
//           FirebaseFirestore.instance
//               .collection("/chats/9IiSfzM1mVMsEm2wK1R7/messages")
//               .add({"text": "added by clicking a button"});
//         },
//         child: Icon(Icons.add),
//       ),
