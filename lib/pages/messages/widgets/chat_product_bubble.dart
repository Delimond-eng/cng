import 'dart:convert';

import 'package:cng/components/photo_view.dart';
import 'package:cng/constants/global.dart';
import 'package:cng/constants/style.dart';
import 'package:cng/models/chat_model.dart';
import 'package:cng/pages/messages/widgets/custom_cache_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatSpecialMediaBubble extends StatelessWidget {
  final bool isSender;
  final bool sent;
  final bool delivered;
  final bool seen;
  final Function onPressed;
  final Messages data;
  const ChatSpecialMediaBubble({
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
    return data.produit != null
        ? Align(
            alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                padding: const EdgeInsets.fromLTRB(1.0, 1.0, 1.0, 5.0),
                decoration: BoxDecoration(
                  color: isSender ? Colors.green[300] : Colors.grey,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                width: 250.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 250.0,
                          height: 180.0,
                          padding: const EdgeInsets.only(bottom: 10.0),
                          decoration: BoxDecoration(
                            image: data.produit.produitImage != null &&
                                    data.produit.produitImage.length < 200
                                ? const DecorationImage(
                                    image: AssetImage(
                                        "assets/shapes/placeholder.png"),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: CacheImageProvider(
                                      img: base64Decode(
                                          data.produit.produitImage),
                                      tag: data.messageId,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15.0),
                            ),
                          ),
                          child: Material(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15.0),
                            ),
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15.0),
                              ),
                              onTap: () {
                                if (data.produit.produitImage != null &&
                                    data.produit.produitImage.length > 200) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PhotoViewer(
                                        tag: data.messageId,
                                        image: data.produit.produitImage,
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
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isSender
                                    ? [
                                        Colors.transparent,
                                        Colors.green[300].withOpacity(.5),
                                        Colors.green[300].withOpacity(.7),
                                        Colors.green[300],
                                      ]
                                    : [
                                        Colors.transparent,
                                        Colors.grey.withOpacity(.3),
                                        Colors.grey.withOpacity(.7),
                                        Colors.grey,
                                      ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        data.produit.produitTitre,
                                        style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 18.0,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Colors.black.withOpacity(.4),
                                              blurRadius: 2,
                                              offset: const Offset(0, 1),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: RichText(
                                        text: TextSpan(
                                            text:
                                                "${data.produit.produitPrix}  ",
                                            style: GoogleFonts.lato(
                                              color: accentColor,
                                              fontWeight: FontWeight.w900,
                                              fontSize: 16.0,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withOpacity(.4),
                                                  blurRadius: 2,
                                                  offset: const Offset(0, 1),
                                                )
                                              ],
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    data.produit.produitDevise,
                                                style: GoogleFonts.lato(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 10.0,
                                                ),
                                              )
                                            ]),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
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
            ),
          )
        : Align(
            alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                child: Stack(
                  children: [
                    Container(
                      width: 250.0,
                      height: 180,
                      decoration: BoxDecoration(
                        color: isSender ? Colors.green[100] : Colors.grey[300],
                        image: data.media != null && data.media.length < 200
                            ? const DecorationImage(
                                image:
                                    AssetImage("assets/shapes/placeholder.png"),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                              )
                            : DecorationImage(
                                image: CacheImageProvider(
                                    img: base64Decode(data.media),
                                    tag: data.messageId),
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
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
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(15.0)),
                          gradient: LinearGradient(
                            colors: isSender
                                ? [
                                    Colors.transparent,
                                    Colors.green[300].withOpacity(.5),
                                    Colors.green[300].withOpacity(.8),
                                  ]
                                : [
                                    Colors.transparent,
                                    Colors.grey.withOpacity(.5),
                                    Colors.grey.withOpacity(.8),
                                  ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
