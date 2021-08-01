import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:true_net/Constants/Colors.dart';
import 'package:true_net/Constants/constUserData.dart';
import 'package:true_net/Screens/SearchScreen.dart';
import 'package:true_net/Screens/chatRoomScreen.dart';
import 'package:true_net/Widget/helperFunctions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("TrueNet"),
      //   centerTitle: true,
      //   backgroundColor: Color(0xffFD0054),
      //   actions: [
      //     DropdownButton(
      //       onChanged: (itemIdentifier) {
      //         if (itemIdentifier == 'logout') {
      //           setState(() {
      //             FirebaseAuth.instance.signOut();
      //             HelperFunctions.saveUserNamePreference("");
      //             HelperFunctions.saveUserEmailPreference("");
      //             HelperFunctions.saveUserImagePreference("");
      //             HelperFunctions.saveUserLoggedInPreference(false);
      //             print("Name: ${Constants.myName}");
      //             print("Email: ${Constants.myEmail}");
      //             print("Image: ${Constants.myImageUrl}");
      //           });
      //         }
      //       },
      //       icon: Icon(
      //         Icons.more_vert,
      //         size: 35,
      //         color: Kclr21,
      //       ),
      //       items: [
      //         DropdownMenuItem(
      //           value: 'logout',
      //           child: Container(
      //             child: Row(
      //               children: [
      //                 Icon(
      //                   Icons.exit_to_app,
      //                   color: Kclr22,
      //                 ),
      //                 SizedBox(
      //                   width: 8,
      //                 ),
      //                 Text(
      //                   'Logout',
      //                   style: TextStyle(fontWeight: FontWeight.bold),
      //                 )
      //               ],
      //             ),
      //           ),
      //         )
      //       ],
      //     )
      //   ],
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       DrawerHeader(
      //         decoration: BoxDecoration(
      //           color: Color(0xffFD0054),
      //         ),
      //         child: Column(
      //           children: [
      //             CircleAvatar(
      //               backgroundColor: Kclr21,
      //               radius: 28,
      //               child: CircleAvatar(
      //                 backgroundImage: NetworkImage(Constants.myImageUrl),
      //                 radius: 25,
      //               ),
      //             ),
      //             Text(Constants.myName),
      //             Text(Constants.myEmail),
      //           ],
      //         ),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.exit_to_app),
      //         title: Text('Logout'),
      //       ),
      //     ],
      //   ),
      // ),
      body: PageView(
          controller: _pageController,
          children: <Widget>[
            ChatRoomScreen(),
            SearchScreen(),
          ],
          onPageChanged: (int index) {
            setState(() {
              _pageController!.jumpToPage(index);
            });
          }),
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeInOutBack,
        index: 0,
        items: <Widget>[
          Icon(Icons.list, size: 35),
          Icon(Icons.search, size: 35),
        ],
        color: Color(0xffFD0054),
        buttonBackgroundColor: Color(0xffFD0054),
        backgroundColor: Kclr21,
        height: 60.0,
        animationDuration: Duration(milliseconds: 800),
        onTap: (int index) {
          setState(() {
            _pageController!.jumpToPage(index);
          });
        },
      ),
    );
  }
}
