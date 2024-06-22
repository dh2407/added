import 'package:added/app/data/models/models.dart';
import 'package:added/app/services/services.dart';
import 'package:get/get.dart';

class SubSubjectPageController extends GetxController {
  late Subject subject;
  RxList<SubSubject> subSubjects = <SubSubject>[].obs;
  final SubSubjectService _subSubjectService = SubSubjectService();

  @override
  void onInit() {
    super.onInit();
    subject = Get.arguments as Subject;
    fetchSubSubjects();
  }

  void fetchSubSubjects() async {
    try {
      subSubjects.value = await _subSubjectService.getSubSubjects(subject.uname);
    } catch (e) {
      print('Error fetching subsubjects: $e');
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
