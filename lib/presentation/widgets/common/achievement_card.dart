import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/achievement_model.dart';
import '../../../core/theme/app_theme.dart';
import 'glass_container.dart';

class AchievementCard extends StatelessWidget {
  final AchievementModel achievement;
  final bool isUnlocked;
  final VoidCallback? onTap;

  const AchievementCard({
    super.key,
    required this.achievement,
    required this.isUnlocked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          HapticFeedback.lightImpact();
          onTap!();
        }
      },
      child: GlassContainer(
        padding: const EdgeInsets.all(12),
        borderRadius: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon with gradient background
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: isUnlocked
                    ? LinearGradient(
                        colors: achievement.gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [
                          Colors.grey.withAlpha(76),
                          Colors.grey.withAlpha(51),
                        ],
                      ),
                shape: BoxShape.circle,
                boxShadow: isUnlocked
                    ? [
                        BoxShadow(
                          color: achievement.gradientColors.first.withAlpha(102),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: isUnlocked
                    ? Text(
                        achievement.iconEmoji,
                        style: const TextStyle(fontSize: 28),
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          ColorFiltered(
                            colorFilter: const ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            ),
                            child: Text(
                              achievement.iconEmoji,
                              style: const TextStyle(fontSize: 28),
                            ),
                          ),
                          Icon(
                            Icons.lock,
                            color: Colors.white.withAlpha(179),
                            size: 20,
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 8),
            // Name
            Text(
              achievement.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isUnlocked
                    ? Theme.of(context).colorScheme.onSurface
                    : Theme.of(context).colorScheme.onSurface.withAlpha(102),
              ),
            ),
            const SizedBox(height: 4),
            // Description (reduced lines)
            Text(
              achievement.description,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.onSurface.withAlpha(102),
              ),
            ),
            const SizedBox(height: 6),
            // XP reward
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                gradient: isUnlocked ? AppColors.greenCyanGradient : null,
                color: isUnlocked
                    ? null
                    : Theme.of(context).colorScheme.onSurface.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '+${achievement.xpReward} XP',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: isUnlocked
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurface.withAlpha(102),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
