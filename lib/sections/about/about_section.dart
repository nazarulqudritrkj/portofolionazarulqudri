import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_helper.dart';
import '../../models/experience_model.dart';
import '../../widgets/cards/architecture_terminal.dart';
import '../../widgets/cards/glass_card.dart';
import '../../widgets/common/clean_button.dart';
import '../../widgets/common/section_title.dart';
import 'timeline_item_widget.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);
    final experiences = ExperienceModel.timelineList;

    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final strings = AppStrings(LocaleController.instance.currentLanguage);

        return ContentConstrainedBox(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 32,
            vertical: isMobile ? 50 : 90,
          ),
          child: Column(
            children: [
              // Section Header
              SectionTitle(
                tag: strings.aboutTag,
                title: strings.aboutTitle,
                subtitle: strings.aboutSubtitle,
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 60),

              // Main Split Layout
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Side: Interactive Bio, Pillars, & Terminal
                        Expanded(
                          flex: 6,
                          child: _buildBioAndPillars(context, strings),
                        ),
                        const SizedBox(width: 48),
                        // Right Side: Experience Timeline
                        Expanded(
                          flex: 6,
                          child: _buildTimeline(experiences, strings),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildBioAndPillars(context, strings),
                        const SizedBox(height: 48),
                        _buildTimeline(experiences, strings),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBioAndPillars(BuildContext context, AppStrings strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Bio Glass Card
        GlassCard(
          borderRadius: 24,
          blur: 20,
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.softCyan,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.person_pin_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppConstants.fullName,
                        style: AppTypography.headingSmall.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'Banda Aceh, Indonesia • UTC+7',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                strings.aboutBioP1,
                style: AppTypography.bodyLarge.copyWith(
                  height: 1.65,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                strings.aboutBioP2,
                style: AppTypography.bodyLarge.copyWith(
                  height: 1.65,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 24),
              CleanButton(
                text: strings.downloadFullResume,
                icon: Icons.download_rounded,
                variant: CleanButtonVariant.outline,
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onPressed: () =>
                    UrlHelper.openUrl(AppConstants.resumeUrl, context: context),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Three Core Engineering Pillars
        _buildPillarTile(
          icon: Icons.layers_outlined,
          title: strings.pillar1Title,
          description: strings.pillar1Desc,
          color: const Color(0xFF0284C7),
        ),
        const SizedBox(height: 14),
        _buildPillarTile(
          icon: Icons.sensors_rounded,
          title: strings.pillar2Title,
          description: strings.pillar2Desc,
          color: const Color(0xFF2563EB),
        ),
        const SizedBox(height: 14),
        _buildPillarTile(
          icon: Icons.speed_rounded,
          title: strings.pillar3Title,
          description: strings.pillar3Desc,
          color: const Color(0xFF06B6D4),
        ),

        const SizedBox(height: 28),

        // Architecture Code Sandbox Terminal
        const ArchitectureTerminal(),
      ],
    );
  }

  Widget _buildPillarTile({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return GlassCard(
      borderRadius: 18,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: color.withValues(alpha: 0.2),
                width: 1.0,
              ),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.headingSmall.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.5,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(
    List<ExperienceModel> experiences,
    AppStrings strings,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              strings.timelineTitle,
              style: AppTypography.badge.copyWith(
                color: AppColors.textPrimary,
                letterSpacing: 1.0,
                fontSize: 13,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        ...experiences.asMap().entries.map((entry) {
          final index = entry.key;
          final exp = entry.value;
          final isLast = index == experiences.length - 1;

          return TimelineItemWidget(
            experience: exp,
            isLast: isLast,
          );
        }),
      ],
    );
  }
}
