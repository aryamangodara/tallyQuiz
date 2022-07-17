import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future getAllQuizOfUser() async {
  final email = FirebaseAuth.instance.currentUser!.email!
      .split('@')[0]
      .replaceAll('.', '');
  final url = Uri.parse(
      'https://quiz-app-755eb-default-rtdb.asia-southeast1.firebasedatabase.app/users/$email.json');
  final response = await http.get(url);
  // print(json.decode(response.body)['codes']);
  if (jsonDecode(response.body) == null) {
    return [];
  }
  return json.decode(response.body)['codes'];
}

Future getQuizFromCode(int code) async {
  final url = Uri.parse(
      'https://quiz-app-755eb-default-rtdb.asia-southeast1.firebasedatabase.app/quizes/$code.json');
  final response = await http.get(url);
  final responseData = jsonDecode(response.body);
  // print(responseData);
  return responseData;
}

Future quizDataOfUser() async {
  var arr = await getAllQuizOfUser() as List; //return array of codes
  MyQuizCodes = arr;
  var list = [];
  for (var i in arr) {
    list.add(await getQuizFromCode(i));
  }
  print(list);
  myQuizData = list;
  return list;
}

List myQuizData = [];
List MyQuizCodes = [];
