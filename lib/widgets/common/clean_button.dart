import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';

enum CleanButtonVariant { primary, outline, subtle }

class CleanButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isTrailingIcon;
  final CleanButtonVariant variant;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const CleanButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isTrailingIcon = false,
    this.variant = CleanButtonVariant.primary,
    this.height = 48,
    this.borderRadius = 14,
    this.padding,
  });

  @override
  State<CleanButton> createState() => _CleanButtonState();
}

class _CleanButtonState extends State<CleanButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedScale(
          scale: _isHovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutCubic,
            height: widget.height,
            padding: widget.padding ??
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: _getDecoration(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null && !widget.isTrailingIcon) ...[
                  Icon(
                    widget.icon,
                    size: 18,
                    color: _getTextColor(),
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.text,
                  style: AppTypography.button.copyWith(
                    color: _getTextColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.icon != null && widget.isTrailingIcon) ...[
                  const SizedBox(width: 8),
                  Icon(
                    widget.icon,
                    size: 18,
                    color: _getTextColor(),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    switch (widget.variant) {
      case CleanButtonVariant.primary:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: LinearGradient(
            colors: _isHovered
                ? [const Color(0xFF0284C7), const Color(0xFF1D4ED8)]
                : [AppColors.primary, AppColors.oceanBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: _isHovered ? 0.38 : 0.22),
              blurRadius: _isHovered ? 20 : 12,
              offset: Offset(0, _isHovered ? 6 : 3),
            ),
          ],
        );

      case CleanButtonVariant.outline:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: _isHovered
              ? AppColors.primary
              : Colors.white.withValues(alpha: 0.8),
          border: Border.all(
            color: _isHovered ? AppColors.primary : const Color(0xFFCBD5E1),
            width: 1.5,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  )
                ]
              : [
                  BoxShadow(
                    color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        );

      case CleanButtonVariant.subtle:
        return BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: _isHovered
              ? AppColors.iceBlue
              : Colors.transparent,
        );
    }
  }

  Color _getTextColor() {
    switch (widget.variant) {
      case CleanButtonVariant.primary:
        return Colors.white;
      case CleanButtonVariant.outline:
        return _isHovered ? Colors.white : AppColors.textPrimary;
      case CleanButtonVariant.subtle:
        return _isHovered ? AppColors.primary : AppColors.textSecondary;
    }
  }
}

