import 'package:get/get.dart';

import '../controllers/sub_subject_controller.dart';

class SubSubjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubSubjectController>(
      () => SubSubjectController(),
    );
  }
}
