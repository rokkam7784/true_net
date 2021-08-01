import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:true_net/chat/message_bubble.dart';

class PersonalMessages extends StatelessWidget {
  PersonalMessages(this.chatRoomId);
  final String chatRoomId;
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('ChatRoom')
          .doc(chatRoomId)
          .collection("chats")
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
          itemBuilder: (ctx, index) => MessageBubble(
            chatDocs[index]['Message'],
            chatDocs[index]['sendBy'],
            chatDocs[index]['userImage'],
            chatDocs[index]['userId'] == user!.uid,
            key: ValueKey(chatDocs[index].id),
          ),
        );
      },
    );
  }
}
