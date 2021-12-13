import 'package:demo_project/theme_color.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  bool? result;

  ResultScreen({this.result});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            backgroundColor: ThemeColor.whiteColor,
            body: Container(
              child: result!
                  ? Icon(
                      Icons.done,
                      size: 200,
                      color: ThemeColor.blue,
                    )
                  : Icon(
                      Icons.close,
                      size: 200,
                      color: Colors.red,
                    ),
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 20, right: 20),
              decoration: new BoxDecoration(
                color:
                    result! ? ThemeColor.light_blue : ThemeColor.light_orange,
                shape: BoxShape.circle,
              ),
            )));
  }
}
