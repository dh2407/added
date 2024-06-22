import 'package:get/get.dart';

import '../controllers/sub_subjects_controller.dart';

class SubSubjectsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubSubjectsController>(
      () => SubSubjectsController(),
    );
  }
}
