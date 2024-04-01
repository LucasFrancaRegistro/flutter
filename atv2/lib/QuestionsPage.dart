import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  QuestionsPageSate createState() => QuestionsPageSate();
}

class QuestionsPageSate extends State<QuestionsPage> {
   Map<String, bool> checked = {
    'Checkbox 1': false,
    'Checkbox 2': false,
    'Checkbox 3': false,
  };

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          ],
        ),
      ),
    );
  }

}
