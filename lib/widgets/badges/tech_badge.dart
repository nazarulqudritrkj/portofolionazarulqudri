import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';

class TechBadge extends StatefulWidget {
  final String label;
  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;

  const TechBadge({
    super.key,
    required this.label,
    this.icon,
    this.color,
    this.onTap,
  });

  @override
  State<TechBadge> createState() => _TechBadgeState();
}

class _TechBadgeState extends State<TechBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = widget.color ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _isHovered
                ? baseColor.withValues(alpha: 0.16)
                : const Color(0xFFF0F9FF), // Ice blue
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _isHovered
                  ? baseColor.withValues(alpha: 0.6)
                  : const Color(0xFFBAE6FD), // Sky 200
              width: 1.0,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: baseColor.withValues(alpha: 0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 13,
                  color: baseColor,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                widget.label,
                style: AppTypography.badge.copyWith(
                  color: _isHovered ? AppColors.textPrimary : baseColor,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

