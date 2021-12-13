class QuestionDataViewModel {
  dynamic id;
  dynamic question;
  dynamic hindiQuestion;
  dynamic multipleAnswers;
  dynamic level;
  dynamic type;
  dynamic questionType;
  dynamic index;
  List<OptionDataViewModel>? options;

  QuestionDataViewModel(
      {required this.id,
      required this.question,
      required this.hindiQuestion,
      required this.multipleAnswers,
      required this.level,
      required this.type,
      required this.questionType,
      required this.index});

  factory QuestionDataViewModel.fromJson(Map<String, dynamic> json) =>
      QuestionDataViewModel(
        id: json["id"],
        question: json['question'],
        hindiQuestion: json['hindi_question'],
        multipleAnswers: json['multiple_answers'],
        level: json['level'],
        type: json['type'],
        questionType: json['question_type'],
        index: json['index'],
      );
}

class OptionDataViewModel {
  dynamic id;
  dynamic tempQuestionId;
  dynamic optionText;
  dynamic hindiOptionText;
  dynamic correctAnswer;

  OptionDataViewModel(
      {required this.id,
      required this.tempQuestionId,
      required this.optionText,
      required this.hindiOptionText,
      required this.correctAnswer});

  factory OptionDataViewModel.fromJson(Map<String, dynamic> json) {
    return OptionDataViewModel(
      id: json["id"],
      tempQuestionId: json["temp_question_id"],
      optionText: json["option_text"],
      hindiOptionText: json["hindi_option_text"],
      correctAnswer: json["correct_answer"],
    );
  }
}
class BlocModel {
  QuestionDataViewModel question;
  List<OptionDataViewModel> options;
  int dataLoaded;

  BlocModel(
      this.question, this.options, this.dataLoaded);
}
