import 'dart:async';

import 'package:added/app/data/models/flashcard/flashcard.dart';
import 'package:added/app/data/models/subsubject/subsubject.dart';
import 'package:added/app/services/services.dart';
import 'package:added/app/services/sounds_service.dart';
import 'package:get/get.dart';

class QuestionPageController extends GetxController {
  late SubSubject subSubject;
  RxList<FlashCard> flashcards = <FlashCard>[].obs;
  late Rx<FlashCard?> currentFlashcard;
  Rx<String> currentAttempt = ''.obs;
  final FlashCardService _flashCardService = FlashCardService();
  RxList<String> wrongAttempts = <String>[].obs;
  RxBool flashCardWon = false.obs;
  RxBool flashCardLost = false.obs;
  Rx<int> timerValue = 0.obs;
  final SoundService soundService = SoundService();
  RxBool currentAttemptWrong = false.obs;
  RxBool completedAllFlashCards = false.obs;

  Timer? _timer;
  int get timeoutValue => 10;
  Duration get resultDuration => const Duration(seconds: 1);

  @override
  void onInit() {
    super.onInit();
    subSubject = Get.arguments as SubSubject;
    fetchFlashCards();
  }

  void fetchFlashCards() async {
    try {
      List<FlashCard> fetchedFlashcards =
          await _flashCardService.getFlashCards(subSubject.uname);
      fetchedFlashcards.shuffle();
      flashcards.value = fetchedFlashcards;
      currentFlashcard =
          Rx<FlashCard?>(flashcards.isNotEmpty ? flashcards.first : null);
      startTimer();
    } catch (e) {
      print('Error fetching flashcards: $e');
    }
  }

  void startTimer() {
    stopTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timerValue.value < timeoutValue) {
        timerValue.value++;
      } else {
        flashCardLost.value = true;
        getNextFlashCard();
        soundService.playDodov();
        _timer?.cancel();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  void getNextFlashCard() {
    Timer(this.resultDuration, () {
      if (flashcards.isNotEmpty) {
        currentAttemptWrong.value = false;
        flashCardLost.value = false;
        flashCardWon.value = false;
        wrongAttempts.value = [];
        currentAttempt.value = "";
        flashcards.removeAt(0);
        currentFlashcard.value =
            flashcards.isNotEmpty ? flashcards.first : null;
        if (flashcards.isEmpty) {
          completedAllFlashCards.value = true;
          timerValue.value = 0;
          stopTimer();
        } else {
          timerValue.value = 0;
          startTimer();
        }
      }
    });
  }

  void onKeyboardButtonClicked(String value) {
    if (!flashCardWon.value && !flashCardLost.value) {
      currentAttempt.value += value;
    }
    if (currentAttempt.value == currentFlashcard.value?.response) {
      flashCardWon.value = true;
      stopTimer();
      soundService.playCoin();
      getNextFlashCard();
      return;
    }
    if (currentFlashcard.value != null &&
        !currentFlashcard.value!.response.startsWith(currentAttempt.value)) {
      currentAttemptWrong.value = true;
    }
  }

  void onKeyboardValidateClicked() {
    final currentFlashcardValue = currentFlashcard.value;
    if (currentFlashcardValue != null) {
      final correctAnswer = currentFlashcardValue.response;
      if (currentAttempt.value == correctAnswer) {
        flashCardWon.value = true;
        stopTimer();
        soundService.playCoin();
        getNextFlashCard();
      } else {
        soundService.playDodov();
        wrongAttempts.add(currentAttempt.value);
        if (wrongAttempts.length >= 3) {
          flashCardLost.value = true;
          stopTimer();
          getNextFlashCard();
        }
      }
    }
    currentAttempt.value = '';
  }

  void onKeyboardClearClicked() {
    if (!flashCardWon.value && !flashCardLost.value) {
      currentAttempt.value = '';
      currentAttemptWrong.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
