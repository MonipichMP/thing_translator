import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:thingtranslator/screens/showModel.dart';
import 'package:thingtranslator/widgets_recycle/button.dart';

class PreViewImage extends StatefulWidget {
  final String imagePath;
  final File imageFile;
  final String imageUrl;

  const PreViewImage({Key key, this.imagePath, this.imageFile, this.imageUrl})
      : super(key: key);

  @override
  _PreViewImageState createState() => _PreViewImageState();
}

class _PreViewImageState extends State<PreViewImage> {
  File image;
  String imageLink;
  List<int> imageBytes;
  String imageBase64;
  @override
  void initState() {
    super.initState();
    if (widget.imageFile == null && widget.imageUrl == null) {
      image = File(widget.imagePath);
      imageLink = "";
      imageBytes = image.readAsBytesSync();
      imageBase64 = base64Encode(imageBytes);
    } else if (widget.imagePath == null && widget.imageUrl == null) {
      image = widget.imageFile;
      imageLink = "";
      imageBytes = image.readAsBytesSync();
      imageBase64 = base64Encode(imageBytes);
    } else {
      image = File("");
      imageLink = widget.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text("Preview"),
    );

    final previewContainer = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.contain, image: FileImage(image)),
        ),
      ),
    );

    final previewContainerUrl = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.network(imageLink),
      ),
    );

    final buttonAnalysis = CustomButton(
        title: "Analyze",
        onPressed: () {
          imageLink == ""
              ? Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ShowModel(imageInput: imageBase64, imagePath: image),
                  ),
                )
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowModel(
                      imageUrl: imageLink,
                    ),
                  ),
                );
        });

    final body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        imageLink == "" ? previewContainer : previewContainerUrl,
        SizedBox(height: 55),
        buttonAnalysis
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
