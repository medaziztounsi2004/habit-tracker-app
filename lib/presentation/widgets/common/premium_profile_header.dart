import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/user_model.dart';

class PremiumProfileHeader extends StatefulWidget {
  final UserModel? user;
  final int totalHabits;
  final int completedToday;
  final int totalToday;
  final int currentStreak;
  final int longestStreak;
  final double levelProgress;
  final VoidCallback? onAvatarTap;
  final VoidCallback? onStatsTap;

  const PremiumProfileHeader({
    super.key,
    this.user,
    required this.totalHabits,
    required this.completedToday,
    required this.totalToday,
    required this.currentStreak,
    required this.longestStreak,
    required this.levelProgress,
    this.onAvatarTap,
    this.onStatsTap,
  });

  @override
  State<PremiumProfileHeader> createState() => _PremiumProfileHeaderState();
}

class _PremiumProfileHeaderState extends State<PremiumProfileHeader>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _fireController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _fireAnimation;

  @override
  void initState() {
    super.initState();
    
    // Pulse animation for avatar ring
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    
    // Fire animation for streak
    _fireController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    
    _fireAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _fireController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _fireController.dispose();
    super.dispose();
  }

  // Feature 1: Mood ring color based on completion
  Color get _moodRingColor {
    if (widget.totalToday == 0) return Colors.grey;
    final progress = widget.completedToday / widget.totalToday;
    if (progress >= 1.0) return const Color(0xFF00E676); // Green - Perfect!
    if (progress >= 0.7) return const Color(0xFF69F0AE); // Light green
    if (progress >= 0.5) return const Color(0xFFFFD54F); // Yellow
    if (progress >= 0.3) return const Color(0xFFFFB74D); // Orange
    return const Color(0xFFFF5252); // Red - Need to work!
  }

  // Feature 5: Daily motivation based on time + performance
  String get _dailyMotivation {
    final hour = DateTime.now().hour;
    final progress = widget.totalToday > 0 
        ? widget.completedToday / widget.totalToday 
        : 0.0;
    
    if (hour < 12) {
      // Morning
      if (progress >= 0.5) return "Great morning start! 🌅";
      return "Fresh day ahead! Let's go! ☀️";
    } else if (hour < 17) {
      // Afternoon
      if (progress >= 1.0) return "All done! Enjoy your day! 🎉";
      if (progress >= 0.5) return "Halfway there! Keep pushing! 💪";
      return "Afternoon focus time! 🎯";
    } else {
      // Evening
      if (progress >= 1.0) return "Perfect day! Rest well! 🌙";
      if (progress >= 0.7) return "Almost there! Finish strong! 🔥";
      return "Evening push! You got this! ⭐";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: Avatar + Info + Quick Stats
          Row(
            children: [
              // Feature 1 & 3: Mood Ring Avatar with XP Arc
              _buildAvatarWithProgress(),
              
              const SizedBox(width: 16),
              
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user?.name ?? 'User',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Feature 5: Daily Motivation
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _moodRingColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _moodRingColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        _dailyMotivation,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: _moodRingColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Level + XP
                    Row(
                      children: [
                        _buildLevelBadge(),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.user?.totalXP ?? 0} XP',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Divider
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Stats Row with Feature 2: Animated Streak
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                icon: Icons.check_circle_outline,
                value: '${widget.completedToday}/${widget.totalToday}',
                label: 'Today',
                color: AppColors.accentGreen,
              ),
              _buildAnimatedStreakStat(),
              _buildStatItem(
                icon: Icons.emoji_events_outlined,
                value: '${widget.user?.unlockedAchievements.length ?? 0}',
                label: 'Badges',
                color: AppColors.goldAccent,
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Feature 4: Quick Actions Row
          _buildQuickActions(),
        ],
      ),
    );
  }

  // Feature 1 & 3: Avatar with mood ring and XP progress
  Widget _buildAvatarWithProgress() {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        widget.onAvatarTap?.call();
      },
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _pulseAnimation.value,
            child: SizedBox(
              width: 80,
              height: 80,
              child: Stack(
                children: [
                  // XP Progress Arc (Feature 3)
                  CustomPaint(
                    size: const Size(80, 80),
                    painter: _XPArcPainter(
                      progress: widget.levelProgress,
                      color: AppColors.primaryPurple,
                    ),
                  ),
                  // Mood Ring (Feature 1)
                  Center(
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _moodRingColor,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _moodRingColor.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.primaryPurple,
                              AppColors.secondaryPink,
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.user?.name.isNotEmpty == true
                                ? widget.user!.name[0].toUpperCase()
                                : 'U',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLevelBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            'Level ${widget.user?.level ?? 0}',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Feature 2: Animated Streak with growing fire
  Widget _buildAnimatedStreakStat() {
    final streakSize = (widget.currentStreak.clamp(0, 30) / 30) * 0.5 + 0.8;
    
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        _showStreakDetails();
      },
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _fireAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: widget.currentStreak > 0 
                    ? _fireAnimation.value * streakSize 
                    : 1.0,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: widget.currentStreak > 0
                        ? Colors.orange.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: widget.currentStreak > 0
                        ? [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.3),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: Icon(
                    Icons.local_fire_department,
                    size: 24,
                    color: widget.currentStreak > 0
                        ? Colors.orange
                        : Colors.grey,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 6),
          Text(
            '${widget.currentStreak}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: widget.currentStreak > 0 
                  ? Colors.orange 
                  : Colors.white.withOpacity(0.5),
            ),
          ),
          Text(
            'Streak',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 22, color: color),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  // Feature 4: Quick Actions
  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildQuickActionButton(
            icon: Icons.add_circle_outline,
            label: 'Add Habit',
            color: AppColors.accentGreen,
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).pushNamed('/addHabit');
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildQuickActionButton(
            icon: Icons.bar_chart,
            label: 'Stats',
            color: AppColors.primaryPurple,
            onTap: () {
              HapticFeedback.mediumImpact();
              if (widget.onStatsTap != null) {
                widget.onStatsTap!.call();
              } else {
                Navigator.of(context).pushNamed('/stats');
              }
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildQuickActionButton(
            icon: Icons.settings_outlined,
            label: 'Settings',
            color: Colors.blueGrey,
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showStreakDetails() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            const Icon(
              Icons.local_fire_department,
              size: 64,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.currentStreak} Day Streak!',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Best: ${widget.longestStreak} days',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 24),
            // Streak milestones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMilestone(7, 'Week', widget.currentStreak >= 7),
                _buildMilestone(30, 'Month', widget.currentStreak >= 30),
                _buildMilestone(100, '100!', widget.currentStreak >= 100),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMilestone(int days, String label, bool achieved) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: achieved 
                ? Colors.orange.withOpacity(0.2)
                : Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: achieved ? Colors.orange : Colors.grey,
              width: 2,
            ),
          ),
          child: Center(
            child: achieved
                ? const Icon(Icons.check, color: Colors.orange)
                : Text(
                    '$days',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: achieved ? Colors.orange : Colors.grey,
          ),
        ),
      ],
    );
  }
}

// Custom painter for XP arc around avatar
class _XPArcPainter extends CustomPainter {
  final double progress;
  final Color color;

  _XPArcPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;
    
    // Background arc
    final bgPaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    
    canvas.drawCircle(center, radius, bgPaint);
    
    // Progress arc
    final progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [color, AppColors.secondaryPink],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top
      2 * math.pi * progress, // Progress angle
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _XPArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
