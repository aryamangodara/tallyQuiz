import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/auth.dart';
import 'package:quiz/screens/quiz_after_code_screen.dart';

import '../models/local_storage.dart';
import '../models/my_quiz.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.amber,
                // height: 156,
                // width: 197,
                child: Center(child: Image.asset('assets/quizlogo.webp')),
              ),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  final auth =
                      Provider.of<Authentication>(context, listen: false);
                  auth.signInWithGoogle(context: context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'G',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Login With Google',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: 400,
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _codeController,
                                  decoration: const InputDecoration(
                                      labelText: 'Enter 4 digit code'),
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This is required';
                                    }
                                    if (value?.length != 4) {
                                      return 'Please enter 4 digits only';
                                    }
                                  },
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                      labelText: 'Enter your name'),
                                  validator: (value) {
                                    if (value == '') {
                                      return 'This is required';
                                    }
                                  },
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final data = await getQuizFromCode(
                                            int.parse(_codeController.text));
                                        print(data);
                                        _formKey.currentState!.reset();

                                        if (data == null) {
                                          const snackBar = SnackBar(
                                            content: Text(
                                                'We are unable to find a quiz with this code!'),
                                          );
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          return;
                                        }
                                        if (await isAlreadyAttempted(
                                            int.parse(_codeController.text))) {
                                          const snackBar = SnackBar(
                                            content: Text(
                                                'You have already attempted this quiz!'),
                                          );
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          return;
                                        }
                                        if (data['isEnded']) {
                                          const snackBar = SnackBar(
                                            content:
                                                Text('Oops! Quiz ended ...'),
                                          );
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          return;
                                        }
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => QuizAfterCode(
                                            quizData: data,
                                            name: _nameController.text,
                                            code:
                                                int.parse(_codeController.text),
                                          ),
                                        ));
                                      }
                                    },
                                    child: const Text('Start Now !'))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text('Continue with quiz code'))
            ],
          ),
        ),
      ),
    );
  }
}
