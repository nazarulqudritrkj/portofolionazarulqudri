import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class CleanIslandBackground extends StatefulWidget {
  final Widget child;

  const CleanIslandBackground({super.key, required this.child});

  @override
  State<CleanIslandBackground> createState() => _CleanIslandBackgroundState();
}

class _CleanIslandBackgroundState extends State<CleanIslandBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Stack(
      children: [
        // 1. Base clean white / soft off-white canvas
        Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.background,
        ),

        // 2. Subtle Custom Painted Geometric Grid & Waves
        Positioned.fill(
          child: CustomPaint(
            painter: _IslandGridPainter(),
          ),
        ),

        // 3. Floating Ambient Glowing Gradient Orbs (Smooth Sinusoidal Motion)
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final t = _controller.value;
            final orb1X = math.sin(t * 2 * math.pi) * 60;
            final orb1Y = math.cos(t * 2 * math.pi) * 45;

            final orb2X = math.cos(t * 2 * math.pi) * 70;
            final orb2Y = math.sin(t * 2 * math.pi) * 55;

            final orb3X = math.sin((t + 0.5) * 2 * math.pi) * 50;
            final orb3Y = math.cos((t + 0.5) * 2 * math.pi) * 40;

            return Stack(
              children: [
                // Orb 1: Sky Blue Aura (Top Right)
                Positioned(
                  top: -120 + orb1Y,
                  right: -80 + orb1X,
                  child: _buildGradientOrb(
                    width: math.min(size.width * 0.5, 600),
                    height: math.min(size.width * 0.5, 600),
                    colors: [
                      const Color(0xFF38BDF8).withValues(alpha: 0.28),
                      const Color(0xFF0284C7).withValues(alpha: 0.12),
                      Colors.transparent,
                    ],
                  ),
                ),

                // Orb 2: Soft Cyan / Mint Glow (Middle Left)
                Positioned(
                  top: size.height * 0.35 + orb2Y,
                  left: -140 + orb2X,
                  child: _buildGradientOrb(
                    width: math.min(size.width * 0.45, 520),
                    height: math.min(size.width * 0.45, 520),
                    colors: [
                      const Color(0xFF67E8F9).withValues(alpha: 0.22),
                      const Color(0xFF38BDF8).withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),

                // Orb 3: Deep Royal Azure Mist (Bottom Center / Right)
                Positioned(
                  bottom: -100 + orb3Y,
                  right: size.width * 0.2 + orb3X,
                  child: _buildGradientOrb(
                    width: math.min(size.width * 0.55, 640),
                    height: math.min(size.width * 0.55, 640),
                    colors: [
                      const Color(0xFF93C5FD).withValues(alpha: 0.24),
                      const Color(0xFF2563EB).withValues(alpha: 0.08),
                      Colors.transparent,
                    ],
                  ),
                ),
              ],
            );
          },
        ),

        // 4. Foreground Content
        widget.child,
      ],
    );
  }

  Widget _buildGradientOrb({
    required double width,
    required double height,
    required List<Color> colors,
  }) {
    return IgnorePointer(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: colors,
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
      ),
    );
  }
}

class _IslandGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = const Color(0xFF0284C7).withValues(alpha: 0.065)
      ..style = PaintingStyle.fill;

    // Draw subtle grid dots for clean architectural tech feel
    const double step = 48.0;
    for (double x = 24; x < size.width; x += step) {
      for (double y = 24; y < size.height; y += step) {
        // Soft modulation
        canvas.drawCircle(Offset(x, y), 1.25, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

