import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/advice.dart';
import '../../../data/models/habit_model.dart';
import '../../../providers/habit_provider.dart';
import '../common/glass_container.dart';
import '../common/gradient_button.dart';
import 'breathing_exercise.dart';

class PanicModal extends StatelessWidget {
  final HabitModel habit;

  const PanicModal({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    if (!habit.isQuitHabit || habit.quitStartDate == null) {
      return const SizedBox.shrink();
    }

    final timeSinceQuit = DateTime.now().difference(habit.quitStartDate!);
    final days = timeSinceQuit.inDays;
    final advice = HabitAdvice.getRandomAdvice(habit.name);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(24),
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(51),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Title
            const Text(
              'You Got This! 💪',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You\'ve been strong for $days ${days == 1 ? 'day' : 'days'}!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
              ),
            ),
            const SizedBox(height: 32),
            // Breathing Exercise
            GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.air, color: AppColors.accentCyan),
                      SizedBox(width: 12),
                      Text(
                        'Breathing Exercise',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Take a moment to breathe deeply and calm your mind',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GradientButton(
                    text: 'Start 4-7-8 Breathing',
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BreathingExercise(),
                        ),
                      );
                    },
                    width: double.infinity,
                    gradient: AppColors.cyanPurpleGradient,
                    icon: Icons.air,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Advice
            GlassContainer(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.lightbulb,
                    color: AppColors.warning,
                    size: 32,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    advice,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Progress reminder
            GlassContainer(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(
                    Icons.timer,
                    color: AppColors.accentGreen,
                    size: 32,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '$days ${days == 1 ? 'day' : 'days'} clean',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'This craving will pass in 3-5 minutes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You are stronger than this moment',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Action buttons
            GradientButton(
              text: 'I Stayed Strong',
              onPressed: () => Navigator.pop(context),
              width: double.infinity,
              icon: Icons.check_circle,
              gradient: AppColors.greenCyanGradient,
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => _handleRelapse(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                side: BorderSide(
                  color: AppColors.error.withAlpha(102),
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restart_alt,
                    color: AppColors.error,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'I Slipped',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleRelapse(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Record Relapse?'),
        content: const Text(
          'It\'s okay to slip. Recovery is a journey. This will reset your timer but you can start again right now.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final habitProvider = context.read<HabitProvider>();
              habitProvider.recordRelapse(habit.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close panic modal
              
              // Show encouragement
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Timer reset. You\'ve got this! Start fresh.'),
                  backgroundColor: AppColors.accentCyan,
                  duration: Duration(seconds: 3),
                ),
              );
            },
            child: const Text('Record Relapse'),
          ),
        ],
      ),
    );
  }
}
