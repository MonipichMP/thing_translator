import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thingtranslator/screens/camera_screen.dart';
import 'package:thingtranslator/screens/preview_picture.dart';
import 'package:thingtranslator/screens/url_screen.dart';
import 'package:thingtranslator/widgets_recycle/menuCard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File _image;
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool isCameraReady = false;
  bool showCapturedPhoto = false;
  TextEditingController value = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(firstCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();

    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  Future getImageForPreview() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery) ;
    setState(
      () {
        _image = imageFile;
      },
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreViewImage(imageFile: _image),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundContainer = Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );

    final foregroundContainer = SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Things \nTranslator",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 34,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Recognize and translate",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Things in only few seconds",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: <Widget>[
                  MenuCard(
                    title: "Take Picture",
                    svgPicture: "assets/images/cam.svg",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CameraScreen(),
                        ),
                      );
                    },
                  ),
                  MenuCard(
                    title: "Import Picture",
                    svgPicture: "assets/images/image.svg",
                    onTap: () {
                      getImageForPreview();
                    },
                  ),
                  MenuCard(
                    title: "Url Picture",
                    svgPicture: "assets/images/web.svg",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UrlScreen(),
                        ),
                      );
                    },
                  ),
                  MenuCard(
                    title: "Information",
                    svgPicture: "assets/images/info.svg",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    final body = Stack(
      children: <Widget>[
        backgroundContainer,
        foregroundContainer,
      ],
    );

    return body;
  }
}
