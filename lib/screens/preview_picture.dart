import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thingtranslator/screens/showModel.dart';
import 'package:thingtranslator/widgets_recycle/button.dart';

class PreViewImage extends StatefulWidget {
  final String imagePath;
  final File imageFile;

  const PreViewImage({Key key, this.imagePath, this.imageFile})
      : super(key: key);

  @override
  _PreViewImageState createState() => _PreViewImageState();
}

class _PreViewImageState extends State<PreViewImage> {
  @override
  Widget build(BuildContext context) {
    File image;
    if (widget.imageFile == null) {
      image = File(widget.imagePath);
    } else {
      image = widget.imageFile;
    }

    List<int> imageBytes = image.readAsBytesSync();
    String imageBase64 = base64Encode(imageBytes);

    final appBar = AppBar(
      title: Text("Preview"),
    );

    final previewContainer = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain, image: FileImage(image)),
        ),
      ),
    );

    final buttonAnalysis = CustomButton(
        title: "Analyze",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ShowModel(
                imageInput: imageBase64,
                imagePath: image,
              ),
            ),
          );
        });

    final body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        previewContainer,
        SizedBox(height: 15),
        buttonAnalysis
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
