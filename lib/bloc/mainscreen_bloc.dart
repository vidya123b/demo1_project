import 'dart:async';

import 'package:demo_project/models/question_data_model.dart';
import 'package:demo_project/service/api_services.dart';
import 'package:flutter/cupertino.dart';

class MainScreenBloc {
  API api = API();
  final StreamController<BlocModel> _fetcher =
      StreamController<BlocModel>.broadcast();

  Stream<BlocModel> get getData => _fetcher.stream;

  getListOfQuestions() async {
    int dataLoaded = 0;
    await api.getListOfQuestions().then((response) async {
      if (response != null) {
        switch (response.statusCode) {
          case 200:
            List<dynamic> list = (response.data) as List;
            if (list.isNotEmpty) {
              dataLoaded = 1;
            }
            List<QuestionDataViewModel> questionDataViewModel = list.map<QuestionDataViewModel>(
                (json) => QuestionDataViewModel.fromJson(json)).toList();
            List<dynamic> options = list[0]["options"] as List;
            List<OptionDataViewModel> optionsData = options
                .map((model) => OptionDataViewModel.fromJson(model))
                .toList();
            questionDataViewModel[0].options = optionsData;
            BlocModel blocModel =
                BlocModel(questionDataViewModel[0], optionsData, dataLoaded);
            _fetcher.sink.add(blocModel);
            break;
          case 401:
            dataLoaded = 0;
            break;
          case 400:
            dataLoaded = 0;
            break;
        }
      }
    });
  }
}
