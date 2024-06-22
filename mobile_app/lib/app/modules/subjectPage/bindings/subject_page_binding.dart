import 'package:get/get.dart';

import '../controllers/subject_page_controller.dart';

class SubjectPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubjectPageController>(
      () => SubjectPageController(),
    );
  }
}
