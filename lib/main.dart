import 'package:added/app/data/initial_data.dart';
import 'package:added/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Register the Hive adapters
  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(SubSubjectAdapter());
  Hive.registerAdapter(FlashCardAdapter());

  // Open the boxes
  var subjectBox = await Hive.openBox<Subject>('subjects');
  var subSubjectBox = await Hive.openBox<SubSubject>('subsubjects');
  var flashCardBox = await Hive.openBox<FlashCard>('flashcards');

  // Seed the database if the boxes are empty
  if (subjectBox.isEmpty) {
    List<Subject> subjects = createInitialSubjects();

    for (Subject subject in subjects) {
      // Add subjects to the Hive box
      await subjectBox.put(subject.uname, subject);

      // Create subsubjects for each subject
      List<SubSubject> subSubjects = createSubSubjects(subject);
      for (SubSubject subSubject in subSubjects) {
        // Add subsubjects to the Hive box
        await subSubjectBox.put(subSubject.uname, subSubject);

        // Create flashcards for each subsubject
        List<FlashCard> flashCards = createFlashCards(subSubject);
        for (FlashCard flashCard in flashCards) {
          // Add flashcards to the Hive box
          await flashCardBox.put(flashCard.uname, flashCard);
        }
      }
    }
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "عداد",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar", "AE"),
      ],
      locale: const Locale("ar", "AE"),
    );
  }
}
