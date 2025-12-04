import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/glass_theme.dart';

/// Premium iOS-style glassmorphism container with real backdrop blur
class PremiumGlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blurSigma;
  final bool showGlow;
  final Color? glowColor;
  final VoidCallback? onTap;
  final bool enableBlur;

  const PremiumGlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 20,
    this.blurSigma = GlassTheme.blurCard,
    this.showGlow = false,
    this.glowColor,
    this.onTap,
    this.enableBlur = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            ...GlassTheme.glassShadow,
            if (showGlow && glowColor != null)
              GlassTheme.glowShadow(glowColor!),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: BackdropFilter(
            filter: enableBlur
                ? ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma)
                : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Container(
              padding: padding,
              decoration: BoxDecoration(
                // Glass gradient tint
                gradient: GlassTheme.glassGradient,
                borderRadius: BorderRadius.circular(borderRadius),
                // Glass edge border
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.0,
                ),
              ),
              child: Stack(
                children: [
                  // Vibrancy overlay for luminous feel
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: GlassTheme.vibrancyOverlay,
                        borderRadius: BorderRadius.circular(borderRadius - 1),
                      ),
                    ),
                  ),
                  // Top-left highlight for depth
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.3),
                            Colors.white.withOpacity(0.1),
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
