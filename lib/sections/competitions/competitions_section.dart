import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../core/utils/responsive.dart';
import '../../models/certification_model.dart';
import '../../widgets/cards/glass_card.dart';
import '../../widgets/common/section_title.dart';
import '../certifications/certification_detail_modal.dart';

class CompetitionsSection extends StatelessWidget {
  const CompetitionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final awards = CertificationModel.competitionAwards;

    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final strings = AppStrings(LocaleController.instance.currentLanguage);
        return _buildContent(context, strings, isMobile, awards);
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    AppStrings strings,
    bool isMobile,
    List<CertificationModel> awards,
  ) {
    return ContentConstrainedBox(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 50 : 80,
      ),
      child: Column(
        children: [
          // Section Title
          SectionTitle(
            tag: strings.competitionsTag,
            title: strings.competitionsTitle,
            subtitle: strings.competitionsSubtitle,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: 48),

          // 2-Column Grid on Desktop / Tablet, 1-Column on Mobile
          LayoutBuilder(
            builder: (context, constraints) {
              final double maxWidth = constraints.maxWidth;
              final bool isWide = maxWidth > 760;

              if (isWide) {
                return Wrap(
                  spacing: 24,
                  runSpacing: 24,
                  children: awards.map((award) {
                    final cardWidth = (maxWidth - 24) / 2;
                    return SizedBox(
                      width: cardWidth,
                      child: _CompetitionAwardCard(
                        award: award,
                        strings: strings,
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Column(
                  children: awards.map((award) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _CompetitionAwardCard(
                        award: award,
                        strings: strings,
                      ),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _CompetitionAwardCard extends StatefulWidget {
  final CertificationModel award;
  final AppStrings strings;

  const _CompetitionAwardCard({
    required this.award,
    required this.strings,
  });

  @override
  State<_CompetitionAwardCard> createState() => _CompetitionAwardCardState();
}

class _CompetitionAwardCardState extends State<_CompetitionAwardCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final award = widget.award;
    final title = widget.strings.isId ? award.titleId : award.titleEn;
    final desc = widget.strings.isId
        ? award.descriptionId
        : award.descriptionEn;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GlassCard(
        borderRadius: 22,
        blur: 20,
        padding: const EdgeInsets.all(22),
        backgroundColor: Colors.white.withValues(alpha: 0.94),
        borderColor: _isHovered
            ? award.accentColor.withValues(alpha: 0.6)
            : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Award Badge & Year
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: award.accentColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: award.accentColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        award.icon,
                        color: award.accentColor,
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        widget.strings.isId ? 'TINGKAT NASIONAL' : 'NATIONAL LEVEL',
                        style: AppTypography.badge.copyWith(
                          color: award.accentColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          fontSize: 10.5,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    award.year,
                    style: AppTypography.badge.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // Thumbnail Preview with Zoom on Hover
            GestureDetector(
              onTap: () => CertificationDetailModal.show(context, award),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    height: 190,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      border: Border.all(
                        color: const Color(0xFFE2E8F0),
                      ),
                    ),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AnimatedScale(
                          scale: _isHovered ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          child: Image.asset(
                            award.frontImage,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                              child: Icon(
                                award.icon,
                                size: 44,
                                color: award.accentColor,
                              ),
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _isHovered ? 0.35 : 0.0,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            color: Colors.black,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.zoom_in_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  widget.strings.isId
                                      ? 'Perbesar Piagam'
                                      : 'Inspect Award',
                                  style: AppTypography.bodySmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Title
            Text(
              title,
              style: AppTypography.headingSmall.copyWith(
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 6),

            // Issuer / Event organizer
            Text(
              award.issuer,
              style: AppTypography.bodySmall.copyWith(
                color: award.accentColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 10),

            // Description
            Text(
              desc,
              style: AppTypography.bodyMedium.copyWith(
                height: 1.5,
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 14),

            // Skill pills
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: award.skills.take(3).map((skill) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Text(
                    skill,
                    style: AppTypography.badge.copyWith(
                      color: AppColors.textSecondary,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 18),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    CertificationDetailModal.show(context, award),
                icon: const Icon(Icons.workspace_premium_rounded, size: 18),
                label: Text(widget.strings.viewAward),
                style: OutlinedButton.styleFrom(
                  foregroundColor: award.accentColor,
                  side: BorderSide(
                    color: _isHovered
                        ? award.accentColor
                        : const Color(0xFFCBD5E1),
                    width: 1.5,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
