class Question {
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final int answer;

  Question(
      this.question, this.optionA, this.optionB, this.optionC, this.answer);
}

class Quiz {
  final List<Quiz> questions;

  Quiz(this.questions);
}
