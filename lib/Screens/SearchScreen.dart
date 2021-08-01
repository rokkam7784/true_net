import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_net/Constants/Colors.dart';
import 'package:true_net/Constants/constUserData.dart';
import 'package:true_net/Widget/database.dart';
import 'chatRoomScreen.dart';
import 'conversationScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _page = 1;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  DatabaseMethods databaseMethods = new DatabaseMethods();

  var _serchedUsername = '';

  QuerySnapshot? searchSnapshot;

  initiateSearch() {
    databaseMethods.getUserByUsername(_serchedUsername).then((value) {
      setState(() {
        searchSnapshot = value;
      });
    });
  }

  Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return searchTile(
                userName: searchSnapshot!.docs[index]["username"],
                userEmail: searchSnapshot!.docs[index]["email"],
                userImage: searchSnapshot!.docs[index]["image_url"],
              );
            })
        : Container();
  }

  createChatRoomAndStartConversation({
    // required BuildContext context,
    required String username,
    required String userImage,
  }) {
    print("Constants.myName: ${Constants.myName}");
    if (username != Constants.myName) {
      String chatRoomId = getChatRoomId(username, Constants.myName);

      List<String> users = [
        username,
        // userImage,
        Constants.myName,
        // Constants.myImageUrl
      ];

      Map<String, dynamic> chatRoomMap = {
        "users": users,
        "chatRoomId": chatRoomId,
        "chatRoomUser1": username,
        "chatRoomUser2": Constants.myName,
        "chatRoomImage1": userImage,
        "chatRoomImage2": Constants.myImageUrl,
      };

      DatabaseMethods().createChatRoom(chatRoomId, chatRoomMap);
      print("chatRoomId: ${chatRoomId.toString()}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConversationScreen(
                    // chatRoomId,
                    // username,
                    // userImage,
                    chatRoomId: chatRoomId,
                    userImage: userImage,
                    username: username,
                  ))); //todo add image
    } else {
      print("cant send msg to yourself");
    }
  }

  Widget searchTile({
    required String userName,
    required String userEmail,
    required String userImage,
  }) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 13),
        decoration: BoxDecoration(
          color: Kclr01,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 33,
              backgroundColor: Kclr21,
              child: CircleAvatar(
                backgroundColor: Kclr22,
                radius: 29.5,
                backgroundImage: NetworkImage(userImage),
              ),
            ),
            SizedBox(width: 7),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  //TODO styling SearchTile
                  style: GoogleFonts.libreBaskerville(
                    // wordSpacing: 1,
                    // letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Kclr21,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  userEmail,
                  //TODO styling Logout text
                  style: GoogleFonts.libreBaskerville(
                    // wordSpacing: 1,
                    // letterSpacing: 1,
                    // fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Kclr21,
                  ),
                )
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                createChatRoomAndStartConversation(
                    // context: context,
                    username: userName,
                    userImage: userImage);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xffFD0054),
                    borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Message",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kclr21,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Search Users",
          style: GoogleFonts.alegreyaSc(
            // wordSpacing: 1,
            // letterSpacing: 1,
            fontWeight: FontWeight.bold,
            fontSize: 27,
            color: Kclr21,
          ),
        ),
        backgroundColor: Color(0xffFD0054),
      ),
      // bottomNavigationBar: CurvedNavigationBar(
      //   index: 1,
      //   height: 60.0,
      //   items: <Widget>[
      //     Icon(Icons.list, size: 30),
      //     Icon(Icons.search, size: 30),
      //   ],
      //   color: Color(0xffFD0054),
      //   buttonBackgroundColor: Color(0xffFD0054),
      //   backgroundColor: Kclr21,
      //   animationCurve: Curves.easeInOut,
      //   animationDuration: Duration(milliseconds: 1000),
      //   onTap: (index) {
      //     setState(() {
      //       // ChatRoomScreen();
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (context) => ChatRoomScreen()));
      //     });
      //   },
      // ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(7),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      // color: Color(0xffe63c53),
                      gradient: LinearGradient(colors: [
                        // const Color(0xffe63c53),
                        // const Color(0xffe63c53),
                        // const Color(0xffeb6577),

                        // const Color(0xffF1BC31),
                        // const Color(0xffF1BC31),
                        // const Color(0xffFFD369),
                        // const Color(0xffF9E090),
                        // const Color(0xffF2EEE0),

                        // Color(0xff480032),
                        Color(0xffDF0054),
                        // Color(0xffDF0054),
                        Color(0xffFF8B6A),

                        Color(0xffFFD6C2),
                      ])),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                              color: Kclr21, fontSize: 20, letterSpacing: 1),
                          decoration: InputDecoration(
                            labelText: "Enter Username .....",
                            labelStyle:
                                new TextStyle(color: Kclr21, fontSize: 20),
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
                                _serchedUsername = value;
                              },
                            );
                          },
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Kclr22,
                        radius: 27,
                        child: IconButton(
                          // onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
                          onPressed: () {
                            initiateSearch();
                          },
                          icon: Icon(
                            Icons.search,
                            size: 35,
                          ),
                          color: Kclr21,
                        ),
                      ),
                      SizedBox(
                        width: 13,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          searchList(),
        ],
      ),
    );
  }
}

getChatRoomId(String a, String b) {
  if (a.substring(0, 1).codeUnits[0] > b.substring(0, 1).codeUnits[0]) {
    return "$b\_$a";
  } else {
    return "$a\_$b";
  }
}
