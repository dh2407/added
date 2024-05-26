import 'package:flutter/material.dart';

class QuestionBoard extends StatelessWidget {
  final String question;

  const QuestionBoard({Key? key, required this.question}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200, // Set height to 250
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0), // Border radius in all corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      child: Text(
        question,
        style: TextStyle(fontSize: 128),
      ),
    );
  }
}
