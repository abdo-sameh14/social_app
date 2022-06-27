import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class OpenImageScreen extends StatelessWidget {
  String? image;

  OpenImageScreen({this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: defaultAppBar(
        context: context,
        backgroundColor: Colors.black,
        leadingIconColor: Colors.white,
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light
      ),
      body: PhotoView(
        imageProvider: NetworkImage(image!),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.contained *4,
      ),
    );
  }
}
