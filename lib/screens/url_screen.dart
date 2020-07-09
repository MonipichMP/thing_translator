import 'package:flutter/material.dart';
import 'package:thingtranslator/screens/preview_picture.dart';
import 'package:thingtranslator/widgets_recycle/button.dart';

class UrlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final value = TextEditingController();

    final body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(29.5),
            ),
            child: TextField(
              controller: value,
              decoration: InputDecoration(
                hintText: "input link of image",
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
              title: "Preview",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreViewImage(imageUrl: value.text),
                  ),
                );
              }),
        )
      ],
    );

    return Scaffold(
      body: body,
    );
  }
}
