import 'package:added/app/data/models/models.dart';
import 'package:added/app/services/services.dart';
import 'package:get/get.dart';

class SubSubjectController extends GetxController {
  RxList<SubSubject> subSubjects = <SubSubject>[].obs;
  Rx<Subject?> subject = Rx<Subject?>(null);

  @override
  void onInit() async {
    super.onInit();
    await fetchSubject();
    if (subject.value != null) {
      fetchSubSubjects();
    }
  }

  Future<void> fetchSubject() async {
    Subject? fetchedSubject = await SubjectService.fetchSubjectById("1");
    subject.value = fetchedSubject;
  }

  Future<void> fetchSubSubjects() async {
    if (subject.value != null) {
      List<SubSubject> subSubjectsList = await SubSubjectService.fetchSubSubjectsBySubjectId(subject.value!.id);
      subSubjects.assignAll(subSubjectsList);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
