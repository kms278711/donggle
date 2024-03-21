import 'package:flutter/foundation.dart';

class QuizProvider with ChangeNotifier {
  List<dynamic>? selectedAnswers;

  QuizProvider() {
    selectedAnswers = [];
  }

  void updateAnswer(int index, dynamic answer) {
    if (selectedAnswers != null && selectedAnswers!.length > index) {
      selectedAnswers![index] = answer;
      notifyListeners(); // 상태 변경을 알림
    }
  }

  void clearAnswers(List quizzes) {
    selectedAnswers = List<dynamic>.generate(quizzes.length, (index) => null);
    notifyListeners();
  }
}
