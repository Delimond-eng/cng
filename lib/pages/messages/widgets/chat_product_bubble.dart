import 'dart:convert';

import 'package:cng/components/photo_view.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/constants/style.dart';
import 'package:cng/models/chat_model.dart';
import 'package:cng/pages/messages/widgets/custom_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatProductBubble extends StatelessWidget {
  final bool isSender;
  final bool sent;
  final bool delivered;
  final bool seen;
  final Function onPressed;
  final Messages data;
  const ChatProductBubble({
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
    Icon stateIcon;
    if (sent) {
      stateIcon = const Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF92DEDA),
      );
    }
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSender) ...[
              Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  shape: BoxShape.circle,
                ),
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
            ],
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 5.0,
              ),
              padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 10),
              decoration: BoxDecoration(
                color: isSender ? darkBlueColor : Colors.grey,
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: 250.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 250.0,
                    height: 180.0,
                    padding: const EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      image: data.produit.produitImage != null &&
                              data.produit.produitImage.length < 200
                          ? const DecorationImage(
                              image:
                                  AssetImage("assets/shapes/placeholder.png"),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: CacheImageProvider(
                                img: base64Decode(data.produit.produitImage),
                                tag: data.messageId,
                              ),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data.message,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              msgDate(data.dateEnregistrement.trim()),
                              style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
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
            if (!isSender) ...[
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
            ]
          ],
        ),
      ),
    );
  }
}
