import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display Subjects
            Obx(() {
              return DataTable(
                columns: const [
                  DataColumn(label: Text('Subject ID')),
                  DataColumn(label: Text('Title')),
                ],
                rows: controller.subjects.map((subject) {
                  return DataRow(cells: [
                    DataCell(Text(subject.uname)),
                    DataCell(Text(subject.title)),
                  ]);
                }).toList(),
              );
            }),

            // Display SubSubjects
            Obx(() {
              return DataTable(
                columns: const [
                  DataColumn(label: Text('SubSubject ID')),
                  DataColumn(label: Text('Title')),
                  DataColumn(label: Text('Subject ID')),
                ],
                rows: controller.subSubjects.map((subSubject) {
                  return DataRow(cells: [
                    DataCell(Text(subSubject.uname)),
                    DataCell(Text(subSubject.title)),
                    DataCell(Text(subSubject.subject.uname)),
                  ]);
                }).toList(),
              );
            }),

            // Display FlashCards
            Obx(() {
              return DataTable(
                columns: const [
                  DataColumn(label: Text('FlashCard ID')),
                  DataColumn(label: Text('SubSubject ID')),
                  DataColumn(label: Text('Question')),
                  DataColumn(label: Text('Response')),
                ],
                rows: controller.flashCards.map((flashCard) {
                  return DataRow(cells: [
                    DataCell(Text(flashCard.uname)),
                    DataCell(Text(flashCard.subSubject.uname)),
                    DataCell(Text(flashCard.question)),
                    DataCell(Text(flashCard.response)),
                  ]);
                }).toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
