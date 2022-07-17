import 'package:flutter/material.dart';

class QuestionItem extends StatefulWidget {
  final TextEditingController questionController;
  final int number;

  final TextEditingController a1Controller;
  final TextEditingController b1Controller;
  final TextEditingController c1Controller;
  QuestionItem(
      {Key? key,
      required this.questionController,
      required this.a1Controller,
      required this.b1Controller,
      required this.c1Controller,
      required this.number})
      : super(key: key);

  @override
  State<QuestionItem> createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${widget.number}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Question ${widget.number}'),
          controller: widget.questionController,
          validator: (value) {
            if (value == '') {
              return 'This is required';
            }
          },
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                controller: widget.a1Controller,
                decoration: const InputDecoration(labelText: 'Option a'),
                validator: (value) {
                  if (value == '') {
                    return 'This is required';
                  }
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                controller: widget.b1Controller,
                decoration: const InputDecoration(labelText: 'Option b'),
                validator: (value) {
                  if (value == '') {
                    return 'This is required';
                  }
                  // return '';
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: TextFormField(
                controller: widget.c1Controller,
                decoration: const InputDecoration(labelText: 'Option c'),
                validator: (value) {
                  if (value == '') {
                    return 'This is required';
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
