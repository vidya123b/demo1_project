import 'package:demo_project/theme_color.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  bool? result;

  ResultScreen({Key? key, this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            backgroundColor: ThemeColor.whiteColor,
            body: Container(
              child: result!
                  ? const Icon(
                      Icons.done,
                      size: 200,
                      color: ThemeColor.blue,
                    )
                  : const Icon(
                      Icons.close,
                      size: 200,
                      color: Colors.red,
                    ),
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                color:
                    result! ? ThemeColor.lightBlue : ThemeColor.lightOrange,
                shape: BoxShape.circle,
              ),
            )));
  }
}
