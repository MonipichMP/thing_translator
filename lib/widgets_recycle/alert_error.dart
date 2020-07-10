import 'package:flutter/material.dart';
import 'package:thingtranslator/screens/base_screen.dart';
import 'package:thingtranslator/widgets_recycle/button.dart';

class AlertError extends StatefulWidget {
  final String error;

  const AlertError({Key key, this.error}) : super(key: key);

  @override
  _AlertErrorState createState() => _AlertErrorState();
}

class _AlertErrorState extends State<AlertError> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Error"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[Text("Error on ${widget.error}")],
        ),
      ),
      actions: <Widget>[
        Center(
          child: CustomButton(
            title: "Try Again",
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Center(
          child: CustomButton(
            title: "Back Home",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BaseScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
