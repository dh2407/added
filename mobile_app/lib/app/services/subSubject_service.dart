import 'package:added/app/data/models/models.dart';
import 'package:hive/hive.dart';

class SubSubjectService {
  Future<List<SubSubject>> getSubSubjects(String subjectUname) async {
    var subSubjectBox = await Hive.openBox<SubSubject>('subsubjects');
    return subSubjectBox.values.where((subSubject) => subSubject.subject.uname == subjectUname).toList();
  }
}
