import 'package:cng/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageBubble extends StatelessWidget {
  final bool isSender;
  final bool sent;
  final bool delivered;
  final bool seen;
  final String image;
  final Function onPressed;
  const ImageBubble({
    Key key,
    this.isSender = false,
    this.image,
    this.onPressed,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon stateIcon;
    if (sent) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF92DEDA),
      );
    }
    return Align(
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        decoration: BoxDecoration(
          color: isSender ? primaryColor : const Color(0xFFE8E8EE),
          borderRadius: BorderRadius.circular(15.0),
        ),
        height: 180,
        width: 250.0,
        child: Stack(
          children: [
            Container(
              width: 250.0,
              height: 155,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/shapes/placeholder.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 10,
              child: Row(
                children: [
                  Text(
                    "12:30",
                    style: GoogleFonts.lato(
                      color: Colors.grey[500],
                      fontSize: 10.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  stateIcon
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
