import 'package:added/app/components/nv_appbar.dart';
import 'package:added/app/components/nv_subject_button.dart';
import 'package:added/app/components/nv_subject_summary.dart';
import 'package:added/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/subject_page_controller.dart';

class SubjectPageView extends GetView<SubjectPageController> {
  const SubjectPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FB),
      appBar: const NvAppBar(showCloseBtn: false),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SubjectSummary(title: 'العمليات الحسابيّة', description: 'إختر نوع العملية الحسابية التي تود التدرب عليها'),
          Expanded(
            child: Obx(
              () {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.subjects.map((subject) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: NvSubSubjectButton(
                          text: subject.title,
                          onTap: () {
                            Get.toNamed(Routes.SUB_SUBJECT_PAGE,
                                arguments: subject);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
