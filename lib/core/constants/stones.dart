import 'package:flutter/material.dart';
import '../models/stone_model.dart';

class StonesConstants {
  static List<StoneModel> getAllStones() {
    return [
      StoneModel(
        id: 'starter_crystal',
        name: 'Starter Crystal',
        emoji: '✨',
        description: 'A shimmering crystal to begin your journey',
        themeColorValues: [
          const Color(0xFF7C3AED).value, // Primary purple
          const Color(0xFFEC4899).value, // Secondary pink
          const Color(0xFF06B6D4).value, // Accent cyan
        ],
        rarity: StoneRarity.common,
        unlockCondition: 'Complete onboarding',
      ),
      StoneModel(
        id: 'amethyst',
        name: 'Amethyst',
        emoji: '💜',
        description: 'A mystical purple gem of wisdom',
        themeColorValues: [
          const Color(0xFF7C3AED).value, // Deep purple
          const Color(0xFF9F7AEA).value, // Violet
          const Color(0xFFB794F4).value, // Light purple
        ],
        rarity: StoneRarity.common,
        unlockCondition: 'Achieve 7-day streak',
      ),
      StoneModel(
        id: 'ruby',
        name: 'Ruby',
        emoji: '❤️',
        description: 'A passionate red stone of dedication',
        themeColorValues: [
          const Color(0xFFDC2626).value, // Red
          const Color(0xFFEF4444).value, // Light red
          const Color(0xFFF87171).value, // Crimson
        ],
        rarity: StoneRarity.common,
        unlockCondition: 'Complete 10 habits',
      ),
      StoneModel(
        id: 'emerald',
        name: 'Emerald',
        emoji: '💚',
        description: 'A vibrant green stone of growth',
        themeColorValues: [
          const Color(0xFF059669).value, // Green
          const Color(0xFF10B981).value, // Emerald
          const Color(0xFF34D399).value, // Teal
        ],
        rarity: StoneRarity.rare,
        unlockCondition: 'Achieve perfect week',
      ),
      StoneModel(
        id: 'sapphire',
        name: 'Sapphire',
        emoji: '🔵',
        description: 'A deep blue stone of tranquility',
        themeColorValues: [
          const Color(0xFF1E40AF).value, // Navy
          const Color(0xFF3B82F6).value, // Blue
          const Color(0xFF60A5FA).value, // Light blue
        ],
        rarity: StoneRarity.rare,
        unlockCondition: 'Achieve 30-day streak',
      ),
      StoneModel(
        id: 'topaz',
        name: 'Topaz',
        emoji: '🧡',
        description: 'A warm golden stone of energy',
        themeColorValues: [
          const Color(0xFFEA580C).value, // Orange
          const Color(0xFFF59E0B).value, // Amber
          const Color(0xFFFBBF24).value, // Gold
        ],
        rarity: StoneRarity.rare,
        unlockCondition: 'Complete 50 habits',
      ),
      StoneModel(
        id: 'diamond',
        name: 'Diamond',
        emoji: '💎',
        description: 'A brilliant crystal of perfection',
        themeColorValues: [
          const Color(0xFFE0F2FE).value, // Ice blue
          const Color(0xFFFFFFFF).value, // White
          const Color(0xFFBAE6FD).value, // Crystal
        ],
        rarity: StoneRarity.epic,
        unlockCondition: 'Achieve 100-day streak',
      ),
      StoneModel(
        id: 'obsidian',
        name: 'Obsidian',
        emoji: '🖤',
        description: 'A powerful dark stone of resilience',
        themeColorValues: [
          const Color(0xFF18181B).value, // Black
          const Color(0xFF27272A).value, // Dark gray
          const Color(0xFF6B21A8).value, // Dark purple
        ],
        rarity: StoneRarity.epic,
        unlockCondition: 'Quit a bad habit for 30 days',
      ),
      StoneModel(
        id: 'opal',
        name: 'Opal',
        emoji: '🌈',
        description: 'The ultimate rainbow stone of mastery',
        themeColorValues: [
          const Color(0xFFEC4899).value, // Pink
          const Color(0xFF8B5CF6).value, // Purple
          const Color(0xFF06B6D4).value, // Cyan
          const Color(0xFF10B981).value, // Green
          const Color(0xFFF59E0B).value, // Amber
        ],
        rarity: StoneRarity.legendary,
        unlockCondition: 'Unlock all other stones',
      ),
    ];
  }

  static StoneModel? getStoneById(String id) {
    try {
      return getAllStones().firstWhere((stone) => stone.id == id);
    } catch (e) {
      return null;
    }
  }

  // Check if stone should be unlocked based on user stats
  static bool checkUnlockCondition(
    String stoneId, {
    required bool onboardingCompleted,
    required int currentStreak,
    required int totalCompletions,
    required bool hasPerfectWeek,
    required int maxStreak,
    required bool hasQuit30Days,
    required int unlockedStonesCount,
  }) {
    switch (stoneId) {
      case 'starter_crystal':
        return onboardingCompleted;
      case 'amethyst':
        return currentStreak >= 7;
      case 'ruby':
        return totalCompletions >= 10;
      case 'emerald':
        return hasPerfectWeek;
      case 'sapphire':
        return maxStreak >= 30;
      case 'topaz':
        return totalCompletions >= 50;
      case 'diamond':
        return maxStreak >= 100;
      case 'obsidian':
        return hasQuit30Days;
      case 'opal':
        return unlockedStonesCount >= 8; // All other stones
      default:
        return false;
    }
  }
}
