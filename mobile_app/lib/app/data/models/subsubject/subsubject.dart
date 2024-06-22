import 'package:added/app/data/models/subject/subject.dart';
import 'package:hive/hive.dart';

part 'subsubject.g.dart';

@HiveType(typeId: 1)
class SubSubject extends HiveObject {
  @HiveField(0)
  String uname;

  @HiveField(1)
  String title;

  @HiveField(2)
  Subject subject;

  SubSubject({
    required this.uname,
    required this.title,
    required this.subject,
  });
}
