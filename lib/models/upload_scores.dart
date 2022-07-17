import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future uploadScores(int score, String name, int code) async {
  final url = Uri.parse(
      'https://quiz-app-755eb-default-rtdb.asia-southeast1.firebasedatabase.app/quizes/$code/scores.json');
  final response = await http.patch(url, body: jsonEncode({name: score}));
  print(response.body);
}

Future fetchScores(int code) async {
  final url = Uri.parse(
      'https://quiz-app-755eb-default-rtdb.asia-southeast1.firebasedatabase.app/quizes/$code/scores.json');
  final response = await http.get(url);
  print(response.body);
  fetchedScores = jsonDecode(response.body);
  return jsonDecode(response.body);
}

var fetchedScores;
