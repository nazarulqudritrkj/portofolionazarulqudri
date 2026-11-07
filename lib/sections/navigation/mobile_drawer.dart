import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/common/clean_button.dart';
import '../../widgets/badges/pulsing_badge.dart';

class MobileDrawer extends StatelessWidget {
  final NavigationController navController;

  const MobileDrawer({super.key, required this.navController});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final strings = AppStrings(LocaleController.instance.currentLanguage);
        final navLabels = [
          strings.navHome,
          strings.navAbout,
          strings.isId ? 'Ijazah & Transkrip' : 'Degree & Records',
          strings.navProjects,
          strings.isId ? 'Prestasi Lomba' : 'Awards & Honors',
          strings.isId ? 'Pelatihan Kominfo' : 'DTS Training',
          strings.navSkills,
          strings.navContact,
        ];

        return Drawer(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                color: Colors.white.withValues(alpha: 0.95),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 38,
                                height: 38,
                                decoration: BoxDecoration(
                                  gradient: AppColors.primaryGradient,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  AppConstants.initials,
                                  style: AppTypography.headingSmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                AppConstants.fullName,
                                style: AppTypography.headingSmall.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close_rounded),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Language Switcher in Drawer
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.iceBlue,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFBAE6FD),
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pilihan Bahasa / Language:',
                              style: AppTypography.bodySmall.copyWith(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => LocaleController.instance
                                      .setLanguage(AppLanguage.id),
                                  child: Text(
                                    '🇮🇩 ID',
                                    style: AppTypography.code.copyWith(
                                      fontWeight: LocaleController
                                              .instance.isIndonesian
                                          ? FontWeight.w800
                                          : FontWeight.w400,
                                      color: LocaleController
                                              .instance.isIndonesian
                                          ? AppColors.primary
                                          : AppColors.textMuted,
                                    ),
                                  ),
                                ),
                                const Text(' | '),
                                GestureDetector(
                                  onTap: () => LocaleController.instance
                                      .setLanguage(AppLanguage.en),
                                  child: Text(
                                    'EN 🇬🇧',
                                    style: AppTypography.code.copyWith(
                                      fontWeight: LocaleController
                                              .instance.isEnglish
                                          ? FontWeight.w800
                                          : FontWeight.w400,
                                      color: LocaleController
                                              .instance.isEnglish
                                          ? AppColors.primary
                                          : AppColors.textMuted,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      PulsingBadge(label: strings.statusAvailable),
                      const SizedBox(height: 20),
                      const Divider(color: Color(0xFFE2E8F0)),
                      const SizedBox(height: 12),

                      // Nav items list
                      Expanded(
                        child: ListView.separated(
                          itemCount: navLabels.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final isSelected =
                                navController.currentIndex == index;
                            final label = navLabels[index];

                            return ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              tileColor: isSelected
                                  ? AppColors.softCyan
                                  : Colors.transparent,
                              leading: Icon(
                                _getIconForIndex(index),
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                                size: 20,
                              ),
                              title: Text(
                                label,
                                style: AppTypography.button.copyWith(
                                  color: isSelected
                                      ? AppColors.primaryDark
                                      : AppColors.textPrimary,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  fontSize: 14.5,
                                ),
                              ),
                              trailing: isSelected
                                  ? Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.primary,
                                      ),
                                    )
                                  : null,
                              onTap: () {
                                Navigator.of(context).pop();
                                navController.scrollToSection(index);
                              },
                            );
                          },
                        ),
                      ),

                      // Bottom CTA
                      CleanButton(
                        text: strings.letsTalk,
                        icon: Icons.chat_bubble_outline_rounded,
                        variant: CleanButtonVariant.primary,
                        height: 50,
                        onPressed: () {
                          Navigator.of(context).pop();
                          navController.scrollToSection(7);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.home_rounded;
      case 1:
        return Icons.person_rounded;
      case 2:
        return Icons.school_rounded;
      case 3:
        return Icons.terminal_rounded;
      case 4:
        return Icons.emoji_events_rounded;
      case 5:
        return Icons.workspace_premium_rounded;
      case 6:
        return Icons.psychology_rounded;
      case 7:
        return Icons.mail_rounded;
      default:
        return Icons.circle;
    }
  }
}
