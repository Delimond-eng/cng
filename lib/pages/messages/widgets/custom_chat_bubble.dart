import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cng/constants/style.dart';
import 'package:cng/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomChatBubble extends StatelessWidget {
  final bool isSender;
  final String text;
  final Messages data;
  final bool tail;
  final Color color;
  final bool sent;
  final bool delivered;
  final bool seen;
  final TextStyle textStyle;
  final String time;

  const CustomChatBubble({
    Key key,
    this.isSender = true,
    this.text,
    this.color = Colors.white70,
    this.tail = true,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
    this.time,
    this.data,
  }) : super(key: key);

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon stateIcon;
    if (sent) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF92DEDA),
      );
    }

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            if (isSender) ...[
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                    color: Colors.green[700], shape: BoxShape.circle),
                child: Center(
                  child: Text(
                    "Moi",
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
            ],
            CustomPaint(
              painter: SpecialChatBubbleOne(
                color: color,
                alignment: isSender ? Alignment.topRight : Alignment.topLeft,
                tail: tail,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .7,
                ),
                margin: isSender
                    ? stateTick
                        ? const EdgeInsets.fromLTRB(7, 7, 14, 7)
                        : const EdgeInsets.fromLTRB(7, 7, 17, 7)
                    : const EdgeInsets.fromLTRB(17, 7, 7, 7),
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: stateTick
                          ? const EdgeInsets.only(right: 55)
                          : const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 0),
                      child: Text(
                        text,
                        style: textStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    stateIcon != null && stateTick
                        ? Positioned(
                            bottom: 0,
                            right: 0,
                            child: Row(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_filled_outlined,
                                      size: 12.0,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      time,
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                stateIcon
                              ],
                            ),
                          )
                        : const SizedBox(
                            width: 1,
                          ),
                  ],
                ),
              ),
            ),
            if (!isSender) ...[
              const SizedBox(
                width: 10.0,
              ),
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: accentColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    data.nom.substring(0, 1).toUpperCase(),
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
