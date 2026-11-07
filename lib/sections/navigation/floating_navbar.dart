import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../core/utils/responsive.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/common/clean_button.dart';

class FloatingNavbar extends StatelessWidget {
  final NavigationController navController;
  final VoidCallback onOpenDrawer;

  const FloatingNavbar({
    super.key,
    required this.navController,
    required this.onOpenDrawer,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return ListenableBuilder(
      listenable: Listenable.merge([navController, LocaleController.instance]),
      builder: (context, _) {
        final isScrolled = navController.isScrolled;
        final strings = AppStrings(LocaleController.instance.currentLanguage);

        final navItems = [
          (label: strings.navHome, tooltip: strings.navHomeTooltip),
          (label: strings.navAbout, tooltip: strings.navAboutTooltip),
          (label: strings.navAcademic, tooltip: strings.navAcademicTooltip),
          (label: strings.navProjects, tooltip: strings.navProjectsTooltip),
          (label: strings.navCompetitions, tooltip: strings.navCompetitionsTooltip),
          (label: strings.navCertificates, tooltip: strings.navCertificatesTooltip),
          (label: strings.navSkills, tooltip: strings.navSkillsTooltip),
          (label: strings.navContact, tooltip: strings.navContactTooltip),
        ];

        return Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.only(
              top: isMobile ? 12 : (isScrolled ? 10 : 20),
              left: isMobile ? 16 : 24,
              right: isMobile ? 16 : 24,
            ),
            constraints: const BoxConstraints(maxWidth: 1320),
            height: isMobile ? 62 : 68,
            decoration: BoxDecoration(
              color: isScrolled
                  ? Colors.white.withValues(alpha: 0.94)
                  : Colors.white.withValues(alpha: 0.82),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: isScrolled
                    ? const Color(0xFFE2E8F0)
                    : Colors.white.withValues(alpha: 0.85),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(
                    alpha: isScrolled ? 0.08 : 0.03,
                  ),
                  blurRadius: isScrolled ? 24 : 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Brandmark "NQ" Logo
                      _buildLogo(context, strings),

                      // Desktop Navigation Links
                      if (isDesktop) ...[
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                navItems.length,
                                (index) => _buildNavItem(
                                  label: navItems[index].label,
                                  tooltip: navItems[index].tooltip,
                                  isSelected: navController.currentIndex == index,
                                  onTap: () => navController.scrollToSection(index),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Language Switcher (ID / EN)
                            _buildLanguageToggle(),
                            const SizedBox(width: 10),

                            // "Let's Talk" CTA Button
                            CleanButton(
                              text: strings.letsTalk,
                              icon: Icons.chat_bubble_outline_rounded,
                              variant: CleanButtonVariant.primary,
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 9,
                              ),
                              onPressed: () =>
                                  navController.scrollToSection(7), // Contact
                            ),
                          ],
                        ),
                      ] else ...[
                        // Mobile & Tablet: Language Switcher + Hamburger Menu
                        Row(
                          children: [
                            _buildLanguageToggle(),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: onOpenDrawer,
                              icon: const Icon(
                                Icons.menu_rounded,
                                color: AppColors.textPrimary,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ],
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

  Widget _buildLogo(BuildContext context, AppStrings strings) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => navController.scrollToSection(0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                AppConstants.initials,
                style: AppTypography.headingSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              AppConstants.fullName,
              style: AppTypography.headingSmall.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14.5,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageToggle() {
    final isId = LocaleController.instance.isIndonesian;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => LocaleController.instance.toggleLanguage(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.iceBlue,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFFBAE6FD),
              width: 1.0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '🇮🇩 ID',
                style: AppTypography.code.copyWith(
                  fontSize: 11,
                  fontWeight: isId ? FontWeight.w800 : FontWeight.w400,
                  color: isId ? AppColors.primary : AppColors.textMuted,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: 1,
                height: 12,
                color: const Color(0xFFCBD5E1),
              ),
              Text(
                'EN 🇬🇧',
                style: AppTypography.code.copyWith(
                  fontSize: 11,
                  fontWeight: !isId ? FontWeight.w800 : FontWeight.w400,
                  color: !isId ? AppColors.primary : AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String label,
    required String tooltip,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return _HoverNavItem(
      label: label,
      tooltip: tooltip,
      isSelected: isSelected,
      onTap: onTap,
    );
  }
}

class _HoverNavItem extends StatefulWidget {
  final String label;
  final String tooltip;
  final bool isSelected;
  final VoidCallback onTap;

  const _HoverNavItem({
    required this.label,
    required this.tooltip,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_HoverNavItem> createState() => _HoverNavItemState();
}

class _HoverNavItemState extends State<_HoverNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      waitDuration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
      ),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6.5),
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? AppColors.iceBlue
                  : (_isHovered
                      ? AppColors.iceBlue.withValues(alpha: 0.5)
                      : Colors.transparent),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              widget.label,
              style: AppTypography.button.copyWith(
                color: widget.isSelected
                    ? AppColors.primaryDark
                    : (_isHovered ? AppColors.primary : AppColors.textSecondary),
                fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
