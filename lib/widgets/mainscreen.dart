import 'package:demo_project/models/question_data_model.dart';
import 'package:demo_project/notifiers/mainscreen_notifier.dart';
import 'package:demo_project/theme_color.dart';
import 'package:demo_project/widgets/resultscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  _MainScreenState();

  late MainScreenNotifier _mainScreenNotifier;

  @override
  void initState() {
    _mainScreenNotifier = MainScreenNotifier();
    _mainScreenNotifier.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: ChangeNotifierProvider(
            create: (context) => _mainScreenNotifier,
            child: Consumer<MainScreenNotifier>(
              builder: (context, notifier, child) => SafeArea(
                  child: Scaffold(
                //backgroundColor: Colors.black,
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(40),
                  child: _timerWidget,
                ),
                body: Column(
                  children: [
                   Expanded(child:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _mainScreenNotifier.question != null
                            ? _questionWidget
                            : const SizedBox.shrink(),
                        _mainScreenNotifier.options != null
                            ? Column(
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          _mainScreenNotifier.options!.length,
                                      itemBuilder: (context, i) {
                                        _mainScreenNotifier.optionSelected
                                            .putIfAbsent(
                                                _mainScreenNotifier.options![i],
                                                () => false);
                                        return _optionWidget(
                                            _mainScreenNotifier.options![i], i);
                                      },
                                    )),
                              ],
                            )
                            : const SizedBox.shrink()
                      ],
                    )),
                    Visibility(
                      child: _submitButtonWidget,
                      visible: _mainScreenNotifier.question != null,
                    )
                  ],
                ),
              )),
            )));
  }

  get _questionWidget {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${_mainScreenNotifier.question!.index}',
            style: const TextStyle(
                fontSize: 12,
                color: ThemeColor.blue,
                fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              '${_mainScreenNotifier.question!.question}',
              style: const TextStyle(
                  fontSize: 12,
                  color: ThemeColor.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }

  Widget _optionWidget(OptionDataViewModel optionDataViewModel, index) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(top: 20),
        color: _mainScreenNotifier.optionSelected[optionDataViewModel] == true
            ? ThemeColor.blue
            : ThemeColor.lightGreyColour,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                color: ThemeColor.greyColour1,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Text(
                index == 0
                    ? 'A'
                    : index == 1
                        ? 'B'
                        : index == 2
                            ? 'C'
                            : index == 3
                                ? 'D'
                                : 'E',
                style: const TextStyle(
                    color: ThemeColor.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                optionDataViewModel.optionText,
                style: const TextStyle(
                    color: ThemeColor.black,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    fontSize: 12),
              ),
            )),
          ],
        ),
      ),
      onTap: () => {
        _mainScreenNotifier.optionSelected.updateAll((key, value) => false),
        _mainScreenNotifier.optionSelected
            .update(optionDataViewModel, (value) => true)
      },
    );
  }

  get _timerWidget {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Text(
            '${_mainScreenNotifier.counter}s',
            style: const TextStyle(
                fontSize: 15,
                color: ThemeColor.black,
                fontWeight: FontWeight.bold),
          ),
          alignment: Alignment.center,
        ),
        // Container(
        //   color: ThemeColor.black,
        //     alignment: Alignment.center,
        //     child: AnimatedBuilder(
        //       animation: controller,
        //
        //       builder:
        //           (BuildContext context, Widget? _widget) {
        //         return Transform.rotate(
        //           angle: controller.value * 6.3,
        //           child: _widget,
        //         );
        //       },
        //     )),
        // Container(
        //     height: 20,
        //     child: AnimatedBuilder(
        //       animation: controller,
        //       builder: (BuildContext context, Widget? _widget) {
        //         return CustomPaint(
        //             painter: CustomTimerPainter(
        //           animation: controller,
        //           backgroundColor: Colors.blue,
        //           color: ThemeColor.black,
        //         ));
        //       },
        //     ))
      ],
    );
  }

  get _submitButtonWidget {
    bool flag = false;
    return Container(
      alignment: Alignment.bottomRight,
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding:
              const EdgeInsets.only(left: 50, right: 50, top: 7, bottom: 7),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onSurface: ThemeColor.greyColour,
          primary: _mainScreenNotifier.optionSelected.containsValue(true)
              ? ThemeColor.blue
              : ThemeColor.greyColour,
        ),
        onPressed: () => {
          _mainScreenNotifier.optionSelected.forEach((key, value) {
            if (key.correctAnswer == "Y" && value) {
              flag = true;
            }
          }),
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ResultScreen(result: flag,options: _mainScreenNotifier.options,),
          )),
        },
        child: const Text(
          'Submit',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: ThemeColor.whiteColor),
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    required this.animation,
    required this.backgroundColor,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 30.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 190.0, paint);
    paint.color = color;

    //double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawLine(size.center(Offset.zero), size.center(Offset.zero), paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
