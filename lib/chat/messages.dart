import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:true_net/chat/MessageBubbleIMG.dart';
import 'package:true_net/chat/message_bubble.dart';
// class Messages extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('chat')
//           .orderBy(
//             'createdAt',
//             descending: true,
//           )
//           .snapshots(),
//       builder: (ctx, chatSnapshot) {
//         if (chatSnapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         final chatDocs = chatSnapshot.data!.docs;
//
//         return ListView.builder(
//           reverse: true,
//           itemCount: chatDocs.length,
//           itemBuilder: (ctx, index) => MessageBubble(
//             chatDocs[index].data()['text'],
//             // chatDocs[index].data()['username'],
//             // chatDocs[index].data()['userImage'],
//             chatDocs[index].data()['userId'] == user.uid,
//             key: ValueKey(chatDocs[index].id),
//           ),
//         );
//       },
//     );
//   }
// }

//Todo currentUser() no longer returns a Future but instead acts as a property which immediately returns the current user object - synchronously!

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xffFD0054),
            ),
          );
        }
        final chatDocs = chatSnapshot.data!.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs.length,
          itemBuilder: (ctx, index) => MessageBubbleIMG(
            chatDocs[index]['text'],
            chatDocs[index]['username'],
            chatDocs[index]['userImage'],
            chatDocs[index]['userId'] == user!.uid,
            key: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
  }
}
