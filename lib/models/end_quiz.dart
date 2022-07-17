import 'dart:convert';
import 'package:http/http.dart' as http;

Future endQuiz(int code) async {
  final url = Uri.parse(
      'https://quiz-app-755eb-default-rtdb.asia-southeast1.firebasedatabase.app/quizes/$code.json');
  final response = await http.patch(url, body: jsonEncode({'isEnded': true}));
}

Future startQuiz(int code) async {
  final url = Uri.parse(
      'https://quiz-app-755eb-default-rtdb.asia-southeast1.firebasedatabase.app/quizes/$code.json');
  final response = await http.patch(url, body: jsonEncode({'isEnded': false}));
  print(response.body);
}
