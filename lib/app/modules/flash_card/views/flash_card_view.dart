import 'package:added/app/components/question_board/question_board.dart';
import 'package:added/app/components/response_button/response_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/flash_card_controller.dart';

class FlashCardView extends GetView<FlashCardController> {
  const FlashCardView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ورقة اللعب'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Obx(() {
            if (controller.isCorrect.value == true) {
              return IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => controller.prepareNextFlashCard(),
              );
            }
            return const SizedBox();
          }),
        ],
      ),
      body: Center(
        child: Obx(() {
          if (controller.currentFlashCard.value != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  value: (controller.numberOfCardsOnStart.value -
                          controller.flashCards.length) /
                      controller.numberOfCardsOnStart.value,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: QuestionBoard(
                      question: controller.currentFlashCard.value!.question),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 40.0,
                    crossAxisSpacing: 40.0,
                    padding: const EdgeInsets.all(20.0),
                    children: _buildResponseButtons(context),
                  ),
                ),
              ],
            );
          } else {
            return const Text('لقد أتممت كل أوراق اللعب');
          }
        }),
      ),
    );
  }

  List<Widget> _buildResponseButtons(BuildContext context) {
    return controller.currentResponses.map((response) {
      ResponseButtonState buttonState;

      if (controller.isCorrect.value == null) {
        buttonState = ResponseButtonState.idle;
      } else if (controller.isCorrect.value == true &&
          response == controller.currentFlashCard.value?.rightResponse) {
        buttonState = ResponseButtonState.success;
      } else if (controller.failedAttempts.contains(response)) {
        buttonState = ResponseButtonState.failed;
      } else {
        buttonState = ResponseButtonState.idle;
      }

      return ResponseButton(
        content: response,
        state: buttonState,
        onPressed: () {
          if (controller.isCorrect.value != true) {
            _checkResponse(response);
          }
        },
      );
    }).toList();
  }

  void _checkResponse(String selectedResponse) {
    final bool isCorrect =
        selectedResponse == controller.currentFlashCard.value?.rightResponse;
    if (isCorrect) {
      controller.isCorrect.value = true;
      controller.sendFlashCardResponse(controller.currentFlashCard.value!);
    } else {
      controller.failedAttempts.add(selectedResponse);
    }
  }
}
