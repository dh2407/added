import 'package:hive/hive.dart';

part 'subject.g.dart';

@HiveType(typeId: 0)
class Subject extends HiveObject {
  @HiveField(0)
  String uname;

  @HiveField(1)
  String title;

  Subject({
    required this.uname,
    required this.title,
  });
}