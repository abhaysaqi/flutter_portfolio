import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedBackground extends StatefulWidget {
  final bool isDarkMode;

  const AnimatedBackground({super.key, required this.isDarkMode});
  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final int _particleCount = 15;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _generateParticles();
  }

  void _generateParticles() {
    _particles.clear();
    final math.Random random = math.Random();
    
    for (int i = 0; i < _particleCount; i++) {
      _particles.add(
        Particle(
          x: random.nextDouble(),
          y: random.nextDouble(),
          size: random.nextDouble() * 15 + 5,
          speed: random.nextDouble() * 0.02 + 0.01,
          angle: random.nextDouble() * 2 * math.pi,
          opacity: random.nextDouble() * 0.4 + 0.2,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  void didUpdateWidget(AnimatedBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDarkMode != oldWidget.isDarkMode) {
      _generateParticles(); // Regenerate particles when theme changes
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Animated gradient background
        Positioned.fill(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: widget.isDarkMode
                    ? [
                        const Color(0xFF121212),
                        const Color(0xFF1E2033),
                      ]
                    : [
                        const Color(0xFFF5F7FA),
                        const Color(0xFFEEF2F7),
                      ],
              ),
            ),
          ),
        ),
        
        // Gradient Overlay with Animation
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: GradientPainter(
                  animation: _controller.value,
                  isDarkMode: widget.isDarkMode,
                ),
              );
            },
          ),
        ),
        
        // Particles Animation
        Positioned.fill(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(
                  particles: _particles,
                  animation: _controller.value,
                  isDarkMode: widget.isDarkMode,
                ),
              );
            },
          ),
        ),
      ],
    ).animate().fadeIn(duration: 1.seconds, curve: Curves.easeIn);
  }
}

class Particle {
  double x; // Position 0.0 to 1.0 (percentage of screen)
  double y; // Position 0.0 to 1.0 (percentage of screen)
  final double size;
  final double speed;
  final double angle;
  final double opacity;
  
  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.angle,
    required this.opacity,
  });
  
  void update(double animation) {
    x += math.cos(angle) * speed;
    y += math.sin(angle) * speed;
    
    // Wrap around screen edges
    if (x < 0) x = 1.0;
    if (x > 1.0) x = 0.0;
    if (y < 0) y = 1.0;
    if (y > 1.0) y = 0.0;
  }
}

class GradientPainter extends CustomPainter {
  final double animation;
  final bool isDarkMode;
  
  GradientPainter({required this.animation, required this.isDarkMode});
  
  @override
  void paint(Canvas canvas, Size size) {
    // Create moving gradient blobs
    final paint = Paint();
    
    // First blob
    final radius1 = size.width * 0.4;
    final x1 = size.width * 0.2 + size.width * 0.2 * math.sin(animation * 2 * math.pi);
    final y1 = size.height * 0.3 + size.height * 0.1 * math.cos(animation * 2 * math.pi);
    
    paint.shader = RadialGradient(
      colors: isDarkMode
          ? [
              const Color(0x30444BEE),
              Colors.transparent,
            ]
          : [
              const Color(0x20667EEA),
              Colors.transparent,
            ],
      stops: const [0.0, 1.0],
    ).createShader(Rect.fromCircle(center: Offset(x1, y1), radius: radius1));
    
    canvas.drawCircle(Offset(x1, y1), radius1, paint);
    
    // Second blob
    final radius2 = size.width * 0.5;
    final x2 = size.width * 0.8 + size.width * 0.15 * math.cos(animation * 2 * math.pi + 1);
    final y2 = size.height * 0.7 + size.height * 0.1 * math.sin(animation * 2 * math.pi + 1);
    
    paint.shader = RadialGradient(
      colors: isDarkMode
          ? [
              const Color(0x2026A69A),
              Colors.transparent,
            ]
          : [
              const Color(0x1864B5F6),
              Colors.transparent,
            ],
      stops: const [0.0, 1.0],
    ).createShader(Rect.fromCircle(center: Offset(x2, y2), radius: radius2));
    
    canvas.drawCircle(Offset(x2, y2), radius2, paint);
  }
  
  @override
  bool shouldRepaint(GradientPainter oldDelegate) {
    return oldDelegate.animation != animation || oldDelegate.isDarkMode != isDarkMode;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double animation;
  final bool isDarkMode;
  
  ParticlePainter({
    required this.particles,
    required this.animation,
    required this.isDarkMode,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    for (final particle in particles) {
      particle.update(animation);
      
      final paint = Paint()
        ..color = isDarkMode
            ? Color.fromRGBO(255, 255, 255, particle.opacity * 0.4)
            : Color.fromRGBO(100, 107, 234, particle.opacity * 0.3)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.fill;
      
      final position = Offset(
        particle.x * size.width,
        particle.y * size.height,
      );
      
      canvas.drawCircle(position, particle.size, paint);
    }
  }
  
  @override
  bool shouldRepaint(ParticlePainter oldDelegate) {
    return oldDelegate.animation != animation || oldDelegate.isDarkMode != isDarkMode;
  }
}