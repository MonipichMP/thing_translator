import 'package:flutter/material.dart';
import 'package:thingtranslator/screens/home_page/preview_picture.dart';
import 'package:thingtranslator/widgets_recycle/button.dart';
import 'package:easy_localization/easy_localization.dart';

class UrlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = TextEditingController();

    final body = SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Image(
            image: AssetImage("assets/images/logo.png"),
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 30),
          Text(
            "Object Detection using cloud vision",
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(height: 20),
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
                  hintText: "input_link_image".tr(),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
                title: "preview".tr(),
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
      ),
    );

    return Scaffold(
      body: body,
    );
  }
}
