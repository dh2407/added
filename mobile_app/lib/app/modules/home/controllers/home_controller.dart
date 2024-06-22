import 'package:added/app/services/services.dart';
import 'package:get/get.dart';
import 'package:added/app/data/models/models.dart';

class HomeController extends GetxController {
  var subjects = <Subject>[].obs;
  var subSubjects = <SubSubject>[].obs;
  var flashCards = <FlashCard>[].obs;

  final SubjectService _subjectService = SubjectService();
  final SubSubjectService _subSubjectService = SubSubjectService();
  final FlashCardService _flashCardService = FlashCardService();

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
  }

  void fetchSubjects() async {
    subjects.value = await _subjectService.getSubjects();
    await fetchSubSubjectsAndFlashCards();
  }

  Future<void> fetchSubSubjectsAndFlashCards() async {
    for (Subject subject in subjects) {
      var fetchedSubSubjects = await _subSubjectService.getSubSubjects(subject.uname);
      subSubjects.addAll(fetchedSubSubjects);
      for (SubSubject subSubject in fetchedSubSubjects) {
        var fetchedFlashCards = await _flashCardService.getFlashCards(subSubject.uname);
        flashCards.addAll(fetchedFlashCards);
      }
    }
  }
}
