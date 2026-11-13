import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../models/project_model.dart';
import '../../widgets/badges/tech_badge.dart';

class ProjectDetailModal extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailModal({super.key, required this.project});

  static Future<void> show(BuildContext context, ProjectModel project) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Project Details',
      barrierColor: Colors.black.withValues(alpha: 0.45),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, anim1, anim2) {
        return ProjectDetailModal(project: project);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final curve = CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic);
        return ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(curve),
          child: FadeTransition(
            opacity: curve,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEn = LocaleController.instance.isEnglish;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720, maxHeight: 820),
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.96),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: Colors.white,
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.16),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with Icon & Close Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      project.primaryColor,
                                      project.accentColor,
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: project.primaryColor
                                          .withValues(alpha: 0.35),
                                      blurRadius: 14,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  project.icon,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    project.getTitle(isEn),
                                    style: AppTypography.headingLarge.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    project.getMetric(isEn),
                                    style: AppTypography.badge.copyWith(
                                      color: project.primaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close_rounded),
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xFFF1F5F9),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Subtitle
                      Text(
                        project.getSubtitle(isEn),
                        style: AppTypography.headingSmall.copyWith(
                          fontSize: 16,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Detailed Full Description
                      Text(
                        project.getFullDescription(isEn),
                        style: AppTypography.bodyLarge.copyWith(
                          fontSize: 15,
                          height: 1.65,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Key Architectural Features
                      Text(
                        isEn ? 'KEY ARCHITECTURAL HIGHLIGHTS' : 'SOROTAN ARSITEKTUR UTAMA',
                        style: AppTypography.badge.copyWith(
                          color: AppColors.textPrimary,
                          letterSpacing: 1.1,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Column(
                        children: project.getKeyFeatures(isEn).map((feature) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 6),
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: project.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: AppTypography.bodyMedium.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 13.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Tech Stack Tags
                      Text(
                        isEn ? 'TECHNOLOGIES USED' : 'TEKNOLOGI YANG DIGUNAKAN',
                        style: AppTypography.badge.copyWith(
                          color: AppColors.textPrimary,
                          letterSpacing: 1.1,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: project.tags.map((tag) {
                          return TechBadge(
                            label: tag,
                            color: project.primaryColor,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

