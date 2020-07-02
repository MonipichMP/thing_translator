import "package:flutter/material.dart";
import 'package:thingtranslator/apis/label_api.dart';
import 'package:thingtranslator/models/label_annotation.dart';

class ShowModel extends StatefulWidget {
  final String imageUrl;

  const ShowModel({Key key, this.imageUrl}) : super(key: key);

  @override
  _ShowModelState createState() => _ShowModelState();
}

class _ShowModelState extends State<ShowModel> {

List<LabelAnnotation> labelList;

Future<List<LabelAnnotation>> getLabelList() async {
    return LabelAnnotationAPI().getLabelAnnotationList(widget.imageUrl).then((value) {
      print("data: ${value.data}");
      return labelList = value.data;
    });

@override
void initState() { 
  super.initState();
   getLabelList();
  }
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
          future: getLabelList(),
          builder: (context, AsyncSnapshot<List<LabelAnnotation>> snapshot) {
            if (snapshot.hasData){
              if(snapshot.data.length > 0) {
                var score0 = snapshot.data[0].score * 100;
                var score1 = snapshot.data[1].score * 100;
                var score2 = snapshot.data[2].score * 100;
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SafeArea(
                    child: Center(
                      child: Column(
                      children: <Widget>[
                        Image.network(
                          widget.imageUrl,
                          width: 300,
                          height: 300,
                        ),
                        SizedBox(height: 16),
                        Text("Name: ${snapshot.data[0].description}",  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("Confident: ${score0.toInt()} %",  style: TextStyle(fontSize: 16)),
                          SizedBox(height: 16),
                        Text("Name: ${snapshot.data[1].description}",  style: TextStyle(fontSize: 16,  fontWeight: FontWeight.bold)),
                        Text("score: ${score1.toInt()} %",  style: TextStyle(fontSize: 16)),
                          SizedBox(height: 16),
                        Text("Name: ${snapshot.data[2].description}",  style: TextStyle(fontSize: 16,  fontWeight: FontWeight.bold)),
                        Text("score: ${score2.toInt()} %",  style: TextStyle(fontSize: 16)),
                      ],
                    ) ,
                    )
                    ),
                );
              } else {
                print("no data get");
              }
            } else {
              return Center(
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
            )
              );
            }
          } ,
        )
      ),
    );
  }
}