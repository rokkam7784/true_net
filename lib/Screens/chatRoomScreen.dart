import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_net/Constants/Colors.dart';
import 'package:true_net/Screens/aboutScreen.dart';
import 'package:true_net/Screens/chatScreen.dart';
import 'package:true_net/Constants/constUserData.dart';
import 'package:true_net/Widget/database.dart';
import 'package:true_net/Widget/helperFunctions.dart';

import 'conversationScreen.dart';

class ChatRoomScreen extends StatefulWidget {
  @override
  _ChatRoomScreenState createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUserNamePreference())!;
    print("Name: ${Constants.myName}");
    Constants.myEmail = (await HelperFunctions.getUserEmailPreference())!;
    print("Email: ${Constants.myEmail}");
    Constants.myImageUrl = (await HelperFunctions.getUserImagePreference())!;
    print("Image: ${Constants.myImageUrl}");

    setState(() {
      databaseMethods.getChatRooms(Constants.myName).then(() {});
    });

    // setState(() {
    //   databaseMethods.getChatRooms(Constants.myName).then(() {});
    // });
  }

  DatabaseMethods databaseMethods = new DatabaseMethods();

  Widget chatRoomList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('ChatRoom')
          .where("users", arrayContains: Constants.myName)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              color: Color(0xffFD0054),
            ),
          );
        }
        final chatDocs = snapshot.data!.docs;
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) {
                  return
                      //   searchTile(
                      //   userName: searchSnapshot!.docs[index]["username"],
                      //   userEmail: searchSnapshot!.docs[index]["email"],
                      //   userImage: searchSnapshot!.docs[index]["image_url"],
                      // );
                      ChatRoomTile(
                    username:
                        (chatDocs[index]["chatRoomUser1"] != Constants.myName)
                            ? chatDocs[index]["chatRoomUser1"]
                            : chatDocs[index]["chatRoomUser2"],
                    userImg: (chatDocs[index]["chatRoomImage1"] !=
                            Constants.myImageUrl)
                        ? chatDocs[index]["chatRoomImage1"]
                        : chatDocs[index]["chatRoomImage2"],
                    chatRoom: chatDocs[index]["chatRoomId"],
                  );
                  // searchSnapshot!.docs[index]["username"]);
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kclr21,
      appBar: AppBar(
        //TODO design Appbar text
        title: Text(
          "TrueNet",
          style: GoogleFonts.tradeWinds(
            wordSpacing: 1,
            letterSpacing: 1,
            fontWeight: FontWeight.bold,
            fontSize: 27,
            color: Kclr21,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffFD0054),
        actions: [
          DropdownButton(
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                setState(() {
                  FirebaseAuth.instance.signOut();
                  HelperFunctions.saveUserNamePreference("");
                  HelperFunctions.saveUserEmailPreference("");
                  HelperFunctions.saveUserImagePreference("");
                  HelperFunctions.saveUserLoggedInPreference(false);
                  print("Name: ${Constants.myName}");
                  print("Email: ${Constants.myEmail}");
                  print("Image: ${Constants.myImageUrl}");
                });
              }
              if (itemIdentifier == 'about') {
                //TODO about page
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutScreen()));
              }
            },
            icon: Icon(
              Icons.more_vert,
              size: 35,
              color: Kclr21,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Kclr22,
                        size: 30,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Logout',
                        // style: TextStyle(fontWeight: FontWeight.bold),
                        //TODO styling Logout text
                        style: GoogleFonts.libreBaskerville(
                          // wordSpacing: 1,
                          // letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          // fontSize: 21,
                          color: Kclr21,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 'about',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Kclr22,
                        size: 30,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'About',
                        // style: TextStyle(fontWeight: FontWeight.bold),
                        //TODO styling Logout text
                        style: GoogleFonts.libreBaskerville(
                          // wordSpacing: 1,
                          // letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                          // fontSize: 21,
                          color: Kclr21,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(8, 6, 8, 5),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ChatScreen()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xffEEEBDD),
                          const Color(0xffEEEBDD),
                          const Color(0xffEEEBDD),
                          // const Color(0xffFFD523),
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * 0.115,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: Image.asset(
                            "images/TRUE.png",
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "T.R.U.E",
                          //TODO styling True main group
                          style: GoogleFonts.libreBaskerville(
                            wordSpacing: 1,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Kclr21,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          chatRoomList(),
        ],
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String username;
  final String userImg;
  final String chatRoom;
  ChatRoomTile({
    required this.username,
    required this.userImg,
    required this.chatRoom,
  });
  @override
  Widget build(BuildContext context) {
    print(username);
    print(userImg);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(
                      username: username,
                      userImage: userImg,
                      chatRoomId: chatRoom,
                    )));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(8, 5, 8, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
          gradient: LinearGradient(
            colors: [
              const Color(0xffEEEBDD),
              const Color(0xffEEEBDD),
              const Color(0xffEEEBDD),
              // const Color(0xffFFD523),
            ],
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.115,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(
            //       Radius.circular(13),
            //     ),
            //   ),
            //   margin: EdgeInsets.only(
            //       bottom: MediaQuery.of(context).size.height * 0.01),
            //   child: Image.network(
            //     userImg,
            //     height: MediaQuery.of(context).size.height * 0.3,
            //   ),
            // ),
            CircleAvatar(
              radius: 32,
              backgroundColor: Kclr21,
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Kclr22,
                backgroundImage: NetworkImage(userImg),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Text(
              username,
              //TODO styling side chats
              style: GoogleFonts.libreBaskerville(
                wordSpacing: 1,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                fontSize: 21,
                color: Kclr21,
              ),
            )
          ],
        ),
      ),
    );
  }
}
