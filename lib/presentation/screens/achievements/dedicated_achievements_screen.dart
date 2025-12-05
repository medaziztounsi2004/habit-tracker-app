import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/achievement_model.dart';
import '../../../providers/habit_provider.dart';
import '../../widgets/common/glass_container.dart';
import '../../widgets/common/galaxy_background.dart';

/// Dedicated Achievements page for viewing all achievements with progress.
/// This is separate from the Crystal Stones (AchievementsScreen) collection.
class DedicatedAchievementsScreen extends StatefulWidget {
  const DedicatedAchievementsScreen({super.key});

  @override
  State<DedicatedAchievementsScreen> createState() =>
      _DedicatedAchievementsScreenState();
}

class _DedicatedAchievementsScreenState
    extends State<DedicatedAchievementsScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Streaks',
    'Completions',
    'Habits',
    'Milestones'
  ];

  @override
  Widget build(BuildContext context) {
    return GalaxyBackground(
      child: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          final user = habitProvider.user;
          final unlockedAchievements = user?.unlockedAchievements ?? [];
          final allAchievements = AchievementModel.allAchievements;

          // Filter by category
          final filteredAchievements = _selectedCategory == 'All'
              ? allAchievements
              : allAchievements.where((a) {
                  switch (_selectedCategory) {
                    case 'Streaks':
                      return a.category == AchievementCategory.streaks;
                    case 'Completions':
                      return a.category == AchievementCategory.completions;
                    case 'Habits':
                      return a.category == AchievementCategory.habits;
                    case 'Milestones':
                      return a.category == AchievementCategory.milestones;
                    default:
                      return true;
                  }
                }).toList();

          final unlockedCount = unlockedAchievements.length;
          final totalCount = allAchievements.length;

          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Achievements',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Summary
                  FadeInDown(
                    duration: const Duration(milliseconds: 400),
                    child: _buildProgressSummary(
                      context,
                      unlockedCount,
                      totalCount,
                      habitProvider.totalXP,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Category Filter
                  FadeInUp(
                    duration: const Duration(milliseconds: 400),
                    delay: const Duration(milliseconds: 100),
                    child: _buildCategoryFilter(),
                  ),
                  const SizedBox(height: 20),

                  // Achievements Grid
                  AnimationLimiter(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: filteredAchievements.length,
                      itemBuilder: (context, index) {
                        final achievement = filteredAchievements[index];
                        final isUnlocked =
                            unlockedAchievements.contains(achievement.id);
                        final progress = _calculateProgress(
                          achievement,
                          habitProvider,
                          isUnlocked,
                        );

                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 400),
                          columnCount: 2,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: _buildAchievementCard(
                                context,
                                achievement,
                                isUnlocked,
                                progress,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProgressSummary(
    BuildContext context,
    int unlockedCount,
    int totalCount,
    int totalXP,
  ) {
    final progress = totalCount > 0 ? unlockedCount / totalCount : 0.0;

    return GlassContainer(
      padding: const EdgeInsets.all(20),
      useBackdropFilter: true,
      child: Column(
        children: [
          Row(
            children: [
              // Trophy icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: AppColors.goldGradient,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.goldAccent.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.emoji_events,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$unlockedCount / $totalCount',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Achievements Unlocked',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              AppColors.goldGradient.createShader(bounds),
                          child: const Icon(
                            Iconsax.flash_15,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$totalXP Total XP',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.goldAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.goldAccent,
              ),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          final isSelected = _selectedCategory == category;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() {
                  _selectedCategory = category;
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  gradient: isSelected ? AppColors.primaryGradient : null,
                  color: isSelected ? null : Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color:
                        isSelected ? Colors.white : Colors.white.withOpacity(0.7),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildAchievementCard(
    BuildContext context,
    AchievementModel achievement,
    bool isUnlocked,
    double progress,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        _showAchievementDetails(context, achievement, isUnlocked, progress);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isUnlocked
                ? achievement.gradientColors.first.withOpacity(0.5)
                : Colors.white.withOpacity(0.1),
            width: 1,
          ),
          boxShadow: isUnlocked
              ? [
                  BoxShadow(
                    color: achievement.gradientColors.first.withOpacity(0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Badge icon with progress ring
            SizedBox(
              width: 64,
              height: 64,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Progress ring
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 4,
                      backgroundColor: Colors.white.withOpacity(0.1),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isUnlocked
                            ? achievement.gradientColors.first
                            : AppColors.primaryPurple,
                      ),
                    ),
                  ),
                  // Icon
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: isUnlocked
                          ? LinearGradient(colors: achievement.gradientColors)
                          : null,
                      color: isUnlocked ? null : Colors.white.withOpacity(0.1),
                    ),
                    child: Icon(
                      achievement.icon,
                      size: 24,
                      color: isUnlocked
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Name
            Text(
              achievement.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color:
                    isUnlocked ? Colors.white : Colors.white.withOpacity(0.7),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            // Status
            if (isUnlocked)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: achievement.gradientColors),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Unlocked',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
            else
              Text(
                '${(progress * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
            const SizedBox(height: 4),
            // XP reward
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.goldGradient.createShader(bounds),
                  child: const Icon(
                    Iconsax.flash_15,
                    size: 12,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '+${achievement.xpReward} XP',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.goldAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  double _calculateProgress(
    AchievementModel achievement,
    HabitProvider habitProvider,
    bool isUnlocked,
  ) {
    if (isUnlocked) return 1.0;

    if (achievement.requirement == null) {
      // For achievements without requirements (like perfect_day)
      if (achievement.id == 'perfect_day') {
        return habitProvider.getTodayProgress();
      }
      return 0.0;
    }

    switch (achievement.category) {
      case AchievementCategory.streaks:
        return (habitProvider.currentMaxStreak / achievement.requirement!)
            .clamp(0.0, 1.0);
      case AchievementCategory.completions:
        return (habitProvider.totalCompletions / achievement.requirement!)
            .clamp(0.0, 1.0);
      case AchievementCategory.habits:
        return (habitProvider.totalHabits / achievement.requirement!)
            .clamp(0.0, 1.0);
      case AchievementCategory.milestones:
        if (achievement.id.startsWith('level_')) {
          return (habitProvider.level / achievement.requirement!)
              .clamp(0.0, 1.0);
        }
        return 0.0;
    }
  }

  void _showAchievementDetails(
    BuildContext context,
    AchievementModel achievement,
    bool isUnlocked,
    double progress,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            // Achievement icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isUnlocked
                    ? LinearGradient(colors: achievement.gradientColors)
                    : null,
                color: isUnlocked ? null : Colors.white.withOpacity(0.1),
                boxShadow: isUnlocked
                    ? [
                        BoxShadow(
                          color:
                              achievement.gradientColors.first.withOpacity(0.4),
                          blurRadius: 24,
                          spreadRadius: 4,
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                achievement.icon,
                size: 48,
                color:
                    isUnlocked ? Colors.white : Colors.white.withOpacity(0.4),
              ),
            ),
            const SizedBox(height: 20),
            // Name
            Text(
              achievement.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Description
            Text(
              achievement.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            // Progress bar
            if (!isUnlocked) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    achievement.gradientColors.first,
                  ),
                  minHeight: 10,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(progress * 100).toInt()}% Complete',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
            if (isUnlocked)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: achievement.gradientColors),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  '✓ Unlocked!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            // XP reward
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.goldGradient.createShader(bounds),
                  child: const Icon(
                    Iconsax.flash_15,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '+${achievement.xpReward} XP Reward',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.goldAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
