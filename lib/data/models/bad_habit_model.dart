import 'package:hive/hive.dart';

part 'bad_habit_model.g.dart';

@HiveType(typeId: 3)
class BadHabitModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String iconEmoji;

  @HiveField(3)
  DateTime quitDate;

  @HiveField(4)
  List<DateTime> relapses;

  @HiveField(5)
  double moneySavedPerDay;

  @HiveField(6)
  String category;

  @HiveField(7)
  List<String> triggers;

  @HiveField(8)
  List<String> copingStrategies;

  @HiveField(9)
  bool isArchived;

  BadHabitModel({
    required this.id,
    required this.name,
    required this.iconEmoji,
    required this.quitDate,
    List<DateTime>? relapses,
    this.moneySavedPerDay = 0.0,
    required this.category,
    List<String>? triggers,
    List<String>? copingStrategies,
    this.isArchived = false,
  })  : relapses = relapses ?? [],
        triggers = triggers ?? [],
        copingStrategies = copingStrategies ?? [];

  // Calculate days since quitting
  int get daysSinceQuitting {
    final now = DateTime.now();
    return now.difference(quitDate).inDays;
  }

  // Calculate hours since quitting
  int get hoursSinceQuitting {
    final now = DateTime.now();
    return now.difference(quitDate).inHours;
  }

  // Calculate minutes since quitting
  int get minutesSinceQuitting {
    final now = DateTime.now();
    return now.difference(quitDate).inMinutes;
  }

  // Calculate seconds since quitting
  int get secondsSinceQuitting {
    final now = DateTime.now();
    return now.difference(quitDate).inSeconds;
  }

  // Calculate money saved
  double get moneySaved {
    return daysSinceQuitting * moneySavedPerDay;
  }

  // Get health benefits for specific habits
  List<HealthBenefit> get healthBenefits {
    switch (category.toLowerCase()) {
      case 'smoking':
        return _smokingBenefits;
      case 'alcohol':
        return _alcoholBenefits;
      default:
        return [];
    }
  }

  static final List<HealthBenefit> _smokingBenefits = [
    HealthBenefit(hours: 24, description: 'Blood pressure normalizing'),
    HealthBenefit(hours: 48, description: 'Nerve endings start regrowing'),
    HealthBenefit(hours: 72, description: 'Breathing becomes easier'),
    HealthBenefit(days: 7, description: 'Taste and smell improving'),
    HealthBenefit(days: 14, description: 'Circulation improving'),
    HealthBenefit(days: 30, description: 'Lung function increasing'),
    HealthBenefit(days: 90, description: 'Risk of heart disease decreasing'),
  ];

  static final List<HealthBenefit> _alcoholBenefits = [
    HealthBenefit(hours: 24, description: 'Blood sugar normalizing'),
    HealthBenefit(days: 3, description: 'Better sleep quality'),
    HealthBenefit(days: 7, description: 'More energy and focus'),
    HealthBenefit(days: 14, description: 'Skin looking healthier'),
    HealthBenefit(days: 30, description: 'Liver function improving'),
    HealthBenefit(days: 60, description: 'Mental clarity increasing'),
  ];

  BadHabitModel copyWith({
    String? id,
    String? name,
    String? iconEmoji,
    DateTime? quitDate,
    List<DateTime>? relapses,
    double? moneySavedPerDay,
    String? category,
    List<String>? triggers,
    List<String>? copingStrategies,
    bool? isArchived,
  }) {
    return BadHabitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      iconEmoji: iconEmoji ?? this.iconEmoji,
      quitDate: quitDate ?? this.quitDate,
      relapses: relapses ?? this.relapses,
      moneySavedPerDay: moneySavedPerDay ?? this.moneySavedPerDay,
      category: category ?? this.category,
      triggers: triggers ?? this.triggers,
      copingStrategies: copingStrategies ?? this.copingStrategies,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}

class HealthBenefit {
  final int? hours;
  final int? days;
  final String description;

  HealthBenefit({this.hours, this.days, required this.description});

  bool isAchieved(int hoursSinceQuitting, int daysSinceQuitting) {
    if (hours != null) return hoursSinceQuitting >= hours!;
    if (days != null) return daysSinceQuitting >= days!;
    return false;
  }
}
