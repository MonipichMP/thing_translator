import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  const CustomButton({Key key, @required this.title, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        width: 180,
        height: 50,
        child: RaisedButton(
          padding: EdgeInsets.all(4.0),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Text(title, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}