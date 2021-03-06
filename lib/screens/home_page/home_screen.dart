import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thingtranslator/screens/home_page/camera_screen.dart';
import 'package:thingtranslator/screens/home_page/preview_picture.dart';
import 'package:thingtranslator/screens/home_page/url_screen.dart';
import 'package:thingtranslator/widgets_recycle/menuCard.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File _image;
  String path;
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
    final _picker = ImagePicker();
    var image = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    var imageFile = File(image.path);
    setState(
      () {
        _image = imageFile;
        path = image.path;
      },
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreViewImage(
          imageFile: _image,
          imagePath: path,
        ),
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
                "Object \nDetector",
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
                "detect_recognize_translate".tr(),
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
                "object_in_only_few_second".tr(),
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
                    title: "take_picture".tr(),
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
                    title: "import_picture".tr(),
                    svgPicture: "assets/images/image.svg",
                    onTap: () {
                      getImageForPreview();
                    },
                  ),
                  MenuCard(
                    title: "url_picture".tr(),
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
                    title: "info".tr(),
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
