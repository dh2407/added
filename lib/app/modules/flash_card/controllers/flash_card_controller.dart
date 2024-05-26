import 'dart:math';

import 'package:added/app/data/models/models.dart';
import 'package:get/get.dart';
import 'package:added/app/services/services.dart';

class FlashCardController extends GetxController {  
  late SubSubject subSubject;
  Rx<FlashCard?> currentFlashCard = Rx<FlashCard?>(null);
  RxList<String> currentResponses = <String>[].obs;
  RxList<FlashCard> flashCards = <FlashCard>[].obs;
  RxList<String> failedAttempts = <String>[].obs;
  Rx<int> numberOfCardsOnStart = 0.obs;
  Rx<bool?> isCorrect = false.obs;

  @override
  void onInit() async {
    super.onInit();
    subSubject = Get.arguments as SubSubject;
    await fetchFlashCards();
    selectNextFlashCard();
  }

  Future<void> fetchFlashCards() async {
    List<FlashCard> flashCardsList = await FlashCardService.fetchFlashCardsBySubSubjectId(subSubject.id);
    flashCards.assignAll(flashCardsList);
    numberOfCardsOnStart.value = flashCardsList.length;
  }

  Future<void> sendFlashCardResponse(FlashCard _flashCard) async {
    int newRank = failedAttempts.isEmpty ? _flashCard.currentPlayingRank + 1 : min(_flashCard.currentPlayingRank - 1, 0);
    String responseStatus = failedAttempts.isEmpty ? 'OK' : 'KO';
    FlashCard newFlashCard = FlashCard(id: _flashCard.id, question: _flashCard.question, rightResponse: _flashCard.rightResponse, wrongResponses: _flashCard.wrongResponses, subSubjectId: _flashCard.subSubjectId, lastPlayedDate: DateTime.now(), currentPlayingRank: newRank, lastPlayedStatus: responseStatus); 
    await FlashCardService.updateFlashCardStatus(newFlashCard);
    flashCards.removeWhere((flashCard) => flashCard.id == _flashCard.id);
  }

  void prepareNextFlashCard () {
    failedAttempts.assignAll([]);
    isCorrect.value = false;
    selectNextFlashCard();
  }

  void selectNextFlashCard() {
    FlashCard? flashCard = flashCards.firstWhereOrNull(
      (flashCard) => flashCard.lastPlayedStatus == null,
    );
    currentFlashCard.value = flashCard;

    List<String> responses = [
      ...(currentFlashCard.value?.wrongResponses ?? []),
      currentFlashCard.value?.rightResponse ?? ''
    ];
    responses.shuffle();
    currentResponses.assignAll(responses);
  }

  @override
  void onReady() {
    super.onReady();
    selectNextFlashCard();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
