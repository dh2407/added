import 'package:get/get.dart';

import '../modules/flashcards/bindings/flashcards_binding.dart';
import '../modules/flashcards/views/flashcards_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/nv/main.dart';
import '../modules/subSubjects/bindings/sub_subjects_binding.dart';
import '../modules/subSubjects/views/sub_subjects_view.dart';
import '../modules/subjects/bindings/subjects_binding.dart';
import '../modules/subjects/views/subjects_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SUBJECTS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SUBJECTS,
      page: () => const SubjectsView(),
      binding: SubjectsBinding(),
    ),
    GetPage(
      name: _Paths.SUB_SUBJECTS,
      page: () => const SubSubjectsView(),
      binding: SubSubjectsBinding(),
    ),
    GetPage(
      name: _Paths.FLASHCARDS,
      page: () => const FlashcardsView(),
      binding: FlashcardsBinding(),
    ),
    GetPage(
      name: _Paths.FC_MULTIPLAY,
      page: () => const FCMultiplay(),
    ),
  ];
}
