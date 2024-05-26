import 'package:added/app/components/sub_subject_component/sub_subject_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sub_subject_controller.dart';

class SubSubjectView extends GetView<SubSubjectController> {
  const SubSubjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.subject.value?.title ?? "-")),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Obx(() {
          if (controller.subSubjects.isEmpty) {
            return const Center(
              child: Text(
                'No subSubjects found',
                style: TextStyle(fontSize: 20),
              ),
            );
          } else {
            return Center(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: controller.subSubjects.length,
                itemBuilder: (context, index) {
                  final subSubject = controller.subSubjects[index];
                  return SubSubjectBoxComponent(
                    subSubject: subSubject,
                  );
                },
              ),
            );
          }
        }),
      ),
    );
  }
}
