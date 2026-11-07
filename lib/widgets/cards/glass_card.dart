import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class GlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool enableHoverEffect;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.borderRadius = 24,
    this.blur = 16,
    this.backgroundColor,
    this.borderColor,
    this.enableHoverEffect = true,
    this.onTap,
  });

  @override
  State<GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<GlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = widget.borderColor ??
        (_isHovered && widget.enableHoverEffect
            ? AppColors.primaryLight.withValues(alpha: 0.7)
            : Colors.white.withValues(alpha: 0.85));

    final effectiveBgColor = widget.backgroundColor ??
        (_isHovered && widget.enableHoverEffect
            ? Colors.white.withValues(alpha: 0.92)
            : Colors.white.withValues(alpha: 0.80));

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      margin: widget.margin,
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: effectiveBorderColor,
          width: _isHovered && widget.enableHoverEffect ? 1.5 : 1.2,
        ),
        boxShadow: [
          // Soft ambient drop shadow
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: _isHovered && widget.enableHoverEffect ? 0.08 : 0.04),
            blurRadius: _isHovered && widget.enableHoverEffect ? 28 : 16,
            spreadRadius: _isHovered && widget.enableHoverEffect ? 2 : 0,
            offset: Offset(0, _isHovered && widget.enableHoverEffect ? 12 : 6),
          ),
          // Clean Sky Blue Luminous Aura on Hover
          if (_isHovered && widget.enableHoverEffect)
            BoxShadow(
              color: AppColors.primaryLight.withValues(alpha: 0.16),
              blurRadius: 32,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: widget.child,
          ),
        ),
      ),
    );

    if (widget.enableHoverEffect || widget.onTap != null) {
      content = MouseRegion(
        cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: content,
        ),
      );
    }

    return content;
  }
}

