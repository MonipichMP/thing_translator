import 'dart:io';

import "package:flutter/material.dart";
import 'package:thingtranslator/apis/label_api.dart';
import 'package:thingtranslator/apis/translate_api.dart';
import 'package:thingtranslator/models/label_annotation.dart';
import 'package:thingtranslator/screens/base_screen.dart';
import 'package:thingtranslator/widgets_recycle/alert_error.dart';
import 'package:thingtranslator/widgets_recycle/button.dart';
import 'package:thingtranslator/widgets_recycle/display_result.dart';

class ShowModel extends StatefulWidget {
  final String imageInput;
  final File imagePath;
  final String imageUrl;

  const ShowModel({Key key, this.imageInput, this.imagePath, this.imageUrl})
      : super(key: key);

  @override
  _ShowModelState createState() => _ShowModelState();
}

class _ShowModelState extends State<ShowModel> {
  List<LabelAnnotation> labelList;
  var translateWord;

// for image url
  Future<List<LabelAnnotation>> getLabelList() async {
    return LabelAnnotationAPI()
        .getLabelListUsingImageUrl(widget.imageUrl)
        .then((value) {
      // print("url data: ${value.data}");
      return labelList = value.data;
    });
  }

// for image base 64
  Future<List<LabelAnnotation>> getLabelListFromImage64() async {
    return LabelAnnotationAPI()
        .getLabelListUsingImageBase64(widget.imageInput)
        .then((value) {
      // print("path data: ${value.data}");
      // print("imag64: ${widget.imageInput}");
      return labelList = value.data;
    });
  }

  // translate
  Future<String> getTranslateData(String text) async {
    return TranslateAPI().getTranslateText(text).then((value) {
      // print("get: ${value.translatedText}");
      return translateWord = value.translatedText;
    });
  }

  @override
  void initState() {
    super.initState();
    getLabelList();
    getLabelListFromImage64();
    // getTranslateData();
  }

  @override
  Widget build(BuildContext context) {
    final buttonBackToHome = CustomButton(
        title: "Back Home Screen",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BaseScreen(),
            ),
          );
        });

    final previewImagePath = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image:
              FileImage(widget.imagePath == null ? File("") : widget.imagePath),
        ),
      ),
    );
    final previewContainerUrl = Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.4,
        child: Image.network(widget.imageUrl == null ? "" : widget.imageUrl),
      ),
    );

    final loadingWidget = Container(
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

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Result Analysis'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List<LabelAnnotation>>(
          future: widget.imageUrl == null
              ? getLabelListFromImage64()
              : getLabelList(),
          builder: (context, AsyncSnapshot<List<LabelAnnotation>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                var score0 = snapshot.data[0].score * 100;
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        widget.imageUrl == null
                            ? previewImagePath
                            : previewContainerUrl,
                        SizedBox(height: 24),
                        DisplayResult(
                          nameText: "Name:",
                          text: snapshot.data[0].description,
                          nameScore: "Confident score:",
                          score: score0,
                          svgPicture: "assets/images/flaguk.svg",
                        ),
                        SizedBox(height: 14),
                        FutureBuilder(
                          future: getTranslateData(
                            snapshot.data[0].description,
                          ),
                          builder: (context, AsyncSnapshot<String> snap) {
                            if (snap.hasData) {
                              return DisplayResult(
                                nameText: "ឈ្មោះ:",
                                text: snap.data,
                                score: score0,
                                nameScore: "កម្រិតប៉ាន់ស្មាន:",
                                svgPicture: "assets/images/flagcam.svg",
                              );
                            } else if (snap.hasError) {
                              return DisplayResult(
                                nameText: "",
                                text: "បកប្រែមានបញ្ហា",
                                score: score0,
                                nameScore: "កម្រិតប៉ាន់ស្មាន:",
                              );
                            } else {
                              return DisplayResult(
                                nameText: "ឈ្មោះ: ",
                                text: "",
                                score: score0,
                                nameScore: "កម្រិតប៉ាន់ស្មាន:",
                                svgPicture: "assets/images/flagcam.svg",
                              );
                            }
                          },
                        ),
                        SizedBox(height: 30),
                        buttonBackToHome,
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: Text("No data"));
              }
            } else if (snapshot.hasError) {
              return Column(
                children: <Widget>[
                  Center(
                    child: AlertError(
                      error: snapshot.error,
                    ),
                  ),
                ],
              );
            } else {
              return loadingWidget;
            }
          },
        ),
      ),
    );
  }
}
