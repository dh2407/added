import 'package:added/app/data/models/models.dart';
import 'package:added/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sub_subjects_controller.dart';

class SubSubjectsView extends GetView<SubSubjectsController> {
  const SubSubjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.subject.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          return GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: List.generate(
              controller.subSubjects.length,
              (index) {
                SubSubject subSubject = controller.subSubjects[index];
                return SubSubjectButton(subSubject: subSubject);
              },
            ),
          );
        }),
      ),
    );
  }
}

class SubSubjectButton extends StatelessWidget {
  final SubSubject subSubject;

  const SubSubjectButton({required this.subSubject, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.FLASHCARDS, arguments: subSubject);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            subSubject.title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
