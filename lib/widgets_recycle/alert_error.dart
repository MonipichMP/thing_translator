import 'package:flutter/material.dart';
import 'package:thingtranslator/screens/base_screen.dart';
import 'package:thingtranslator/widgets_recycle/button.dart';
import 'package:easy_localization/easy_localization.dart';

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
      title: Text("error".tr()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[

            Row(
              children: <Widget>[
                Text(
                  "error_on".tr(),
                ),
                Text(
                  "${widget.error}",
                ),
              ],
            )
          ],
        ),
      ),
      actions: <Widget>[
        Center(
          child: CustomButton(
            title: "try_again".tr(),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Center(
          child: CustomButton(
            title: "back_home".tr(),
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
