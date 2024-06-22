import 'package:added/app/data/models/subsubject/subsubject.dart';
import 'package:hive/hive.dart';

part 'flashcard.g.dart';

@HiveType(typeId: 2)
class FlashCard extends HiveObject {
  @HiveField(0)
  String uname;

  @HiveField(1)
  SubSubject subSubject;

  @HiveField(2)
  String question;

  @HiveField(3)
  String response;

  FlashCard({
    required this.uname,
    required this.subSubject,
    required this.question,
    required this.response,
  });
}
