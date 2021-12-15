import 'package:demo_project/widgets/mainscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultScreenNotifier extends ChangeNotifier {
  late AnimationController controller;
  late Animation<Offset> offset;
  late BuildContext context;
  bool showListOfOptions = false;

  ResultScreenNotifier(this.controller, this.context);

  init() {
    offset = Tween<Offset>(begin: Offset.zero, end: const Offset(0.0, -0.2))
        .animate(controller);
    Future.delayed(const Duration(milliseconds: 500), () {
      controller.forward();
      notifyListeners();
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      showListOfOptions = true;
      notifyListeners();
    });
    Future.delayed(const Duration(milliseconds: 6000), () {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const MainScreen(),
      ));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
