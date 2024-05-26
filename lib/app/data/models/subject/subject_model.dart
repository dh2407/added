import 'package:hive/hive.dart';

part 'subject_model.g.dart';

@HiveType(typeId: 0)
class Subject extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  Subject({required this.id, required this.title});
}
