import 'package:added/app/modules/questionPage/controllers/question_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimerSection extends StatelessWidget {
  final QuestionPageController controller = Get.find<QuestionPageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: controller.timerValue.value / controller.timeoutValue,
              minHeight: 12,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              backgroundColor: Color.fromARGB(30, 103, 108, 173),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF676CAD)),
            ),
          ],
        ),
      ),
    );
  }
}
