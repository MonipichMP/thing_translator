import 'dart:io';

import "package:flutter/material.dart";
import 'package:thingtranslator/apis/label_api.dart';
import 'package:thingtranslator/home_page.dart';
import 'package:thingtranslator/models/label_annotation.dart';
import 'package:thingtranslator/widgets_recycle/button.dart';

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
    // getLabelList();
    getLabelListFromImage64();
  }

  @override
  Widget build(BuildContext context) {
    final buttonBackToHome = CustomButton(
        title: "Back Home Screen",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        });
        
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Result Analysis'),
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
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SafeArea(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: FileImage(widget.imagePath)),
                            ),
                          ),
                          SizedBox(height: 14),
                          Text("Name: ${snapshot.data[0].description}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Confident: ${score0.toInt()} %",
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 14),
                          Text("Name: ${snapshot.data[1].description}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Confident: ${score1.toInt()} %",
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 14),
                          Text("Name: ${snapshot.data[2].description}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Confident: ${score2.toInt()} %",
                              style: TextStyle(fontSize: 16)),
                          SizedBox(height: 30),
                          buttonBackToHome,
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: AlertDialog(
                    title: Text("Error"),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[Text("Error on Getting Data")],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Try Again"))
                    ],
                  ),
                );
              }
            } else {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Dialog(
                  child: Container(
                    width: 150,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    height: 70,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
