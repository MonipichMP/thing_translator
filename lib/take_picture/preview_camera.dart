import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:thingtranslator/screens/showModel.dart';

class PreviewImageScreen extends StatefulWidget {
  final String imagePath;

  PreviewImageScreen({this.imagePath});

  @override
  _PreviewImageScreenState createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {

  @override
  Widget build(BuildContext context) {
    
    var image = File(widget.imagePath);
    List<int> imageBytes = image.readAsBytesSync();
    String imageBase64 = base64Encode(imageBytes);

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
            // value.text
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShowModel(imageInput: imageBase64, imagePath: image,),
              ),
            );
          },
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Text("Analyze", style: TextStyle(fontSize: 16)),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Preview'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Image.file(File(widget.imagePath), fit: BoxFit.contain)),
            SizedBox(height: 10.0),
            buttonCheckScore,
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(60.0),
                child: RaisedButton(
                  onPressed: () {
                    getBytesFromFile().then((bytes) {
                      Share.file('Share via:', basename(widget.imagePath),
                          bytes.buffer.asUint8List(), 'image/png');
                    });
                  },
                  child: Text('Share'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ByteData> getBytesFromFile() async {
    Uint8List bytes = File(widget.imagePath).readAsBytesSync() as Uint8List;
    return ByteData.view(bytes.buffer);
  }
}
