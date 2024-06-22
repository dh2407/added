import 'package:added/app/data/models/subject/subject.dart';
import 'package:added/app/services/services.dart';
import 'package:get/get.dart';

class SubjectPageController extends GetxController {
  final SubjectService _subjectService = SubjectService();

  RxList<Subject> subjects = <Subject>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSubjects();
  }

  void fetchSubjects() async {
    subjects.value = await _subjectService.getSubjects();
  }
}
