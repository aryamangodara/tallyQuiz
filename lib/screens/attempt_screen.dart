import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/local_storage.dart';
import 'package:quiz/models/my_quiz.dart';
import 'package:quiz/screens/quiz_after_code_screen.dart';

class AttemptScreen extends StatefulWidget {
  const AttemptScreen({Key? key}) : super(key: key);

  @override
  State<AttemptScreen> createState() => _AttemptScreenState();
}

class _AttemptScreenState extends State<AttemptScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Create your quiz by tapping on + icon',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text(
                'OR',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.grey),
              ),
              const SizedBox(height: 30),
              const Text(
                'Enter the code to start the Quiz !',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _codeController,
                  decoration:
                      const InputDecoration(hintText: 'Enter 4 digit code'),
                  validator: (value) {
                    if (value == '') {
                      return 'This is required';
                    }
                    if (value?.length != 4) {
                      return 'Please enter 4 digits only';
                    }
                  },
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final data = await getQuizFromCode(
                          int.parse(_codeController.text));
                      print(data);
                      if (data == null) {
                        const snackBar = SnackBar(
                          content: Text(
                              'We are unable to find a quiz with this code!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      if (await isAlreadyAttempted(
                          int.parse(_codeController.text))) {
                        const snackBar = SnackBar(
                          content:
                              Text('You have already attempted this quiz!'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      if (data['isEnded']) {
                        const snackBar = SnackBar(
                          content: Text('Oops! Quiz ended ...'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        return;
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuizAfterCode(
                          quizData: data,
                          name: FirebaseAuth.instance.currentUser!.displayName!,
                          code: int.parse(_codeController.text),
                        ),
                      ));
                    }
                  },
                  child: const Text('Start')),
            ],
          ),
        ),
      ),
    );
  }
}
