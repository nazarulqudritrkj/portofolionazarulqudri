import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/responsive.dart';

class SectionTitle extends StatelessWidget {
  final String tag;
  final String title;
  final String? subtitle;
  final bool isCentered;

  const SectionTitle({
    super.key,
    required this.tag,
    required this.title,
    this.subtitle,
    this.isCentered = true,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      crossAxisAlignment:
          isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Tag Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.softCyan,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFBAE6FD),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                tag.toUpperCase(),
                style: AppTypography.badge.copyWith(
                  color: AppColors.primaryDark,
                  fontSize: 11,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Main Title
        Text(
          title,
          textAlign: isCentered ? TextAlign.center : TextAlign.start,
          style: (isMobile
                  ? AppTypography.displaySmall
                  : AppTypography.displayMedium)
              .copyWith(
            color: AppColors.textPrimary,
            letterSpacing: -1.0,
            fontWeight: FontWeight.w800,
          ),
        ),

        // Subtitle
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 680),
            child: Text(
              subtitle!,
              textAlign: isCentered ? TextAlign.center : TextAlign.start,
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.textSecondary,
                fontSize: isMobile ? 14.5 : 16,
                height: 1.6,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

