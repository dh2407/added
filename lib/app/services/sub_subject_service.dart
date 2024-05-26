import 'package:added/app/data/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SubSubjectService {
  static Future<List<SubSubject>> fetchSubSubjectsBySubjectId(String subjectId) async {
    var box = await Hive.openBox<SubSubject>('subSubjects');
    return box.values
        .where((subSubject) => subSubject.subjectId == subjectId)
        .cast<SubSubject>()
        .toList();
  }
}
