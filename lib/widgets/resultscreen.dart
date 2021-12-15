import 'package:demo_project/theme_color.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  bool? result;

  ResultScreen({this.result});

  @override
  _ResultScreenState createState() => _ResultScreenState(result: result);
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  bool? result;
  late AnimationController controller;
  late Animation<Offset> offset;

  _ResultScreenState({this.result});

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    offset = Tween<Offset>(begin:Offset.zero , end: Offset(0.0, -2.0))
        .animate(controller);
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        controller.forward();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      backgroundColor: ThemeColor.whiteColor,
      body: Container(
        alignment: Alignment.center,
        child: SlideTransition(
          position: offset,
          child: Container(
            width: 130,
            height: 130,
            child: result!
                ? const Icon(
                    Icons.done,
                    size: 100,
                    color: ThemeColor.blue,
                  )
                : const Icon(
                    Icons.close,
              size: 100,
                    color: Colors.red,
                  ),
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: result! ? ThemeColor.lightBlue : ThemeColor.lightOrange,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    ));
  }
}
