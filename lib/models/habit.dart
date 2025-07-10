import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  DateTime createdAt;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  List <String> completedDates;

  Habit({
    required this.name,
    required this.createdAt,
    this.isCompleted = false,
    List<String> completedDates = [],
  }) : completedDates = completedDates;
}