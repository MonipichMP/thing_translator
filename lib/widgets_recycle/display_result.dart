import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DisplayResult extends StatefulWidget {
  final String text;
  final String nameText;
  final String score;
  final String nameScore;
  final String svgPicture;

  const DisplayResult(
      {Key key,
      this.text,
      this.score,
      this.nameText,
      this.nameScore,
      this.svgPicture})
      : super(key: key);

  @override
  _DisplayResultState createState() => _DisplayResultState();
}

class _DisplayResultState extends State<DisplayResult> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "${widget.nameText}",
                style: TextStyle(fontSize: 22),
              ),
              Container(
                width: 20,
                height: 20,
                child: SvgPicture.asset(
                  widget.svgPicture,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                " ${widget.text}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                "${widget.nameScore}",
                style: TextStyle(fontSize: 22),
              ),
              Text(
                "${widget.score} %",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
