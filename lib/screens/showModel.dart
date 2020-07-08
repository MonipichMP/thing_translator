import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import "package:flutter/material.dart";
import 'package:thingtranslator/apis/label_api.dart';
import 'package:thingtranslator/models/label_annotation.dart';

class ShowModel extends StatefulWidget {
  final String imageInput;
  final File imagePath;

  const ShowModel({Key key, this.imageInput, this.imagePath}) : super(key: key);

  @override
  _ShowModelState createState() => _ShowModelState();
}

class _ShowModelState extends State<ShowModel> {
  List<LabelAnnotation> labelList;

// for image url
  Future<List<LabelAnnotation>> getLabelList() async {
    return LabelAnnotationAPI()
        .getLabelListUsingImageUrl(widget.imageInput)
        .then((value) {
      print("data: ${value.data}");
      return labelList = value.data;
    });
  }

// for image base 64
  Future<List<LabelAnnotation>> getLabelListFromImage64() async {
    return LabelAnnotationAPI()
        .getLabelListUsingImageBase64(widget.imageInput)
        .then((value) {
      print("data: ${value.data}");
      return labelList = value.data;
    });
  }

  @override
  void initState() {
    super.initState();
    getLabelList();
    getLabelListFromImage64();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result Analysis'),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
          child: FutureBuilder<List<LabelAnnotation>>(
        future: getLabelListFromImage64(),
        builder: (context, AsyncSnapshot<List<LabelAnnotation>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              var score0 = snapshot.data[0].score * 100;
              var score1 = snapshot.data[1].score * 100;
              var score2 = snapshot.data[2].score * 100;
              // Uint8List decodedImage = base64Decode(widget.imageInput);
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: SafeArea(
                    child: Center(
                  child: Column(
                    children: <Widget>[
                      // Image.network(
                      //   decodedImage,
                      //   width: 350,
                      //   height: 450,
                      // ),
                      Container(
                        width: 350,
                        height: 450,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain, 
                              image: FileImage(widget.imagePath)),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text("Name: ${snapshot.data[0].description}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Confident: ${score0.toInt()} %",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 16),
                      Text("Name: ${snapshot.data[1].description}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Confident: ${score1.toInt()} %",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 16),
                      Text("Name: ${snapshot.data[2].description}",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("Confident: ${score2.toInt()} %",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                )),
              );
            } else {
              print("no data get");
            }
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Dialog(
                child: Container(
                  width: 100,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: AppBar().preferredSize.height,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 16,
                      ),
                      Text("loading")
                    ],
                  ),
                ),
              )),
            );
          }
        },
      )),
    );
  }
}
