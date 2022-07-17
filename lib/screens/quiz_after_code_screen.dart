import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quiz/models/local_storage.dart';
import 'package:quiz/models/my_quiz.dart';
import 'package:quiz/models/upload_scores.dart';

class QuizAfterCode extends StatefulWidget {
  const QuizAfterCode(
      {Key? key,
      required this.quizData,
      required this.name,
      required this.code})
      : super(key: key);
  final quizData;
  final int code;
  final String name;

  @override
  State<QuizAfterCode> createState() => _QuizAfterCodeState();
}

class _QuizAfterCodeState extends State<QuizAfterCode> {
  int index = 0;
  int score = 0;
  List<String> funnyUrls = [
    'https://bestanimations.com/media/dancers/1920214489dancing-baby2.gif',
    'https://c.tenor.com/0Bwg1FCGOJwAAAAd/kids-dancing.gif',
    'https://blog.photoshelter.com/wp-content/uploads/2012/03/10clw9c1.gif',
    'https://media0.giphy.com/media/LIzcoQmSd8xd1adCLy/200.gif',
    'https://c.tenor.com/g01carZ_O74AAAAM/indian-man-rolls-eyes-funny-gorilla.gif',
    'https://c.tenor.com/beX7hfl-LHEAAAAC/indian-dance.gif',
    'https://www.india.com/wp-content/uploads/2019/10/point4.gif',
    'https://www.icegif.com/wp-content/uploads/dancing-icegif-8.gif',
    'https://c.tenor.com/_iQmiAyoG-YAAAAM/laughing-laughing-hysterically.gif',
    'https://data.whicdn.com/images/152552654/original.gif',
    'https://c.tenor.com/6G8KXj9IaiMAAAAM/memes-happy.gif'
  ];

  void nextQuestion() {
    setState(() {
      index++;
    });
  }

  void answered(int index, int answer) {
    setState(() {
      if (widget.quizData['question${index + 1}']['answer'] == answer) {
        score += 10;
      }
      nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.quizData['title'])),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: index != 2
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Score: $score',
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Question ${index + 1}: ${widget.quizData['question${index + 1}']['question']}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => answered(index, 0),
                        child: Text(
                            '${widget.quizData['question${index + 1}']['optionA']}'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => answered(index, 1),
                        child: Text(
                            '${widget.quizData['question${index + 1}']['optionB']}'),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => answered(index, 2),
                        child: Text(
                            '${widget.quizData['question${index + 1}']['optionC']}'),
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Congratulations !',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Image.network(
                        funnyUrls[Random().nextInt(funnyUrls.length)]),
                    const SizedBox(height: 20),
                    Text(
                      'Score: $score',
                      style: const TextStyle(color: Colors.grey, fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        uploadScores(score, widget.name, widget.code);
                        addQuizToStorage(widget.code);
                        Navigator.of(context).pop();
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      child: const Text('Mark complete !'),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
