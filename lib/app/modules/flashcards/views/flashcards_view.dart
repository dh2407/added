import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/flashcards_controller.dart';

class FlashcardsView extends GetView<FlashcardsController> {
  const FlashcardsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ورقة اللعب'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.flashcards.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                QuestionSection(
                  question: controller.currentFlashcard.value!.question,
                  response: controller.currentFlashcard.value!.response,
                  showResponse: controller.flashCardWon.value ||
                      controller.flashCardLost.value,
                ),
                TimerSection(),
                AttemptsSection(
                    attempts: controller.wrongAttempts,
                    currentAttempt: controller.currentAttempt.value),
                Expanded(
                  child: KeyboardSection(
                    onKeyPressed: (key) {
                      if (!controller.flashCardWon.value &&
                          !controller.flashCardLost.value) {
                        if (key == 'clear')
                          controller.onKeyboardClearClicked();
                        else if (key == 'validate')
                          controller.onKeyboardValidateClicked();
                        else
                          controller.onKeyboardButtonClicked(key);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class KeyboardSection extends StatelessWidget {
  final Function(String) onKeyPressed;

  const KeyboardSection({Key? key, required this.onKeyPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 80.0,
                height: 80.0,
                child: ElevatedButton(
                  onPressed: () => onKeyPressed('0'),
                  child: const Text('0'),
                ),
              ),
              SizedBox(
                width: 80.0,
                height: 80.0,
                child: ElevatedButton(
                  onPressed: () => onKeyPressed('validate'),
                  child: const Icon(Icons.check),
                ),
              ),
              SizedBox(
                width: 80.0,
                height: 80.0,
                child: ElevatedButton(
                  onPressed: () => onKeyPressed('clear'),
                  child: const Icon(Icons.close),
                ),
              )
            ].reversed.toList(),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () => onKeyPressed('3'),
                      child: const Text('3'),
                    ),
                  ),
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () => onKeyPressed('2'),
                      child: const Text('2'),
                    ),
                  ),
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () => onKeyPressed('1'),
                      child: const Text('1'),
                    ),
                  ),
                ].reversed.toList(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () => onKeyPressed('6'),
                      child: const Text('6'),
                    ),
                  ),
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () => onKeyPressed('5'),
                      child: const Text('5'),
                    ),
                  ),
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () => onKeyPressed('4'),
                      child: const Text('4'),
                    ),
                  ),
                ].reversed.toList(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () => onKeyPressed('9'),
                      child: const Text('9'),
                    ),
                  ),
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () => onKeyPressed('8'),
                      child: const Text('8'),
                    ),
                  ),
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: ElevatedButton(
                      onPressed: () => onKeyPressed('7'),
                      child: const Text('7'),
                    ),
                  ),
                ].reversed.toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AttemptsSection extends StatelessWidget {
  final List<String> attempts;
  final String currentAttempt;

  const AttemptsSection({
    Key? key,
    required this.attempts,
    required this.currentAttempt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int currentIndex = attempts.length;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          3,
          (index) {
            if (index == currentIndex) {
              return Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(
                    currentAttempt,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              );
            } else {
              final squareText = index < attempts.length ? attempts[index] : '';
              return Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: Center(
                  child: Text(squareText),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class QuestionSection extends StatelessWidget {
  final String question;
  final String response;
  final bool showResponse;

  const QuestionSection({
    Key? key,
    required this.question,
    required this.response,
    this.showResponse = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 100,
              child: Center(
                child: Text(
                  question,
                  style: const TextStyle(
                      fontSize: 64.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey),
                color: Colors.green),
            child: Center(
                child: Text(
              showResponse ? response : "",
              style:
                  const TextStyle(fontSize: 52.0, fontWeight: FontWeight.bold),
            )),
          ),
        ],
      ),
    );
  }
}

class TimerSection extends StatelessWidget {
  final FlashcardsController controller = Get.find<FlashcardsController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: controller.timerValue.value / 5,
              minHeight: 20,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
