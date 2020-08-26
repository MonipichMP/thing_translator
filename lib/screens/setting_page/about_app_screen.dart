import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15),
            Text(
              "Object Detection using cloud vision",
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 15),
            Image(
              image: AssetImage("assets/images/logo.png"),
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 10),
            Text(
              "Version 1.0.0",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            Text(
              "This app can detect objects around you by spending only few seconds just open"
              "your camera and take a picture of it then click on 'Analyze' to let it "
              "detect that object and show you the result with translation to Khmer language also.",
              style: TextStyle(fontSize: 16),
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}
