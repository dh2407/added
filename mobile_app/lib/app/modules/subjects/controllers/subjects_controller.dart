import 'package:added/app/data/models/models.dart';
import 'package:added/app/services/services.dart';
import 'package:get/get.dart';

class SubjectsController extends GetxController {
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
