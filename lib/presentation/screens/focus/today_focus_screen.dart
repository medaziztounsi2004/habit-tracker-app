import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/helpers.dart';
import '../../../providers/habit_provider.dart';
import '../../../data/models/habit_model.dart';
import '../../widgets/common/galaxy_background.dart';
import '../../widgets/common/glass_container.dart';
import '../add_habit/add_habit_screen.dart';

/// Dedicated Today's Focus page showing habits due today with urgency coloring,
/// XP reward, and quick actions.
class TodayFocusScreen extends StatefulWidget {
  const TodayFocusScreen({super.key});

  @override
  State<TodayFocusScreen> createState() => _TodayFocusScreenState();
}

class _TodayFocusScreenState extends State<TodayFocusScreen> {
  @override
  Widget build(BuildContext context) {
    return GalaxyBackground(
      child: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          final todayHabits = habitProvider.todayHabits
              .where((h) => !h.isQuitHabit)
              .toList();
          final dateKey = Helpers.formatDateForStorage(DateTime.now());
          final completedCount =
              todayHabits.where((h) => h.isCompletedOn(dateKey)).length;
          final remainingCount = todayHabits.length - completedCount;
          final progress = todayHabits.isEmpty
              ? 0.0
              : completedCount / todayHabits.length;
          final allCompleted = remainingCount == 0 && todayHabits.isNotEmpty;

          // Determine urgent habits (past reminder time)
          final now = DateTime.now();
          final urgentHabits = todayHabits.where((h) {
            if (h.isCompletedOn(dateKey)) return false;
            if (h.reminderTime == null) return false;
            try {
              final parts = h.reminderTime!.split(':');
              final reminderHour = int.parse(parts[0]);
              final reminderMinute = int.parse(parts[1]);
              return now.hour > reminderHour ||
                  (now.hour == reminderHour && now.minute > reminderMinute);
            } catch (e) {
              return false;
            }
          }).toList();

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
                "Today's Focus",
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
                  // Progress Summary Card
                  FadeInDown(
                    duration: const Duration(milliseconds: 400),
                    child: _buildProgressSummary(
                      context,
                      progress,
                      completedCount,
                      todayHabits.length,
                      allCompleted,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Urgent Section (if any)
                  if (urgentHabits.isNotEmpty) ...[
                    FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 100),
                      child: _buildSectionHeader(
                        'Urgent',
                        Icons.warning_rounded,
                        AppColors.warning,
                        '${urgentHabits.length} overdue',
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...urgentHabits.asMap().entries.map((entry) {
                      return FadeInUp(
                        duration: const Duration(milliseconds: 400),
                        delay: Duration(milliseconds: 150 + entry.key * 50),
                        child: _buildHabitCard(
                          context,
                          habitProvider,
                          entry.value,
                          dateKey,
                          isUrgent: true,
                        ),
                      );
                    }),
                    const SizedBox(height: 24),
                  ],

                  // All Habits Section
                  FadeInUp(
                    duration: const Duration(milliseconds: 400),
                    delay: const Duration(milliseconds: 200),
                    child: _buildSectionHeader(
                      "Today's Habits",
                      Iconsax.task_square5,
                      AppColors.primaryPurple,
                      '$completedCount/${todayHabits.length} done',
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (todayHabits.isEmpty)
                    FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 250),
                      child: _buildEmptyState(context),
                    )
                  else
                    ...todayHabits.asMap().entries.map((entry) {
                      final isUrgent = urgentHabits.contains(entry.value);
                      return FadeInUp(
                        duration: const Duration(milliseconds: 400),
                        delay: Duration(milliseconds: 250 + entry.key * 50),
                        child: _buildHabitCard(
                          context,
                          habitProvider,
                          entry.value,
                          dateKey,
                          isUrgent: isUrgent,
                        ),
                      );
                    }),

                  const SizedBox(height: 24),

                  // Complete All Button
                  if (!allCompleted && todayHabits.isNotEmpty)
                    FadeInUp(
                      duration: const Duration(milliseconds: 400),
                      delay: const Duration(milliseconds: 300),
                      child: _buildCompleteAllButton(
                        context,
                        habitProvider,
                        todayHabits,
                        dateKey,
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
    double progress,
    int completed,
    int total,
    bool allCompleted,
  ) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      useBackdropFilter: true,
      child: Column(
        children: [
          Row(
            children: [
              // Progress Ring
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
                        backgroundColor: Colors.white.withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          allCompleted
                              ? AppColors.accentCyan
                              : AppColors.primaryPurple,
                        ),
                      ),
                    ),
                    Text(
                      '${(progress * 100).toInt()}%',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                      allCompleted ? 'All Done! 🎉' : 'Keep Going!',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$completed of $total habits completed',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (allCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.cyanPurpleGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Perfect Day!',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHabitCard(
    BuildContext context,
    HabitProvider habitProvider,
    HabitModel habit,
    String dateKey, {
    bool isUrgent = false,
  }) {
    final isCompleted = habit.isCompletedOn(dateKey);
    final habitColorIndex =
        habit.colorIndex.clamp(0, AppColors.habitColors.length - 1);
    final habitColor = AppColors.habitColors[habitColorIndex];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddHabitScreen(habitToEdit: habit),
            ),
          );
        },
        child: GlassContainer(
          padding: const EdgeInsets.all(16),
          useBackdropFilter: true,
          child: Row(
            children: [
              // Completion toggle
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  habitProvider.toggleHabitCompletion(habit.id);
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCompleted
                        ? AppColors.accentCyan
                        : Colors.white.withOpacity(0.1),
                    border: Border.all(
                      color: isCompleted
                          ? AppColors.accentCyan
                          : isUrgent
                              ? AppColors.warning.withOpacity(0.5)
                              : habitColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              // Habit info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      habit.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isCompleted
                            ? Colors.white.withOpacity(0.6)
                            : Colors.white,
                        decoration:
                            isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    if (habit.reminderTime != null)
                      Row(
                        children: [
                          Icon(
                            Iconsax.clock,
                            size: 12,
                            color: isUrgent
                                ? AppColors.warning
                                : Colors.white.withOpacity(0.5),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            habit.reminderTime!,
                            style: TextStyle(
                              fontSize: 12,
                              color: isUrgent
                                  ? AppColors.warning
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                          if (isUrgent) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.warning.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Overdue',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.warning,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                  ],
                ),
              ),
              // Category color indicator
              Container(
                width: 8,
                height: 40,
                decoration: BoxDecoration(
                  color: habitColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(32),
      useBackdropFilter: true,
      child: Column(
        children: [
          Icon(
            Iconsax.task_square,
            size: 64,
            color: Colors.white.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          const Text(
            'No habits for today',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create a new habit to get started',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddHabitScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Habit'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompleteAllButton(
    BuildContext context,
    HabitProvider habitProvider,
    List<HabitModel> habits,
    String dateKey,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.heavyImpact();
        for (final habit in habits) {
          if (!habit.isCompletedOn(dateKey)) {
            habitProvider.toggleHabitCompletion(habit.id);
          }
        }
        Helpers.showSnackBar(context, 'All habits completed! 🎉');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: AppColors.cyanPurpleGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.accentCyan.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.tick_square5, color: Colors.white),
            const SizedBox(width: 12),
            const Text(
              'Complete All',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
