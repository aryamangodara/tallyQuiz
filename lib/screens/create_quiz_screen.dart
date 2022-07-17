import 'package:flutter/material.dart';
import 'package:quiz/models/create_quiz.dart';
import 'package:quiz/models/question.dart';

import '../widgets/add_question_from_item.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final _formKey = GlobalKey<FormState>();
  List<String> options = ['a', 'b', 'c'];

  String? _answer1;
  String? _answer2;
  String? _answer3;
  final _question1Controller = TextEditingController();
  final _codeController = TextEditingController();
  final _titleController = TextEditingController();
  final _question2Controller = TextEditingController();
  final _question3Controller = TextEditingController();
  final _a1Controller = TextEditingController();
  final _b1Controller = TextEditingController();
  final _c1Controller = TextEditingController();
  final _a2Controller = TextEditingController();
  final _b2Controller = TextEditingController();
  final _c2Controller = TextEditingController();
  final _a3Controller = TextEditingController();
  final _b3Controller = TextEditingController();
  final _c3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Quiz')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == '') {
                      return 'This is required field';
                    }
                  },
                ),
                const SizedBox(height: 4),
                TextFormField(
                  controller: _codeController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Enter 4 digit code'),
                  validator: (value) {
                    if (value == '') {
                      return 'This is required';
                    }
                    if (value?.length != 4) {
                      return 'Please enter 4 digits only';
                    }
                  },
                ),
                const SizedBox(height: 40),
                QuestionItem(
                  number: 1,
                  questionController: _question1Controller,
                  a1Controller: _a1Controller,
                  b1Controller: _b1Controller,
                  c1Controller: _c1Controller,
                ),
                DropdownButtonFormField<String>(
                  hint: const Text('Answer'),
                  value: _answer1,
                  iconSize: 24,
                  validator: (value) => value == null ? 'field required' : null,
                  elevation: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      _answer1 = newValue!;
                    });
                  },
                  items: options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                QuestionItem(
                  number: 2,
                  questionController: _question2Controller,
                  a1Controller: _a2Controller,
                  b1Controller: _b2Controller,
                  c1Controller: _c2Controller,
                ),
                DropdownButtonFormField<String>(
                  hint: const Text('Answer'),
                  value: _answer2,
                  iconSize: 24,
                  validator: (value) => value == null ? 'field required' : null,
                  elevation: 16,
                  onChanged: (String? newValue) {
                    setState(() {
                      _answer2 = newValue!;
                    });
                  },
                  items: options.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 80),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (!await isCodeUnique(
                            int.parse(_codeController.text))) {
                          const snackBar = SnackBar(
                            content:
                                Text('Please choose a differnet quiz code !'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          return;
                        }
                        final responseCode = await createQuiz(
                          Question(
                            _question1Controller.text,
                            _a1Controller.text,
                            _b1Controller.text,
                            _c1Controller.text,
                            answerIs(_answer1!),
                          ),
                          Question(
                            _question2Controller.text,
                            _a2Controller.text,
                            _b2Controller.text,
                            _c2Controller.text,
                            answerIs(_answer2!),
                          ),
                          _titleController.text,
                          int.parse(_codeController.text),
                        );
                        print(responseCode);
                        if (responseCode == 200) {
                          _formKey.currentState!.reset();

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(context, 'home');
                        }
                      }
                    },
                    child: const Text('Create New Quiz!'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

int answerIs(String a) {
  return a == 'a'
      ? 0
      : a == 'b'
          ? 1
          : 2;
}
