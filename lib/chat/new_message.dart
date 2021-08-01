import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:true_net/Constants/Colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:true_net/Constants/constUserData.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add(
      {
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
        'username': userData['username'],
        'userImage': userData['image_url'],
      },
    );
    setState(() {
      _enteredMessage = '';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundColor: Kclr21,
                  radius: 28.5,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(Constants.myImageUrl),
                    radius: 25,
                  ),
                ),
                margin: EdgeInsets.fromLTRB(3, 7, 3, 0),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: "Send a message ...",
                    labelStyle: new TextStyle(color: Kclr22, fontSize: 20),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Kclr21),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Kclr21),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Kclr21),
                    ),
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        _enteredMessage = value;
                      },
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
                icon: Icon(
                  Icons.send,
                  size: 35,
                ),
                color: Kclr22,
              )
            ],
          ),
          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
