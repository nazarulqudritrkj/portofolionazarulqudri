import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../core/utils/responsive.dart';
import '../../controllers/navigation_controller.dart';
import '../../widgets/badges/pulsing_badge.dart';
import '../../widgets/common/clean_button.dart';
import '../../widgets/modals/digital_cv_modal.dart';
import 'hero_visual_card.dart';

class HeroSection extends StatelessWidget {
  final NavigationController navController;

  const HeroSection({super.key, required this.navController});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final strings = AppStrings(LocaleController.instance.currentLanguage);

        return ContentConstrainedBox(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 32,
            vertical: isMobile ? 40 : 80,
          ),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: _buildHeroTextContent(
                        context,
                        strings: strings,
                        isMobile: false,
                      ),
                    ),
                    const SizedBox(width: 48),
                    Expanded(
                      flex: 5,
                      child: Center(child: const HeroVisualCard()),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeroTextContent(
                      context,
                      strings: strings,
                      isMobile: true,
                    ),
                    const SizedBox(height: 56),
                    const HeroVisualCard(),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildHeroTextContent(
    BuildContext context, {
    required AppStrings strings,
    required bool isMobile,
  }) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // 1. Status Pill Badge
        PulsingBadge(label: strings.statusAvailable)
            .animate()
            .fadeIn(duration: 600.ms, curve: Curves.easeOutCubic)
            .slideY(begin: 0.2, end: 0, duration: 600.ms),

        const SizedBox(height: 24),

        // 2. Main Greeting & Name
        RichText(
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          text: TextSpan(
            children: [
              TextSpan(
                text: strings.heroGreeting,
                style: (isMobile
                        ? AppTypography.displaySmall
                        : AppTypography.displayLarge)
                    .copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.baseline,
                baseline: TextBaseline.alphabetic,
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Color(0xFF0284C7),
                      Color(0xFF2563EB),
                      Color(0xFF38BDF8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    AppConstants.fullName,
                    style: (isMobile
                            ? AppTypography.displaySmall
                            : AppTypography.displayLarge)
                        .copyWith(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 700.ms)
            .slideY(begin: 0.15, end: 0, delay: 200.ms),

        const SizedBox(height: 18),

        // 3. Subtitle / Tagline
        Text(
          strings.heroTagline,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: (isMobile
                  ? AppTypography.headingMedium
                  : AppTypography.headingLarge)
              .copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        )
            .animate()
            .fadeIn(delay: 350.ms, duration: 700.ms)
            .slideY(begin: 0.15, end: 0, delay: 350.ms),

        const SizedBox(height: 16),

        // 4. Detailed Description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 580),
          child: Text(
            strings.heroBio,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              fontSize: isMobile ? 14.5 : 16,
              height: 1.65,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 500.ms, duration: 700.ms)
            .slideY(begin: 0.15, end: 0, delay: 500.ms),

        const SizedBox(height: 36),

        // 5. Action Buttons (View My Works & Download CV)
        Wrap(
          spacing: 16,
          runSpacing: 14,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            CleanButton(
              text: strings.viewWorks,
              icon: Icons.arrow_downward_rounded,
              isTrailingIcon: true,
              variant: CleanButtonVariant.primary,
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
              onPressed: () => navController.scrollToSection(3), // Projects
            ),
            CleanButton(
              text: strings.downloadCv,
              icon: Icons.file_download_outlined,
              variant: CleanButtonVariant.outline,
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Colors.black.withValues(alpha: 0.6),
                  builder: (context) => const DigitalCvModal(),
                );
              },
            ),
          ],
        )
            .animate()
            .fadeIn(delay: 650.ms, duration: 700.ms)
            .slideY(begin: 0.15, end: 0, delay: 650.ms),

        const SizedBox(height: 36),

        // 6. Fast Trust Bar / Tech Stack Badges
        Row(
          mainAxisAlignment: isMobile
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Text(
              strings.specializedIn,
              style: AppTypography.badge.copyWith(
                color: AppColors.textMuted,
                letterSpacing: 1.1,
                fontSize: 11,
              ),
            ),
            const SizedBox(width: 14),
            _buildMiniTechIcon(
                Icons.flutter_dash, 'Flutter', const Color(0xFF0284C7)),
            const SizedBox(width: 8),
            _buildMiniTechIcon(
                Icons.code_rounded, 'Dart', const Color(0xFF2563EB)),
            const SizedBox(width: 8),
            _buildMiniTechIcon(
                Icons.memory_rounded, 'IoT (CPS)', const Color(0xFF06B6D4)),
            const SizedBox(width: 8),
            _buildMiniTechIcon(
                Icons.psychology_rounded, 'AI (Rule-Based)', const Color(0xFF7C3AED)),
            const SizedBox(width: 8),
            _buildMiniTechIcon(
                Icons.lan_rounded, 'Networking (TRKJ)', const Color(0xFF10B981)),
          ],
        )
            .animate()
            .fadeIn(delay: 800.ms, duration: 700.ms),
      ],
    );
  }

  Widget _buildMiniTechIcon(IconData icon, String tooltip, Color color) {
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color.withValues(alpha: 0.25),
            width: 1.0,
          ),
        ),
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}
