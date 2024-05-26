import 'package:added/app/data/models/models.dart';
import 'package:added/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/subjects_controller.dart';

class SubjectsView extends GetView<SubjectsController> {
  const SubjectsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubjectsView'),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(
          () {
            return GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              padding: const EdgeInsets.all(20.0),
              children: controller.subjects.map((subject) {
                return SubjectButton(
                  subject: subject,
                  onTap: () {
                    Get.toNamed(Routes.SUB_SUBJECTS, arguments: subject);
                  },
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}

class SubjectButton extends StatelessWidget {
  final Subject subject;
  final VoidCallback onTap;

  const SubjectButton({
    required this.subject,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Text(
            subject.title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
