import 'dart:async';

import 'package:demo_project/bloc/mainscreen_bloc.dart';
import 'package:demo_project/models/question_data_model.dart';
import 'package:flutter/cupertino.dart';

class MainScreenNotifier extends ChangeNotifier {
  int counter = 60, dataLoaded = 0;
  Map<OptionDataViewModel, bool> optionSelected=Map();
  late Timer _timer;
  QuestionDataViewModel? question;
  List<OptionDataViewModel>? options;
  BuildContext? _context;
  MainScreenBloc mainScreenBloc = MainScreenBloc();

  MainScreenNotifier(this._context);

  init() {
    mainScreenBloc.getListOfQuestions();
    startTimer();
    mainScreenBloc.getData.listen((event) {
      question = event.question;
      options = event.options;
      dataLoaded = event.dataLoaded;
      notifyListeners();
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (counter == 0) {
          timer.cancel();
        } else {
          counter--;
        }
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
