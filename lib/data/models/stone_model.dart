import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'stone_model.g.dart';

@HiveType(typeId: 4)
class StoneModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String emoji;

  @HiveField(3)
  String description;

  @HiveField(4)
  List<int> themeColorValues; // Store as RGB values

  @HiveField(5)
  String rarity;

  @HiveField(6)
  bool isUnlocked;

  @HiveField(7)
  String unlockCondition;

  @HiveField(8)
  DateTime? unlockedAt;

  StoneModel({
    required this.id,
    required this.name,
    required this.emoji,
    required this.description,
    required this.themeColorValues,
    required this.rarity,
    this.isUnlocked = false,
    required this.unlockCondition,
    this.unlockedAt,
  });

  // Helper to convert color values to Colors
  List<Color> get themeColors {
    return themeColorValues.map((value) => Color(value)).toList();
  }

  // Helper to set colors
  void setThemeColors(List<Color> colors) {
    themeColorValues = colors.map((color) => color.value).toList();
  }

  StoneModel copyWith({
    String? id,
    String? name,
    String? emoji,
    String? description,
    List<int>? themeColorValues,
    String? rarity,
    bool? isUnlocked,
    String? unlockCondition,
    DateTime? unlockedAt,
  }) {
    return StoneModel(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      description: description ?? this.description,
      themeColorValues: themeColorValues ?? this.themeColorValues,
      rarity: rarity ?? this.rarity,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockCondition: unlockCondition ?? this.unlockCondition,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }
}

// Stone rarity levels
class StoneRarity {
  static const String common = 'common';
  static const String rare = 'rare';
  static const String epic = 'epic';
  static const String legendary = 'legendary';
}
