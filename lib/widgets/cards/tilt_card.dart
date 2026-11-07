import 'dart:math' as math;
import 'package:flutter/material.dart';

class TiltCard extends StatefulWidget {
  final Widget child;
  final double maxTiltAngle;
  final double perspective;
  final double borderRadius;
  final bool enableGlare;

  const TiltCard({
    super.key,
    required this.child,
    this.maxTiltAngle = 10.0, // degrees
    this.perspective = 0.0012,
    this.borderRadius = 28.0,
    this.enableGlare = true,
  });

  @override
  State<TiltCard> createState() => _TiltCardState();
}

class _TiltCardState extends State<TiltCard> {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  double _glareX = 0.5;
  double _glareY = 0.5;
  bool _isHovered = false;

  void _onHover(PointerEvent details, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final local = details.localPosition;
    final normalizedX = (local.dx / size.width).clamp(0.0, 1.0);
    final normalizedY = (local.dy / size.height).clamp(0.0, 1.0);

    // Map 0..1 to -1..1
    final offsetX = (normalizedX - 0.5) * 2;
    final offsetY = (normalizedY - 0.5) * 2;

    final maxRad = widget.maxTiltAngle * (math.pi / 180);

    setState(() {
      _rotateX = -offsetY * maxRad;
      _rotateY = offsetX * maxRad;
      _glareX = normalizedX;
      _glareY = normalizedY;
      _isHovered = true;
    });
  }

  void _onExit() {
    setState(() {
      _rotateX = 0.0;
      _rotateY = 0.0;
      _glareX = 0.5;
      _glareY = 0.5;
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onHover: (e) => _onHover(e, Size(constraints.maxWidth, constraints.maxHeight)),
          onExit: (_) => _onExit(),
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: _rotateX),
            duration: const Duration(milliseconds: 140),
            curve: Curves.easeOutCubic,
            builder: (context, currentRotateX, _) {
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: _rotateY),
                duration: const Duration(milliseconds: 140),
                curve: Curves.easeOutCubic,
                builder: (context, currentRotateY, _) {
                  final transformMatrix = Matrix4.identity()
                    ..setEntry(3, 2, widget.perspective)
                    ..rotateX(currentRotateX)
                    ..rotateY(currentRotateY);

                  return Transform(
                    transform: transformMatrix,
                    alignment: FractionalOffset.center,
                    child: Stack(
                      children: [
                        widget.child,
                        // Glare light sheen that follows cursor
                        if (widget.enableGlare && _isHovered)
                          Positioned.fill(
                            child: IgnorePointer(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(widget.borderRadius),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      center: Alignment(
                                        (_glareX - 0.5) * 2,
                                        (_glareY - 0.5) * 2,
                                      ),
                                      radius: 0.8,
                                      colors: [
                                        Colors.white.withValues(alpha: 0.25),
                                        Colors.transparent,
                                      ],
                                      stops: const [0.0, 1.0],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }
}

