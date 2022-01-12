import 'package:cng/constants/global.dart';
import 'package:cng/constants/style.dart';
import 'package:cng/models/chat_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatCard extends StatelessWidget {
  final Chats data;
  final Function onPressed;
  const ChatCard({
    Key key,
    this.onPressed,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.8),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Colors.black.withOpacity(.1),
            offset: const Offset(0.0, 10.0),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(20.0),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(.5),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12.0,
                            color: Colors.black.withOpacity(.1),
                            offset: const Offset(0.0, 10.0),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          data.users
                              .firstWhere((e) =>
                                  e.userId != storage.read("userid").toString())
                              .nom
                              .substring(0, 1)
                              .toUpperCase(),
                          style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 0,
                      child: Container(
                        height: 13.0,
                        width: 13.0,
                        decoration: BoxDecoration(
                          color: Colors.yellow[900],
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.users
                          .firstWhere((e) =>
                              e.userId != storage.read("userid").toString())
                          .nom,
                      style: GoogleFonts.lato(
                        color: darkBlueColor,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.0,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    if (data.messages.last.media == null) ...[
                      Text(
                        truncateStringWithPoint(data.messages.last.message, 25),
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                      )
                    ] else ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.photo_fill,
                            size: 17.0,
                            color: accentColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Photo",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                            ),
                          )
                        ],
                      ),
                    ],
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
