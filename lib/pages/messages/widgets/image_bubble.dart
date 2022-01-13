import 'dart:convert';

import 'package:cng/components/photo_view.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/constants/style.dart';
import 'package:cng/models/chat_model.dart';
import 'package:cng/pages/messages/widgets/custom_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageBubble extends StatelessWidget {
  final bool isSender;
  final bool sent;
  final bool delivered;
  final bool seen;
  final Function onPressed;
  final Messages data;
  const ImageBubble({
    Key key,
    this.isSender = false,
    this.onPressed,
    this.sent = false,
    this.delivered = false,
    this.seen = false,
    this.data,
  }) : super(key: key);

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
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 5.0,
        ),
        padding: const EdgeInsets.all(1),
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
                image: data.media != null && data.media.length < 200
                    ? const DecorationImage(
                        image: AssetImage("assets/shapes/placeholder.png"),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: CacheImageProvider(
                            img: base64Decode(data.media), tag: data.messageId),
                        fit: BoxFit.cover,
                      ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15.0),
                  onTap: () {
                    if (data.media.length > 200) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoViewer(
                            tag: data.messageId,
                            image: data.media,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 10,
              child: Row(
                children: [
                  Text(
                    msgDate(data.dateEnregistrement.trim()),
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
