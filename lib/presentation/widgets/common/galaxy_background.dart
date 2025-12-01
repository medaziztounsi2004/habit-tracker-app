import 'dart:math';
import 'package:flutter/material.dart';

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
    with TickerProviderStateMixin {
  late AnimationController _starsController;
  late AnimationController _shootingStarController;
  late AnimationController _nebulaController;
  final List<Star> _stars = [];
  final Random _random = Random();
  ShootingStar? _shootingStar;

  @override
  void initState() {
    super.initState();
    
    // Generate stars
    for (int i = 0; i < 80; i++) {
      _stars.add(Star(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: 1.0 + _random.nextDouble() * 2.0,
        opacity: 0.3 + _random.nextDouble() * 0.7,
        twinkleSpeed: 0.5 + _random.nextDouble() * 1.5,
      ));
    }

    // Stars twinkle animation
    _starsController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Nebula slow movement
    _nebulaController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);

    // Shooting stars
    _shootingStarController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _scheduleShootingStar();
  }

  void _scheduleShootingStar() {
    Future.delayed(Duration(seconds: 5 + _random.nextInt(10)), () {
      if (mounted) {
        setState(() {
          _shootingStar = ShootingStar(
            startX: _random.nextDouble(),
            startY: _random.nextDouble() * 0.5,
            angle: 0.3 + _random.nextDouble() * 0.4,
          );
        });
        _shootingStarController.forward(from: 0).then((_) {
          setState(() => _shootingStar = null);
          _scheduleShootingStar();
        });
      }
    });
  }

  @override
  void dispose() {
    _starsController.dispose();
    _shootingStarController.dispose();
    _nebulaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Deep space gradient background
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0a0a1a),
                Color(0xFF1a0a2e),
                Color(0xFF0a0a1a),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),
        
        // Nebula clouds
        AnimatedBuilder(
          animation: _nebulaController,
          builder: (context, child) {
            return CustomPaint(
              painter: NebulaPainter(
                animationValue: _nebulaController.value,
              ),
              size: Size.infinite,
            );
          },
        ),
        
        // Stars layer
        AnimatedBuilder(
          animation: _starsController,
          builder: (context, child) {
            return CustomPaint(
              painter: StarsPainter(
                stars: _stars,
                animationValue: _starsController.value,
              ),
              size: Size.infinite,
            );
          },
        ),
        
        // Shooting star
        if (_shootingStar != null)
          AnimatedBuilder(
            animation: _shootingStarController,
            builder: (context, child) {
              return CustomPaint(
                painter: ShootingStarPainter(
                  shootingStar: _shootingStar!,
                  progress: _shootingStarController.value,
                ),
                size: Size.infinite,
              );
            },
          ),
        
        // Floating particles
        CustomPaint(
          painter: ParticlesPainter(stars: _stars.take(20).toList()),
          size: Size.infinite,
        ),
        
        // Content
        widget.child,
      ],
    );
  }
}

class Star {
  final double x;
  final double y;
  final double size;
  final double opacity;
  final double twinkleSpeed;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.opacity,
    required this.twinkleSpeed,
  });
}

class ShootingStar {
  final double startX;
  final double startY;
  final double angle;

  ShootingStar({
    required this.startX,
    required this.startY,
    required this.angle,
  });
}

class StarsPainter extends CustomPainter {
  final List<Star> stars;
  final double animationValue;

  StarsPainter({
    required this.stars,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (var star in stars) {
      final paint = Paint()
        ..color = Colors.white.withOpacity(
          star.opacity * (0.5 + 0.5 * sin(animationValue * pi * star.twinkleSpeed)),
        )
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        star.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(StarsPainter oldDelegate) => true;
}

class NebulaPainter extends CustomPainter {
  final double animationValue;

  NebulaPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);

    // Purple nebula cloud
    paint.color = const Color(0xFF7C3AED).withOpacity(0.1);
    canvas.drawCircle(
      Offset(
        size.width * 0.3 + (size.width * 0.1 * animationValue),
        size.height * 0.2,
      ),
      size.width * 0.3,
      paint,
    );

    // Blue nebula cloud
    paint.color = const Color(0xFF06B6D4).withOpacity(0.08);
    canvas.drawCircle(
      Offset(
        size.width * 0.7 - (size.width * 0.1 * animationValue),
        size.height * 0.6,
      ),
      size.width * 0.4,
      paint,
    );

    // Pink nebula cloud
    paint.color = const Color(0xFFEC4899).withOpacity(0.06);
    canvas.drawCircle(
      Offset(
        size.width * 0.5,
        size.height * 0.4 + (size.height * 0.1 * animationValue),
      ),
      size.width * 0.35,
      paint,
    );
  }

  @override
  bool shouldRepaint(NebulaPainter oldDelegate) => true;
}

class ShootingStarPainter extends CustomPainter {
  final ShootingStar shootingStar;
  final double progress;

  ShootingStarPainter({
    required this.shootingStar,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(1.0 - progress)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final startX = shootingStar.startX * size.width;
    final startY = shootingStar.startY * size.height;
    final distance = size.width * 0.3 * progress;
    
    final endX = startX + distance * cos(shootingStar.angle);
    final endY = startY + distance * sin(shootingStar.angle);

    // Draw trail
    final gradient = LinearGradient(
      colors: [
        Colors.white.withOpacity(0.8 * (1 - progress)),
        Colors.white.withOpacity(0),
      ],
    );

    paint.shader = gradient.createShader(
      Rect.fromPoints(Offset(startX, startY), Offset(endX, endY)),
    );

    canvas.drawLine(
      Offset(startX, startY),
      Offset(endX, endY),
      paint,
    );

    // Draw bright head
    final headPaint = Paint()
      ..color = Colors.white.withOpacity(1.0 - progress)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(endX, endY), 3, headPaint);
  }

  @override
  bool shouldRepaint(ShootingStarPainter oldDelegate) => true;
}

class ParticlesPainter extends CustomPainter {
  final List<Star> stars;

  ParticlesPainter({required this.stars});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (var star in stars) {
      canvas.drawCircle(
        Offset(star.x * size.width, star.y * size.height),
        1,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) => false;
}
