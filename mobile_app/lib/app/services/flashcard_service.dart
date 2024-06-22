import 'package:added/app/data/models/models.dart';
import 'package:hive/hive.dart';

class FlashCardService {
  Future<List<FlashCard>> getFlashCards(String subSubjectUname) async {
    var flashCardBox = await Hive.openBox<FlashCard>('flashcards');
    return flashCardBox.values.where((flashCard) => flashCard.subSubject.uname == subSubjectUname).toList();
  }
}
