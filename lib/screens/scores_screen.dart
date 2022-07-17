import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:quiz/models/upload_scores.dart';
import 'package:share/share.dart';

class ScoresScreen extends StatelessWidget {
  const ScoresScreen({Key? key, required this.code}) : super(key: key);
  final int code;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scores'),
      ),
      body: FutureBuilder(
        future: fetchScores(code),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.done
            ? fetchedScores == null
                ? const Center(
                    child: Text(
                    'No one has attempted your quiz',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ))
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => ScoreItem(
                                name: fetchedScores.keys
                                    .toList()[index]
                                    .toString(),
                                score: fetchedScores.values
                                    .toList()[index]
                                    .toString()),
                            itemCount: fetchedScores.length,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Share.share(fetchedScores.toString());
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.deepOrange)),
                          child: const Text('Export Results'),
                        )
                      ],
                    ),
                  )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class ScoreItem extends StatelessWidget {
  const ScoreItem({Key? key, required this.name, required this.score})
      : super(key: key);
  final String name;
  final String score;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Spacer(),
            Text(
              score,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
