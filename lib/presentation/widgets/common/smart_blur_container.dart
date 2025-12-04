import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/glass_theme.dart';

/// iOS-inspired glassmorphism container - now using premium glass system
class SmartBlurContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? borderColor;
  final double baseBlur;
  final double baseOpacity;
  final VoidCallback? onTap;
  final bool enableBackdropFilter;
  final bool enableShaderGloss;
  final bool showGlow;
  final Color? glowColor;
  final double motionFactor;
  final bool enableVibrancy;

  const SmartBlurContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 20,
    this.borderColor,
    this.baseBlur = 15,
    this.baseOpacity = 0.1,
    this.onTap,
    this.enableBackdropFilter = true,
    this.enableShaderGloss = true,
    this.showGlow = false,
    this.glowColor,
    this.motionFactor = 0.0,
    this.enableVibrancy = true,
  });

  @override
  Widget build(BuildContext context) {
    final blurSigma = baseBlur + (motionFactor * 5);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            // Depth shadow
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 30,
              spreadRadius: 0,
              offset: const Offset(0, 10),
            ),
            // Ambient shadow
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 60,
              spreadRadius: -10,
              offset: const Offset(0, 20),
            ),
            // Glow
            if (showGlow && glowColor != null)
              BoxShadow(
                color: glowColor!.withOpacity(0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: enableBackdropFilter
                ? ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma)
                : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                // Glass gradient - white to blue tint
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.12),
                    GlassTheme.glassBlue.withOpacity(0.08),
                    Colors.white.withOpacity(0.05),
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
                // Glass border
                border: Border.all(
                  color: borderColor ?? Colors.white.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
              child: Stack(
                children: [
                  // Vibrancy overlay
                  if (enableVibrancy)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius - 1),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(0.05),
                              GlassTheme.glassCyan.withOpacity(0.02),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  // Content
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
