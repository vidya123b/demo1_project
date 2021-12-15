import 'package:demo_project/models/question_data_model.dart';
import 'package:demo_project/notifiers/resultscreen_notifier.dart';
import 'package:demo_project/theme_color.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ResultScreen extends StatefulWidget {
  bool? result;
  List<OptionDataViewModel>? options;

  ResultScreen({Key? key, this.result, this.options}) : super(key: key);

  @override
  _ResultScreenState createState() =>
      _ResultScreenState(result: result, options: options);
}

class _ResultScreenState extends State<ResultScreen>
    with SingleTickerProviderStateMixin {
  bool? result;
  late AnimationController controller;
  late ResultScreenNotifier _resultScreenNotifier;
  List<OptionDataViewModel>? options;

  _ResultScreenState({this.result, required this.options});

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _resultScreenNotifier = ResultScreenNotifier(controller,context);
    _resultScreenNotifier.init();
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
        child: ChangeNotifierProvider(
            create: (context) => _resultScreenNotifier,
            child: Consumer<ResultScreenNotifier>(
              builder: (context, notifier, child) => Scaffold(
                backgroundColor: ThemeColor.whiteColor,
                body: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: SlideTransition(
                              position: _resultScreenNotifier.offset,
                              child: Container(
                                width: 100,
                                height: 100,
                                child: result!
                                    ? const Icon(
                                        Icons.done,
                                        size: 70,
                                        color: ThemeColor.blue,
                                      )
                                    : const Icon(
                                        Icons.close,
                                        size: 70,
                                        color: Colors.red,
                                      ),
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: result!
                                      ? ThemeColor.lightBlue
                                      : ThemeColor.lightOrange,
                                  shape: BoxShape.circle,
                                ),
                              ))),
                     Visibility(child:  Column(
                          children: options!
                              .asMap()
                              .entries
                              .map((e) => Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  child: bodyWidget(
                                      e.value.optionText,
                                      linearPercentage(e.key),
                                      percentageColor(e.key))))
                              .toList()),visible: _resultScreenNotifier.showListOfOptions,)
                    ],
                  ),
                ),
              ),
            )));
  }

  Color percentageColor(e) {
    switch (e) {
      case 0:
        return ThemeColor.lightGreen;
      case 1:
        return ThemeColor.lightOrange;
      case 2:
        return ThemeColor.greyColour1;
      default:
        return ThemeColor.lightBlue;
    }
  }

  linearPercentage(e) {
    switch (e) {
      case 0:
        return 0.6;
      case 1:
        return 0.4;
      case 2:
        return 0.2;
      default:
        return 0.1;
    }
  }

  Widget bodyWidget(String text, percent, Color color) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(width: 2.0, color: color),
        bottom: BorderSide(width: 2.0, color: color),
      )),
      child: LinearPercentIndicator(
        width: MediaQuery.of(context).size.width,
        animation: true,
        animationDuration: 2000,
        lineHeight: 60.0,
        percent: percent,
        center: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  '$percent%',
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            Expanded(
                child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ))),
          ],
        ),
        linearStrokeCap: LinearStrokeCap.butt,
        progressColor: color,
        backgroundColor: ThemeColor.lightGreyColour,
      ),
    );
  }
}
