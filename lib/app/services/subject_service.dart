import 'package:added/app/data/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SubjectService {
  static Future<Subject?> fetchSubjectById(String id) async {
    var box = await Hive.openBox<Subject>('subjects');
    return box.values.firstWhere((subject) => subject.id == id);
  }
}
