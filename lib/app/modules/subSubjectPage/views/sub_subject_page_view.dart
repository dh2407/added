import 'package:added/app/components/nv_appbar.dart';
import 'package:added/app/components/nv_subject_button.dart';
import 'package:added/app/components/nv_subject_summary.dart';
import 'package:added/app/data/models/models.dart';
import 'package:added/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../subSubjects/views/sub_subjects_view.dart';
import '../controllers/sub_subject_page_controller.dart';

class SubSubjectPageView extends GetView<SubSubjectPageController> {
  const SubSubjectPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FB),
      appBar: const NvAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SubjectSummary(
              title: 'العمليات الحسابيّة',
              description: 'إختر نوع العملية الحسابية التي تود التدرب عليها'),
          Expanded(
            child: Obx(() {
              return GridView.count(
                padding: const EdgeInsets.all(24),
                childAspectRatio: 1.5,
                crossAxisCount: 3,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 20.0,
                children: List.generate(
                  controller.subSubjects.length,
                  (index) {
                    SubSubject subSubject = controller.subSubjects[index];
                    return NvSubSubjectButton(
                      text: subSubject.title,
                      onTap: () {
                        Get.toNamed(Routes.FLASHCARDS, arguments: subSubject);
                      },
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
