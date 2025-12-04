import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/glass_theme.dart';

/// Premium animated background for glass refraction
class GalaxyBackground extends StatefulWidget {
  final Widget child;
  
  const GalaxyBackground({
    super.key,
    required this.child,
  });

  @override
  State<GalaxyBackground> createState() => _GalaxyBackgroundState();
}

class _GalaxyBackgroundState extends State<GalaxyBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlassTheme.backgroundDark,
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: const [
                  GlassTheme.backgroundDark,
                  GlassTheme.backgroundNavy,
                  Color(0xFF0F1A2E),
                  GlassTheme.backgroundDark,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Animated orb 1 - Cyan
                _buildAnimatedOrb(
                  color: GlassTheme.glassCyan,
                  size: 350,
                  baseTop: -100,
                  baseRight: -120,
                  phase: 0.0,
                ),
                // Animated orb 2 - Purple
                _buildAnimatedOrb(
                  color: GlassTheme.glassPurple,
                  size: 280,
                  baseBottom: 50,
                  baseLeft: -100,
                  phase: 0.33,
                ),
                // Animated orb 3 - Blue
                _buildAnimatedOrb(
                  color: GlassTheme.glassBlue,
                  size: 220,
                  baseTop: 300,
                  baseRight: -50,
                  phase: 0.66,
                ),
                // Animated orb 4 - Small accent
                _buildAnimatedOrb(
                  color: GlassTheme.glassCyan,
                  size: 150,
                  baseBottom: 200,
                  baseRight: 50,
                  phase: 0.5,
                ),
                // Content
                SafeArea(child: widget.child),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildAnimatedOrb({
    required Color color,
    required double size,
    double? baseTop,
    double? baseBottom,
    double? baseLeft,
    double? baseRight,
    required double phase,
  }) {
    final animValue = (_controller.value + phase) % 1.0;
    final offsetX = math.sin(animValue * 2 * math.pi) * 30;
    final offsetY = math.cos(animValue * 2 * math.pi) * 20;
    final scale = 1.0 + math.sin(animValue * 4 * math.pi) * 0.1;
    
    return Positioned(
      top: baseTop != null ? baseTop + offsetY : null,
      bottom: baseBottom != null ? baseBottom - offsetY : null,
      left: baseLeft != null ? baseLeft + offsetX : null,
      right: baseRight != null ? baseRight - offsetX : null,
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withOpacity(0.20),
                color.withOpacity(0.08),
                color.withOpacity(0.0),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
      ),
    );
  }
}
