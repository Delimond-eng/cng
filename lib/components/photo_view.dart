import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  final String image;
  final String tag;
  const PhotoViewer({Key key, this.image, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Hero(
              tag: tag,
              child: Container(
                child: PhotoView(
                  imageProvider: MemoryImage(base64Decode(image)),
                ),
              ),
            ),
            Positioned(
              top: 15.0,
              left: 10.0,
              child: Container(
                height: 40.0,
                width: 60.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20.0),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: SvgPicture.asset(
                          "assets/shapes/back-svgrepo-com.svg",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
