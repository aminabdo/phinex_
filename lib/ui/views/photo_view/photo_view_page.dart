import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatelessWidget {
  final String imageUrl;

  const PhotoViewPage({Key key, @required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: PhotoView(
          heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
          backgroundDecoration: BoxDecoration(
            color: Colors.white,
          ),
          imageProvider: CachedNetworkImageProvider(imageUrl),
          enableRotation: true,
        ),
      ),
    );
  }
}
