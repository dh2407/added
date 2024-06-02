import 'dart:ffi';

import 'package:added/app/components/nv_appbar.dart';
import 'package:added/app/components/nv_subject_button.dart';
import 'package:added/app/components/nv_timer_section.dart';
import 'package:added/app/services/sounds_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/question_page_controller.dart';

class QuestionPageView extends GetView<QuestionPageController> {
  const QuestionPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final SoundService soundService = SoundService();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FB),
      appBar: const NvAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F434BB4),
                  blurRadius: 8,
                  offset: Offset(0, 0),
                  spreadRadius: 1,
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 16, top: 36, left: 36, right: 36),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    if (controller.completedAllFlashCards.value == true) {
                      return const Column(
                        children: [
                          Text(
                            "عمل رائع \n أحسنت ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF676CAC),
                              fontSize: 30,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          // TextButton(
                          //   onPressed: () {
                          //     Get.back();
                          //   },
                          //   child: Container(
                          //     decoration: const BoxDecoration(
                          //       border: Border(
                          //         bottom: BorderSide(
                          //           color: Color(0xFF676CAD),
                          //           width: 1.0,
                          //         ),
                          //       ),
                          //     ),
                          //     child: const Text(
                          //       'إضغط هنا للعودة إلى الجدول',
                          //       style: TextStyle(
                          //         color: Color(0xFF676CAD),
                          //       ),
                          //     ),
                          //   ),
                          // )
                        ],
                      );
                    } else if (controller.flashcards.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Column(
                        children: [
                          Text(
                            controller.currentFlashcard.value!.question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFF181B3D),
                              fontSize: 40,
                              fontFamily: 'Open Sans',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            color: controller.flashCardWon.value ||
                                    controller.flashCardLost.value
                                ? const Color(0xFF0CA788)
                                : controller.currentAttemptWrong.value
                                    ? const Color(0xFFF24628)
                                    : Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            child: Text(
                              controller.flashCardLost.value
                                  ? controller.currentFlashcard.value!.response
                                  : controller.currentAttempt.value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: controller.flashCardWon.value ||
                                        controller.currentAttemptWrong.value ||
                                        controller.flashCardLost.value
                                    ? Colors.white
                                    : const Color(0xFF676CAD),
                                fontSize: 40,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                  TimerSection(),
                ],
              ),
            ),
          ),
          Expanded(
              child: GridView.count(
            padding: const EdgeInsets.all(24),
            childAspectRatio: 1.5,
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 15.0,
            children: List.generate(
              12,
              (index) {
                return NvSubSubjectButton(
                  text: getKeyboardButtonText(index),
                  onTap: () {
                    if (!controller.flashCardWon.value &&
                        !controller.flashCardLost.value) {
                      if (index == 11) {
                        soundService.playKsek();
                        controller.onKeyboardClearClicked();
                      } /* else if (key == 'validate') {
                        controller.onKeyboardValidateClicked();
                      } */
                      else if (index == 9) {
                        return;
                      } else {
                        soundService.playBlo9();
                        final keyValue =
                            index == 10 ? "0" : (index + 1).toString();
                        controller.onKeyboardButtonClicked(keyValue);
                      }
                    }
                  },
                  textColor: getKeyboardButtonTextColor(index),
                );
              },
            ),
          )),
        ],
      ),
    );
  }

  Color getKeyboardButtonTextColor(int index) {
    if (index == 11) return const Color(0xFFF87E69);
    return const Color(0xFF676CAC);
  }

  String getKeyboardButtonText(int index) {
    if (index == 9) return "-";
    if (index == 11) return "×";
    if (index == 10) return "0";
    return (index + 1).toString();
  }
}
