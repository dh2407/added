import 'package:get/get.dart';

import '../modules/flashcards/bindings/flashcards_binding.dart';
import '../modules/flashcards/views/flashcards_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/questionPage/bindings/question_page_binding.dart';
import '../modules/questionPage/views/question_page_view.dart';
import '../modules/subSubjectPage/bindings/sub_subject_page_binding.dart';
import '../modules/subSubjectPage/views/sub_subject_page_view.dart';
import '../modules/subSubjects/bindings/sub_subjects_binding.dart';
import '../modules/subSubjects/views/sub_subjects_view.dart';
import '../modules/subjectPage/bindings/subject_page_binding.dart';
import '../modules/subjectPage/views/subject_page_view.dart';
import '../modules/subjects/bindings/subjects_binding.dart';
import '../modules/subjects/views/subjects_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SUBJECT_PAGE;

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
      name: _Paths.SUBJECT_PAGE,
      page: () => const SubjectPageView(),
      binding: SubjectPageBinding(),
    ),
    GetPage(
      name: _Paths.SUB_SUBJECT_PAGE,
      page: () => const SubSubjectPageView(),
      binding: SubSubjectPageBinding(),
    ),
    GetPage(
      name: _Paths.QUESTION_PAGE,
      page: () => const QuestionPageView(),
      binding: QuestionPageBinding(),
    ),
  ];
}
