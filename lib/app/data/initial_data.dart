import 'dart:convert';
import 'dart:math';

import 'package:added/app/data/models/models.dart';
import 'package:hive/hive.dart';

Future<List<Subject>> createInitialSubjects(List<String> subjectsNames) async {
  final List<Subject> subjects = [];
  for (int i = 1; i <= subjectsNames.length; i++) {
    final subject = Subject(id: '$i', title: subjectsNames[i-1]);
    subjects.add(subject);
  }
  return subjects;
}

Future<List<SubSubject>> createInitialSubSubjects(int numberOfRows, String subjectId) async {
  final List<SubSubject> subSubjects = [];
  for (int i = 1; i <= numberOfRows; i++) {
    final subSubject = SubSubject(
      id: '$i',
      title: '$i+',
      subjectId: subjectId,
      flashCards: [],
    );
    subSubjects.add(subSubject);
  }
  return subSubjects;
}

Future<List<FlashCard>> createInitialFlashCards(int numberOfRows, String subSubjectId) async {
  final List<FlashCard> flashCards = [];
  for (int i = 1; i <= numberOfRows; i++) {
    final question = '$subSubjectId+$i=';
    final rightResponse = (int.parse(subSubjectId) + i).toString();
    final List<String> wrongResponses = [];
    final random = Random();
    while (wrongResponses.length < 5) {
      final wrongResponse = random.nextInt(10).toString();
      if (wrongResponse != rightResponse && !wrongResponses.contains(wrongResponse)) {
        wrongResponses.add(wrongResponse);
      }
    }


    final flashCard = FlashCard(
      id: 'flashCard_${i}_subsub_$subSubjectId',
      question: question,
      rightResponse: rightResponse,
      wrongResponses: wrongResponses,
      subSubjectId: subSubjectId
    );
    flashCards.add(flashCard);
  }
  return flashCards;
}

Future<void> createInitialData() async {
  final subjectBox = await getOrOpenBox('subjects');
  final subSubjectBox = await getOrOpenBox('subSubjects');
  final flashCardBox = await getOrOpenBox('flashCards');

  final List<Subject> subjects = await createInitialSubjects(["الجمع"]);
  for (var subject in subjects) {
    await subjectBox.put(subject.id, subject);
  }

  final List<SubSubject> subSubjects = await createInitialSubSubjects(9, subjects.first.id); // only جمع for now
  for (var subSubject in subSubjects) {
    await subSubjectBox.put(subSubject.id, subSubject);

    final List<FlashCard> flashCards = await createInitialFlashCards(9, subSubject.id);
    for (var flashCard in flashCards) {
      await flashCardBox.put(flashCard.id, flashCard);
    }
  }

  if (Hive.isBoxOpen('subjects')) subjectBox.close();
  if (Hive.isBoxOpen('subSubjects')) subSubjectBox.close();
  if (Hive.isBoxOpen('flashCards')) flashCardBox.close();
}


Future<Box> getOrOpenBox(String boxName) async {
  if (Hive.isBoxOpen(boxName)) {
    return Hive.box(boxName);
  } else {
    final hiveBox = await Hive.openBox(boxName);
    return Hive.box(boxName);
  }
}

Future<void> showBoxContent(String boxName) async {
  final box = await getOrOpenBox(boxName);
  final jsonData = <String, dynamic>{};
  for (var key in box.keys) {
    jsonData[key] = box.get(key)?.toJson();
  }

  final jsonString = jsonEncode(jsonData);
  print('Content of $boxName: ${jsonString}');

  // await box.close();
}

Future<void> initHiveData() async {
    await Hive.deleteBoxFromDisk('subjects');
    await Hive.deleteBoxFromDisk('subSubjects');
    await Hive.deleteBoxFromDisk('flashCards');
    await createInitialData();
}