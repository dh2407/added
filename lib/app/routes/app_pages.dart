import 'package:get/get.dart';

import '../modules/flash_card/bindings/flash_card_binding.dart';
import '../modules/flash_card/views/flash_card_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/sub_subject/bindings/sub_subject_binding.dart';
import '../modules/sub_subject/views/sub_subject_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SUB_SUBJECT;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SUB_SUBJECT,
      page: () => const SubSubjectView(),
      binding: SubSubjectBinding(),
    ),
    GetPage(
      name: _Paths.FLASH_CARD,
      page: () => const FlashCardView(),
      binding: FlashCardBinding(),
    ),
  ];
}
