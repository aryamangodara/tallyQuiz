import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/models/end_quiz.dart';
import 'package:quiz/models/my_quiz.dart';
import 'package:quiz/screens/scores_screen.dart';
import 'package:share/share.dart';
// import '';

class MyQuizScreen extends StatefulWidget {
  const MyQuizScreen({Key? key}) : super(key: key);

  @override
  State<MyQuizScreen> createState() => _MyQuizScreenState();
}

class _MyQuizScreenState extends State<MyQuizScreen> {
  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: quizDataOfUser(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.done
              ? myQuizData.isEmpty
                  ? const Center(
                      child: Text('Your Created Quiz could be managed here !!'),
                    )
                  : RefreshIndicator(
                      onRefresh: () => quizDataOfUser(),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return MyQuizItem(
                              quizData: myQuizData,
                              index: index,
                              quizCodes: MyQuizCodes,
                              update: update,
                            );
                          },
                          itemCount: myQuizData.length,
                        ),
                      ),
                    )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}

class MyQuizItem extends StatelessWidget {
  const MyQuizItem({
    Key? key,
    required this.quizData,
    required this.index,
    required this.quizCodes,
    required this.update,
  }) : super(key: key);
  final List quizData;
  final List quizCodes;
  final int index;
  final Function update;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ScoresScreen(code: quizCodes[index]),
      )),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quizData[index]['title'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Code: ${quizCodes[index].toString()}',
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
                const Spacer(),
                if (!quizData[index]['isEnded'])
                  ElevatedButton(
                    onPressed: () async {
                      Widget yesButton = FlatButton(
                        child: const Text("Yes"),
                        onPressed: () async {
                          await endQuiz(quizCodes[index]);
                          update();
                          Navigator.of(context).pop();
                        },
                      );
                      Widget noButton = FlatButton(
                        child: const Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                      AlertDialog alert = AlertDialog(
                        title: const Text("Alert"),
                        content: const Text(
                            "Do you really want to end this quiz !!"),
                        actions: [yesButton, noButton],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );

                      // await endQuiz(quizCodes[index]).then((value) {});
                      // update();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: const Text('End Quiz'),
                  ),
                const SizedBox(width: 10),
                if (!quizData[index]['isEnded'])
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      Share.share(
                          'Download the app and play the quiz with code: ${quizCodes[index]}');
                    },
                  ),
                if (quizData[index]['isEnded'])
                  IconButton(
                    icon: const Icon(Icons.restart_alt),
                    onPressed: () {
                      Widget yesButton = FlatButton(
                        child: const Text("Yes"),
                        onPressed: () async {
                          await startQuiz(quizCodes[index]);
                          update();
                          Navigator.of(context).pop();
                        },
                      );
                      Widget noButton = FlatButton(
                        child: const Text("No"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      );
                      AlertDialog alert = AlertDialog(
                        title: const Text("Alert"),
                        content:
                            const Text("Do you want to restart this quiz !!"),
                        actions: [yesButton, noButton],
                      );
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                  ),
                // const SizedBox(width: 10),
                // const Icon(
                //   Icons.mode_edit,
                //   color: Colors.green,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
