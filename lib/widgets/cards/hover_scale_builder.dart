import 'package:flutter/material.dart';

class HoverScaleBuilder extends StatefulWidget {
  final Widget Function(BuildContext context, bool isHovered) builder;
  final double scale;
  final double translateY;
  final Duration duration;
  final Curve curve;
  final VoidCallback? onTap;

  const HoverScaleBuilder({
    super.key,
    required this.builder,
    this.scale = 1.025,
    this.translateY = -5.0,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeOutCubic,
    this.onTap,
  });

  @override
  State<HoverScaleBuilder> createState() => _HoverScaleBuilderState();
}

class _HoverScaleBuilderState extends State<HoverScaleBuilder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? widget.scale : 1.0,
          duration: widget.duration,
          curve: widget.curve,
          child: AnimatedContainer(
            duration: widget.duration,
            curve: widget.curve,
            transform: Matrix4.translationValues(
              0,
              _isHovered ? widget.translateY : 0,
              0,
            ),
            child: widget.builder(context, _isHovered),
          ),
        ),
      ),
    );
  }
}

