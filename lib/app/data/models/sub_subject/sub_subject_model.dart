import 'package:added/app/data/models/flash_card/flash_card_model.dart';
import 'package:hive/hive.dart';

part 'sub_subject_model.g.dart';

@HiveType(typeId: 1)
class SubSubject extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String subjectId;

  @HiveField(3)
  late List<FlashCard> flashCards;

  SubSubject({required this.id, required this.title, required this.subjectId, required this.flashCards});
}