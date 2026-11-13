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

class AcademicCredentialsSection extends StatelessWidget {
  const AcademicCredentialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final docs = CertificationModel.academicDocuments;

    if (docs.length < 2) return const SizedBox.shrink();
    final ijazah = docs[0];
    final transkrip = docs[1];

    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final strings = AppStrings(LocaleController.instance.currentLanguage);
        return _buildContent(context, strings, isMobile, isDesktop, ijazah, transkrip);
      },
    );
  }

  Widget _buildContent(
    BuildContext context,
    AppStrings strings,
    bool isMobile,
    bool isDesktop,
    CertificationModel ijazah,
    CertificationModel transkrip,
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
            tag: strings.academicTag,
            title: strings.academicTitle,
            subtitle: strings.academicSubtitle,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: 48),

          // Side-by-side on Desktop, Stack on Mobile
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _AcademicDocCard(
                        doc: ijazah,
                        badgeLabel: strings.isId
                            ? 'IJAZAH RESMI TERAKREDITASI'
                            : 'OFFICIAL ACCREDITED DEGREE',
                        badgeIcon: Icons.school_rounded,
                        primaryColor: const Color(0xFF0284C7),
                        strings: strings,
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: _AcademicDocCard(
                        doc: transkrip,
                        badgeLabel: strings.isId
                            ? 'TRANSKRIP NILAI KUMULATIF'
                            : 'CUMULATIVE TRANSCRIPT',
                        badgeIcon: Icons.receipt_long_rounded,
                        primaryColor: const Color(0xFF2563EB),
                        strings: strings,
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _AcademicDocCard(
                      doc: ijazah,
                      badgeLabel: strings.isId
                          ? 'IJAZAH RESMI TERAKREDITASI'
                          : 'OFFICIAL ACCREDITED DEGREE',
                      badgeIcon: Icons.school_rounded,
                      primaryColor: const Color(0xFF0284C7),
                      strings: strings,
                    ),
                    const SizedBox(height: 28),
                    _AcademicDocCard(
                      doc: transkrip,
                      badgeLabel: strings.isId
                          ? 'TRANSKRIP NILAI KUMULATIF'
                          : 'CUMULATIVE TRANSCRIPT',
                      badgeIcon: Icons.receipt_long_rounded,
                      primaryColor: const Color(0xFF2563EB),
                      strings: strings,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}

class _AcademicDocCard extends StatefulWidget {
  final CertificationModel doc;
  final String badgeLabel;
  final IconData badgeIcon;
  final Color primaryColor;
  final AppStrings strings;

  const _AcademicDocCard({
    required this.doc,
    required this.badgeLabel,
    required this.badgeIcon,
    required this.primaryColor,
    required this.strings,
  });

  @override
  State<_AcademicDocCard> createState() => _AcademicDocCardState();
}

class _AcademicDocCardState extends State<_AcademicDocCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final title = widget.strings.isId ? widget.doc.titleId : widget.doc.titleEn;
    final desc = widget.strings.isId
        ? widget.doc.descriptionId
        : widget.doc.descriptionEn;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GlassCard(
        borderRadius: 24,
        blur: 24,
        padding: const EdgeInsets.all(24),
        backgroundColor: Colors.white.withValues(alpha: 0.95),
        borderColor: _isHovered
            ? widget.primaryColor.withValues(alpha: 0.6)
            : Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header Pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: widget.primaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.primaryColor.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.badgeIcon,
                        color: widget.primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.badgeLabel,
                        style: AppTypography.badge.copyWith(
                          color: widget.primaryColor,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          fontSize: 11,
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_user_rounded,
                        color: Color(0xFF10B981),
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.strings.isId ? 'Terverifikasi' : 'Verified',
                        style: AppTypography.badge.copyWith(
                          color: const Color(0xFF10B981),
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Document Image Preview with Hover Zoom
            GestureDetector(
              onTap: () => CertificationDetailModal.show(context, widget.doc),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 220,
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
                          duration: const Duration(milliseconds: 320),
                          curve: Curves.easeOutCubic,
                          child: Image.asset(
                            widget.doc.frontImage,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                Center(
                              child: Icon(
                                widget.badgeIcon,
                                size: 48,
                                color: widget.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        // Subtle dark overlay on hover to indicate clickability
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
                                  size: 26,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  widget.strings.isId
                                      ? 'Perbesar Dokumen'
                                      : 'Inspect Document',
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

            const SizedBox(height: 20),

            // Document Title
            Text(
              title,
              style: AppTypography.headingSmall.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                height: 1.35,
              ),
            ),

            const SizedBox(height: 8),

            // Issuer
            Row(
              children: [
                Icon(
                  Icons.account_balance_rounded,
                  size: 15,
                  color: widget.primaryColor,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.doc.issuer,
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Description
            Text(
              desc,
              style: AppTypography.bodyMedium.copyWith(
                height: 1.55,
                color: AppColors.textSecondary,
                fontSize: 13.5,
              ),
            ),

            const SizedBox(height: 18),

            // Feature badges (Bilingual support badges)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _FeaturePill(
                  label: '🇮🇩 Bahasa Indonesia',
                  color: Color(0xFFEF4444),
                ),
                _FeaturePill(
                  label: '🇬🇧 English Certified',
                  color: Color(0xFF2563EB),
                ),
                _FeaturePill(
                  label: '400% Ultra Zoom',
                  color: Color(0xFF10B981),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () =>
                    CertificationDetailModal.show(context, widget.doc),
                icon: const Icon(Icons.fullscreen_rounded, size: 20),
                label: Text(
                  widget.doc.id == 'cert-ijazah-resmi'
                      ? widget.strings.viewDegree
                      : widget.strings.viewTranscript,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: _isHovered ? 4 : 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
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

class _FeaturePill extends StatelessWidget {
  final String label;
  final Color color;

  const _FeaturePill({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        label,
        style: AppTypography.badge.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
        ),
      ),
    );
  }
}
