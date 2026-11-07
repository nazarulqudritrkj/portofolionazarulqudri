import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../models/experience_model.dart';
import '../../widgets/cards/glass_card.dart';

class TimelineItemWidget extends StatelessWidget {
  final ExperienceModel experience;
  final bool isLast;

  const TimelineItemWidget({
    super.key,
    required this.experience,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator column
          SizedBox(
            width: 44,
            child: Column(
              children: [
                // Glowing node
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: experience.isEducation
                        ? AppColors.accentPurple.withValues(alpha: 0.12)
                        : AppColors.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: experience.isEducation
                          ? AppColors.accentPurple
                          : AppColors.primary,
                      width: 2.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (experience.isEducation
                                ? AppColors.accentPurple
                                : AppColors.primary)
                            .withValues(alpha: 0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Icon(
                    experience.icon,
                    size: 18,
                    color: experience.isEducation
                        ? AppColors.accentPurple
                        : AppColors.primary,
                  ),
                ),
                // Glowing connecting line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.0,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            experience.isEducation
                                ? AppColors.accentPurple
                                : AppColors.primary,
                            const Color(0xFFCBD5E1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 18),

          // Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: GlassCard(
                borderRadius: 20,
                blur: 16,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Period badge & location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: (experience.isEducation
                                    ? AppColors.accentPurple
                                    : AppColors.primary)
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            experience.period,
                            style: AppTypography.badge.copyWith(
                              color: experience.isEducation
                                  ? AppColors.accentPurple
                                  : AppColors.primaryDark,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 13,
                              color: AppColors.textMuted,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              experience.location,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textMuted,
                                fontSize: 11.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Role
                    Text(
                      experience.role,
                      style: AppTypography.headingSmall.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Company
                    Text(
                      experience.company,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Description
                    Text(
                      experience.description,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 13.5,
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Key highlights list
                    Column(
                      children: experience.highlights.map((item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: experience.isEducation
                                      ? AppColors.accentPurple
                                      : AppColors.primaryLight,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  item,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 12.5,
                                    height: 1.45,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

