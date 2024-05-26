import 'package:added/app/data/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class FlashCardService {
  static Future<List<FlashCard>> fetchFlashCardsBySubSubjectId(
      String subSubjectId) async {
    DateTime calculateTimeToPlayAfter(DateTime date, int rank) {
      Duration durationToAdd = Duration(hours: rank * 4);
      DateTime newDate = date.add(durationToAdd);
      return newDate;
    }

    final flashCardsBox = await Hive.openBox<FlashCard>('FlashCards');
    DateTime today = DateTime.now();

    List<FlashCard> flashCardsList = flashCardsBox.values
        .where((flashcard) => flashcard.subSubjectId == subSubjectId)
        .cast<FlashCard>()
        .toList();

    flashCardsList = flashCardsList.where((flashcard) {
      if (flashcard.lastPlayedDate == null) return true;
      DateTime nextPlayDate = calculateTimeToPlayAfter(
          flashcard.lastPlayedDate!, flashcard.currentPlayingRank);
      return nextPlayDate.isBefore(today) ||
          nextPlayDate.isAtSameMomentAs(today);
    }).toList();

    flashCardsList.shuffle();
    return flashCardsList;
  }

  static Future<void> updateFlashCardStatus(FlashCard flashCard) async {
    final flashCardsBox = await Hive.openBox<FlashCard>('FlashCards');
    await flashCardsBox.put(flashCard.id, flashCard);
  }
}
