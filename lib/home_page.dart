import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thingtranslator/screens/showModel.dart';
import 'package:thingtranslator/take_picture/camera_screen.dart';

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

    _controller = CameraController(firstCamera,ResolutionPreset.high);

    _initializeControllerFuture = _controller.initialize();

    if (!mounted) {
      return;
    }
    setState(() {
      isCameraReady = true;
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(
          () {
        _image = image;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      centerTitle: true,
      title: Text("Thing Translator"),
    );

    final buttonTakeCamera = Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: 180,
        height: 50,
        child: RaisedButton(
          padding: EdgeInsets.all(4.0),
          textColor: Colors.white,
          color: Color(0xff0072BB),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CameraScreen(),
              ),
            );
          },
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: new Text("Take Camera", style: TextStyle(fontSize: 16)),
        ),
      ),
    );

    final buttonImport = Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: 180,
        height: 50,
        child: RaisedButton(
          padding: EdgeInsets.all(4.0),
          textColor: Colors.white,
          color: Color(0xff0072BB),
          onPressed: () {
            getImage();
          },
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: new Text("Import From Gallery", style: TextStyle(fontSize: 16)),
        ),
      ),
    );

final buttonCheckScore = Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: 180,
        height: 50,
        child: RaisedButton(
          padding: EdgeInsets.all(4.0),
          textColor: Colors.white,
          color: Color(0xff0072BB),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowModel(imageUrl: value.text,),
              ),
            );
          },
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: new Text("Analyze", style: TextStyle(fontSize: 16)),
        ),
      ),
    );

    final body = SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("To use this app, you need to take a picture or import picture from gallery or input link image to analyze!",
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
            children: <Widget>[
              buttonTakeCamera,
              buttonImport
            ],
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
              buttonCheckScore,   
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.all(5.0),
            child:  _image != null ? Container(
              width: 350,
              height: 450,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill, image: FileImage(_image)),
              ),
            ) : null,
          )
        ],
      ),
    );


    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

}
