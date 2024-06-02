import 'package:get/get.dart';

import '../controllers/question_page_controller.dart';

class QuestionPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuestionPageController>(
      () => QuestionPageController(),
    );
  }
}
