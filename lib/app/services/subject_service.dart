import 'package:added/app/data/models/models.dart';
import 'package:hive/hive.dart';

class SubjectService {
  Future<List<Subject>> getSubjects() async {
    var subjectBox = await Hive.openBox<Subject>('subjects');
    return subjectBox.values.toList();
  }
}