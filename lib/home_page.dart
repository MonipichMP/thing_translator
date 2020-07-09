import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thingtranslator/screens/preview_picture.dart';
import 'package:thingtranslator/take_picture/camera_screen.dart';
import 'package:thingtranslator/widgets_recycle/button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  Future getImage() async {
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
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
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text("Thing Translator"),
    );

    final buttonTakeCamera = CustomButton(
        title: "Take Camera",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CameraScreen(),
            ),
          );
        });

    final buttonImport = CustomButton(
        title: "Import From Gallery",
        onPressed: () {
          getImage();
        });

    final body = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "To use this app, you need to take a picture or import picture from gallery or input link image to analyze!",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[buttonTakeCamera, buttonImport],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: value,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Please input image URL',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
