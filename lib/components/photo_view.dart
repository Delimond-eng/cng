import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends StatelessWidget {
  final String image;
  final String tag;
  const PhotoViewer({Key key, this.image, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(
        child: PhotoView(
          imageProvider: MemoryImage(base64Decode(image)),
        ),
      ),
    );
  }
}
