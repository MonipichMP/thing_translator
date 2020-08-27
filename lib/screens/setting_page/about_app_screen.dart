import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AboutAppScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("about_app".tr()),
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
              "version".tr(),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            Text(
              "description_at_about_app".tr(),
              style: TextStyle(fontSize: 16),
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}
