import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz/models/question.dart';
import 'package:http/http.dart' as http;

import 'my_quiz.dart';

Future createQuiz(
    Question question1, Question question2, String title, int code) async {
  // print('step 1');
  final url = Uri.parse(
      'https://quiz-app-755eb-default-rtdb.asia-southeast1.firebasedatabase.app/quizes.json');
  final response = await http.patch(
    url,
    body: json.encode(
      {
        '$code': {
          'title': title,
          'scores': [],
          'isEnded': false,
          'question1': {
            'question': question1.question,
            'optionA': question1.optionA,
            'optionB': question1.optionB,
            'optionC': question1.optionC,
            'answer': question1.answer
          },
          'question2': {
            'question': question2.question,
            'optionA': question2.optionA,
            'optionB': question2.optionB,
            'optionC': question2.optionC,
            'answer': question2.answer
          },
        }
      },
    ),
  );
  await updateUserQuiz(code);
  return response.statusCode;
}

Future updateUserQuiz(int code) async {
  final email = FirebaseAuth.instance.currentUser!.email!
      .split('@')[0]
      .replaceAll('.', '');
  final url = Uri.parse(
      'https://quiz-app-755eb-default-rtdb.asia-southeast1.firebasedatabase.app/users/${email}.json');
  List list = [];
  final responseList = await getAllQuizOfUser();
  if (responseList != null) {
    list = responseList;
  }
  list.add(code);
  final response = await http.put(
    url,
    body: jsonEncode({'codes': list}),
  );
  return response.statusCode;
}

Future isCodeUnique(int code) async {
  final url = Uri.parse(
      'https://quiz-app-755eb-default-rtdb.asia-southeast1.firebasedatabase.app/quizes/$code.json');
  final response = await http.get(url);
  final responseData = jsonDecode(response.body);
  if (responseData == null) {
    return true;
  }
  return false;
}
