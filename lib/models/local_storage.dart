import 'package:shared_preferences/shared_preferences.dart';

Future addQuizToStorage(int code) async {
  final prefs = await SharedPreferences.getInstance();
  var list = prefs.getStringList('attemptedQuiz');
  if (list == null) {
    list = [];
  }
  list.add(code.toString());
  prefs.setStringList('attemptedQuiz', list);
  totalQuizAttempted = list.length;
}

Future getTotalQuizAttempted() async {
  final prefs = await SharedPreferences.getInstance();
  var list = prefs.getStringList('attemptedQuiz');
  if (list == null) {
    totalQuizAttempted = 0;
    return;
  }
  totalQuizAttempted = list.length;
}

Future isAlreadyAttempted(int code) async {
  final prefs = await SharedPreferences.getInstance();
  var list = prefs.getStringList('attemptedQuiz');
  if (list == null) {
    return false;
  }
  if (list.contains(code.toString())) {
    return true;
  }
  return false;
}

int totalQuizAttempted = 0;
