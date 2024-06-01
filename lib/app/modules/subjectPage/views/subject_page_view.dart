import 'package:added/app/components/nv_appbar.dart';
import 'package:added/app/components/nv_subject_button.dart';
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
          Container(
            padding: const EdgeInsets.all(24),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'العمليات الحسابيّة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF676CAC),
                    fontSize: 30,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'إختر نوع العملية الحسابية التي تود التدرب عليها',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Color(0xFF676CAC),
                    fontSize: 18,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
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
                            Get.toNamed(Routes.SUB_SUBJECT_PAGE, arguments: subject);
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
