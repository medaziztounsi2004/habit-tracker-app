import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/theme/glass_theme.dart';

/// Animated gradient background that gives glass something to refract
class AnimatedGlassBackground extends StatefulWidget {
  final Widget child;
  
  const AnimatedGlassBackground({
    super.key,
    required this.child,
  });

  @override
  State<AnimatedGlassBackground> createState() => _AnimatedGlassBackgroundState();
}

class _AnimatedGlassBackgroundState extends State<AnimatedGlassBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                math.cos(_controller.value * 2 * math.pi) * 0.5,
                math.sin(_controller.value * 2 * math.pi) * 0.5,
              ),
              end: Alignment(
                math.cos((_controller.value + 0.5) * 2 * math.pi) * 0.5,
                math.sin((_controller.value + 0.5) * 2 * math.pi) * 0.5,
              ),
              colors: const [
                GlassTheme.backgroundDark,
                GlassTheme.backgroundNavy,
                Color(0xFF0F1A2E),
                Color(0xFF141E33),
                GlassTheme.backgroundDark,
              ],
              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Subtle animated orbs for glass refraction
              _buildOrb(
                color: GlassTheme.glassCyan.withOpacity(0.15),
                size: 300,
                top: -50,
                right: -100,
                animationOffset: 0.0,
              ),
              _buildOrb(
                color: GlassTheme.glassPurple.withOpacity(0.12),
                size: 250,
                bottom: 100,
                left: -80,
                animationOffset: 0.33,
              ),
              _buildOrb(
                color: GlassTheme.glassBlue.withOpacity(0.10),
                size: 200,
                top: 200,
                right: 50,
                animationOffset: 0.66,
              ),
              // Content
              widget.child,
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildOrb({
    required Color color,
    required double size,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double animationOffset,
  }) {
    final animValue = (_controller.value + animationOffset) % 1.0;
    final offset = math.sin(animValue * 2 * math.pi) * 20;
    
    return Positioned(
      top: top != null ? top + offset : null,
      bottom: bottom != null ? bottom - offset : null,
      left: left != null ? left + offset * 0.5 : null,
      right: right != null ? right - offset * 0.5 : null,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              color,
              color.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}
