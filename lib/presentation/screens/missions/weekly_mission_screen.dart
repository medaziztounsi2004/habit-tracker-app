import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/helpers.dart';
import '../../../providers/habit_provider.dart';
import '../../widgets/common/galaxy_background.dart';
import '../../widgets/common/glass_container.dart';

/// Weekly Mission/Target view showing weekly progress and goals.
class WeeklyMissionScreen extends StatefulWidget {
  const WeeklyMissionScreen({super.key});

  @override
  State<WeeklyMissionScreen> createState() => _WeeklyMissionScreenState();
}

class _WeeklyMissionScreenState extends State<WeeklyMissionScreen> {
  List<DateTime> _currentWeekDates = [];

  @override
  void initState() {
    super.initState();
    _currentWeekDates = Helpers.getCurrentWeekDates();
  }

  @override
  Widget build(BuildContext context) {
    return GalaxyBackground(
      child: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          // Calculate weekly stats
          final weeklyAchievedDays = _computeWeeklyAchievedDays(habitProvider);
          const weeklyTargetDays = 5;
          const weeklyRewardXP = 100;
          final isComplete = weeklyAchievedDays >= weeklyTargetDays;
          final progress = (weeklyAchievedDays / weeklyTargetDays).clamp(0.0, 1.0);

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
                'Weekly Mission',
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
                  // Mission Card
                  FadeInDown(
                    duration: const Duration(milliseconds: 400),
                    child: _buildMissionCard(
                      context,
                      weeklyAchievedDays,
                      weeklyTargetDays,
                      weeklyRewardXP,
                      isComplete,
                      progress,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Week Progress
                  FadeInUp(
                    duration: const Duration(milliseconds: 400),
                    delay: const Duration(milliseconds: 100),
                    child: _buildWeekProgress(habitProvider),
                  ),
                  const SizedBox(height: 24),

                  // Stats Summary
                  FadeInUp(
                    duration: const Duration(milliseconds: 400),
                    delay: const Duration(milliseconds: 200),
                    child: _buildStatsSummary(habitProvider),
                  ),
                  const SizedBox(height: 24),

                  // Tips Section
                  FadeInUp(
                    duration: const Duration(milliseconds: 400),
                    delay: const Duration(milliseconds: 300),
                    child: _buildTipsSection(),
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

  Widget _buildMissionCard(
    BuildContext context,
    int achievedDays,
    int targetDays,
    int rewardXP,
    bool isComplete,
    double progress,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: isComplete ? AppColors.cyanPurpleGradient : null,
        color: isComplete ? null : Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isComplete
              ? Colors.transparent
              : AppColors.primaryPurple.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isComplete
                ? AppColors.accentCyan.withOpacity(0.3)
                : Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Progress circle
              SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 8,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                    Icon(
                      isComplete ? Icons.check : Iconsax.cup5,
                      size: 32,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isComplete ? 'Mission Complete!' : 'Weekly Goal',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Complete all habits on $targetDays days this week',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Iconsax.flash_15,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '+$rewardXP XP Reward',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Day indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(targetDays, (index) {
              final isAchieved = index < achievedDays;
              return Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAchieved
                      ? Colors.white
                      : Colors.white.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isAchieved
                      ? Icon(
                          Icons.check,
                          size: 24,
                          color: isComplete
                              ? AppColors.accentCyan
                              : AppColors.primaryPurple,
                        )
                      : Text(
                          '${index + 1}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekProgress(HabitProvider habitProvider) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      useBackdropFilter: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Iconsax.calendar_1,
                  size: 20,
                  color: AppColors.primaryPurple,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'This Week',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Week days grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _currentWeekDates.map((date) {
              final dayName = _getDayName(date.weekday);
              final isToday = Helpers.isToday(date);
              final completion = _getDayCompletion(habitProvider, date);

              return Column(
                children: [
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                      color: isToday
                          ? AppColors.accentCyan
                          : Colors.white.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: completion >= 1.0
                          ? AppColors.cyanPurpleGradient
                          : null,
                      color: completion >= 1.0
                          ? null
                          : completion > 0
                              ? AppColors.primaryPurple.withOpacity(0.3)
                              : Colors.white.withOpacity(0.1),
                      border: isToday
                          ? Border.all(
                              color: AppColors.accentCyan,
                              width: 2,
                            )
                          : null,
                    ),
                    child: Center(
                      child: completion >= 1.0
                          ? const Icon(
                              Icons.check,
                              size: 18,
                              color: Colors.white,
                            )
                          : Text(
                              '${date.day}',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSummary(HabitProvider habitProvider) {
    return Row(
      children: [
        Expanded(
          child: GlassContainer(
            padding: const EdgeInsets.all(16),
            useBackdropFilter: true,
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_fire_department,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${habitProvider.currentMaxStreak}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Day Streak',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: GlassContainer(
            padding: const EdgeInsets.all(16),
            useBackdropFilter: true,
            child: Column(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: AppColors.cyanPurpleGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '${habitProvider.totalCompletions}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Completions',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTipsSection() {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      useBackdropFilter: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.goldAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Iconsax.lamp_on5,
                  size: 20,
                  color: AppColors.goldAccent,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Tips to Complete',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildTipItem('Start with easiest habits first'),
          _buildTipItem('Set reminders for each habit'),
          _buildTipItem('Complete habits at the same time daily'),
          _buildTipItem('Celebrate small wins'),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.accentCyan,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              tip,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int _computeWeeklyAchievedDays(HabitProvider habitProvider) {
    int achievedDays = 0;

    for (final date in _currentWeekDates) {
      final dateKey = Helpers.formatDateForStorage(date);
      final habitsForDate = habitProvider
          .getHabitsForDate(date)
          .where((h) => !h.isQuitHabit)
          .toList();

      if (habitsForDate.isEmpty) continue;

      final completedCount =
          habitsForDate.where((h) => h.isCompletedOn(dateKey)).length;
      if (completedCount == habitsForDate.length) {
        achievedDays++;
      }
    }

    return achievedDays;
  }

  double _getDayCompletion(HabitProvider habitProvider, DateTime date) {
    final dateKey = Helpers.formatDateForStorage(date);
    final habitsForDate = habitProvider
        .getHabitsForDate(date)
        .where((h) => !h.isQuitHabit)
        .toList();

    if (habitsForDate.isEmpty) return 0.0;

    final completedCount =
        habitsForDate.where((h) => h.isCompletedOn(dateKey)).length;
    return completedCount / habitsForDate.length;
  }

  String _getDayName(int weekday) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return days[weekday - 1];
  }
}
