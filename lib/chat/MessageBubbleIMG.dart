import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_net/Constants/Colors.dart';

class MessageBubbleIMG extends StatelessWidget {
  MessageBubbleIMG(
    this.message,
    this.userName,
    this.userImage,
    this.isMe, {
    required this.key,
  });
  final Key key;
  final String message;
  final bool isMe;
  final String userName;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              padding: isMe
                  ? EdgeInsets.only(left: 80, right: 8)
                  : EdgeInsets.only(left: 8, right: 80),
              margin: EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 0,
              ),
              width: MediaQuery.of(context).size.width,
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                // alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                // width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 0,
                ),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                // color: isMe ? Kclr01 : Color(0xffFD0054),
                decoration: isMe
                    ? BoxDecoration(
                        // color: isMe ? Kclr01 : Color(0xffFD0054),
                        gradient: LinearGradient(
                            end: isMe
                                ? Alignment.topRight
                                : Alignment.bottomLeft,
                            begin: isMe
                                ? Alignment.bottomLeft
                                : Alignment.topRight,
                            colors: [
                              Color(0xffd81b60),
                              Kclr01,
                              Kclr01,
                              Kclr01,
                              // Colors.black,
                              Color(0xff424242),
                            ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: isMe ? Radius.circular(12) : Radius.zero,
                          bottomRight: isMe ? Radius.zero : Radius.circular(12),
                        ),
                      )
                    : BoxDecoration(
                        // color: isMe ? Kclr01 : Color(0xffFD0054),
                        gradient: LinearGradient(
                            end: isMe
                                ? Alignment.topRight
                                : Alignment.bottomLeft,
                            begin: isMe
                                ? Alignment.bottomLeft
                                : Alignment.topRight,
                            colors: [
                              Kclr01,
                              Color(0xffFD0054),
                              Color(0xffd81b60),
                            ]),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: isMe ? Radius.circular(12) : Radius.zero,
                          bottomRight: isMe ? Radius.zero : Radius.circular(12),
                        ),
                      ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    isMe
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                userName,
                                textAlign:
                                    isMe ? TextAlign.end : TextAlign.start,
                                //TODO styling username of text
                                style: GoogleFonts.libreBaskerville(
                                  // wordSpacing: 1,
                                  // letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Kclr21,
                                ),
                              ),
                              SizedBox(
                                width: 33,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 33,
                              ),
                              Text(
                                userName,
                                textAlign:
                                    isMe ? TextAlign.end : TextAlign.start,
                                //TODO styling username of text
                                style: GoogleFonts.libreBaskerville(
                                  // wordSpacing: 1,
                                  // letterSpacing: 1,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Kclr21,
                                ),
                              ),
                            ],
                          ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      message,
                      textAlign: isMe ? TextAlign.right : TextAlign.left,
                      //TODO styling message of text
                      style: GoogleFonts.libreBaskerville(
                        // wordSpacing: 1,
                        // letterSpacing: 1,
                        // fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: isMe ? Colors.pink[800] : Colors.grey[950],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        Positioned(
          top: -2,
          left: isMe ? null : MediaQuery.of(context).size.width * .01,
          right: isMe ? MediaQuery.of(context).size.width * .01 : null,
          child: CircleAvatar(
            radius: 24,
            backgroundColor: Kclr21,
            child: CircleAvatar(
              backgroundColor: Kclr22,
              radius: 21,
              backgroundImage: NetworkImage(userImage),
            ),
          ),
        )
      ],
    );
  }
}
