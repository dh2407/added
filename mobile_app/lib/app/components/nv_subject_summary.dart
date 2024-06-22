import 'package:flutter/material.dart';

class SubjectSummary extends StatelessWidget {
  final String title;
  final String description;

  const SubjectSummary({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFF676CAC),
              fontSize: 30,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            description,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF676CAC),
              fontSize: 18,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
