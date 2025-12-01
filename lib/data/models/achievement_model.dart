import 'package:flutter/material.dart';

enum AchievementCategory {
  streaks,
  completions,
  habits,
  milestones,
}

class AchievementModel {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final String iconEmoji; // Awesome emoji icon
  final List<Color> gradientColors; // Gradient for icon background
  final AchievementCategory category;
  final int? requirement;
  final int xpReward;

  const AchievementModel({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.iconEmoji,
    required this.gradientColors,
    required this.category,
    this.requirement,
    required this.xpReward,
  });

  static const List<AchievementModel> allAchievements = [
    // Streak achievements (🔥 Fire/Flame)
    AchievementModel(
      id: 'streak_7',
      name: '7-Day Streak',
      description: 'Complete a habit for 7 days in a row',
      icon: Icons.local_fire_department,
      iconEmoji: '🔥',
      gradientColors: [Color(0xFFFF6B6B), Color(0xFFFF4444)],
      category: AchievementCategory.streaks,
      requirement: 7,
      xpReward: 50,
    ),
    AchievementModel(
      id: 'streak_30',
      name: '30-Day Streak',
      description: 'Complete a habit for 30 days in a row',
      icon: Icons.whatshot,
      iconEmoji: '🔥',
      gradientColors: [Color(0xFFFF8C00), Color(0xFFFF6347)],
      category: AchievementCategory.streaks,
      requirement: 30,
      xpReward: 200,
    ),
    AchievementModel(
      id: 'streak_100',
      name: '100-Day Streak',
      description: 'Complete a habit for 100 days in a row',
      icon: Icons.local_fire_department_outlined,
      iconEmoji: '🔥',
      gradientColors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
      category: AchievementCategory.streaks,
      requirement: 100,
      xpReward: 500,
    ),

    // Completion achievements (⭐ Stars)
    AchievementModel(
      id: 'first_completion',
      name: 'First Step',
      description: 'Complete your first habit',
      icon: Icons.star,
      iconEmoji: '⭐',
      gradientColors: [Color(0xFFFFC837), Color(0xFFFF8008)],
      category: AchievementCategory.completions,
      requirement: 1,
      xpReward: 10,
    ),
    AchievementModel(
      id: 'completions_10',
      name: 'Getting Started',
      description: 'Complete habits 10 times',
      icon: Icons.star_half,
      iconEmoji: '⭐',
      gradientColors: [Color(0xFFFFD700), Color(0xFFFFA500)],
      category: AchievementCategory.completions,
      requirement: 10,
      xpReward: 25,
    ),
    AchievementModel(
      id: 'completions_50',
      name: 'Habit Builder',
      description: 'Complete habits 50 times',
      icon: Icons.stars,
      iconEmoji: '💎',
      gradientColors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
      category: AchievementCategory.completions,
      requirement: 50,
      xpReward: 100,
    ),
    AchievementModel(
      id: 'completions_100',
      name: 'Habit Master',
      description: 'Complete habits 100 times',
      icon: Icons.emoji_events,
      iconEmoji: '🏅',
      gradientColors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
      category: AchievementCategory.completions,
      requirement: 100,
      xpReward: 250,
    ),
    AchievementModel(
      id: 'completions_500',
      name: 'Legendary',
      description: 'Complete habits 500 times',
      icon: Icons.military_tech,
      iconEmoji: '👑',
      gradientColors: [Color(0xFFFFD700), Color(0xFFDAA520)],
      category: AchievementCategory.completions,
      requirement: 500,
      xpReward: 1000,
    ),

    // Habit achievements (🚀 Rocket for progress)
    AchievementModel(
      id: 'first_habit',
      name: 'First Habit',
      description: 'Create your first habit',
      icon: Icons.add_circle,
      iconEmoji: '🚀',
      gradientColors: [Color(0xFF667EEA), Color(0xFF764BA2)],
      category: AchievementCategory.habits,
      requirement: 1,
      xpReward: 10,
    ),
    AchievementModel(
      id: 'habits_5',
      name: 'Habit Collector',
      description: 'Create 5 habits',
      icon: Icons.collections_bookmark,
      iconEmoji: '🎯',
      gradientColors: [Color(0xFF11998E), Color(0xFF38EF7D)],
      category: AchievementCategory.habits,
      requirement: 5,
      xpReward: 50,
    ),
    AchievementModel(
      id: 'habits_10',
      name: 'Habit Enthusiast',
      description: 'Create 10 habits',
      icon: Icons.dashboard,
      iconEmoji: '💪',
      gradientColors: [Color(0xFFFF6B6B), Color(0xFFFF8E53)],
      category: AchievementCategory.habits,
      requirement: 10,
      xpReward: 100,
    ),

    // Milestone achievements (🏆 various)
    AchievementModel(
      id: 'perfect_day',
      name: 'Perfect Day',
      description: 'Complete all habits in a single day',
      icon: Icons.celebration,
      iconEmoji: '🏆',
      gradientColors: [Color(0xFFF7971E), Color(0xFFFFD200)],
      category: AchievementCategory.milestones,
      xpReward: 50,
    ),
    AchievementModel(
      id: 'week_warrior',
      name: 'Week Warrior',
      description: 'Complete all habits for a full week',
      icon: Icons.calendar_today,
      iconEmoji: '💎',
      gradientColors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
      category: AchievementCategory.milestones,
      xpReward: 100,
    ),
    AchievementModel(
      id: 'monthly_master',
      name: 'Monthly Master',
      description: 'Complete all habits for a full month',
      icon: Icons.calendar_month,
      iconEmoji: '👑',
      gradientColors: [Color(0xFFFFD700), Color(0xFFFFE55C)],
      category: AchievementCategory.milestones,
      xpReward: 500,
    ),
    AchievementModel(
      id: 'level_5',
      name: 'Level 5',
      description: 'Reach level 5',
      icon: Icons.leaderboard,
      iconEmoji: '⭐',
      gradientColors: [Color(0xFF8B7CF6), Color(0xFFE879A9)],
      category: AchievementCategory.milestones,
      requirement: 5,
      xpReward: 100,
    ),
    AchievementModel(
      id: 'level_10',
      name: 'Level 10',
      description: 'Reach level 10',
      icon: Icons.leaderboard,
      iconEmoji: '💎',
      gradientColors: [Color(0xFF4FD1C5), Color(0xFF8B7CF6)],
      category: AchievementCategory.milestones,
      requirement: 10,
      xpReward: 250,
    ),
    AchievementModel(
      id: 'level_25',
      name: 'Level 25',
      description: 'Reach level 25',
      icon: Icons.leaderboard,
      iconEmoji: '👑',
      gradientColors: [Color(0xFFFFD700), Color(0xFFFFA500)],
      category: AchievementCategory.milestones,
      requirement: 25,
      xpReward: 500,
    ),
  ];

  static AchievementModel? getById(String id) {
    try {
      return allAchievements.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<AchievementModel> getByCategory(AchievementCategory category) {
    return allAchievements.where((a) => a.category == category).toList();
  }
}
