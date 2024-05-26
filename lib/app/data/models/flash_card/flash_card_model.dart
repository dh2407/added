import 'package:hive/hive.dart';

part 'flash_card_model.g.dart';

@HiveType(typeId: 2)
class FlashCard extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String question;

  @HiveField(2)
  late String rightResponse;

  @HiveField(3)
  late List<String> wrongResponses;

  @HiveField(4)
  late String subSubjectId;

  @HiveField(5)
  DateTime? lastPlayedDate;

  @HiveField(6)
  String? lastPlayedStatus;

  @HiveField(7)
  int currentPlayingRank = 0;

  FlashCard({
    required this.id,
    required this.question,
    required this.rightResponse,
    required this.wrongResponses,
    required this.subSubjectId,
    this.lastPlayedDate,
    this.lastPlayedStatus,
    this.currentPlayingRank = 0,
  });
}
