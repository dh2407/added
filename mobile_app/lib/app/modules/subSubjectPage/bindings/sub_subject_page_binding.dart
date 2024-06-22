import 'package:get/get.dart';

import '../controllers/sub_subject_page_controller.dart';

class SubSubjectPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubSubjectPageController>(
      () => SubSubjectPageController(),
    );
  }
}
