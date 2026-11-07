import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../models/certification_model.dart';
import '../../widgets/badges/tech_badge.dart';
import '../../widgets/cards/glass_card.dart';
import 'certification_detail_modal.dart';

class CertificationCard extends StatefulWidget {
  final CertificationModel cert;

  const CertificationCard({super.key, required this.cert});

  @override
  State<CertificationCard> createState() => _CertificationCardState();
}

class _CertificationCardState extends State<CertificationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cert = widget.cert;
    final strings = AppStrings(LocaleController.instance.currentLanguage);
    final title = strings.isId ? cert.titleId : cert.titleEn;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => CertificationDetailModal.show(context, cert),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
          child: GlassCard(
            borderRadius: 24,
            blur: 16,
            padding: EdgeInsets.zero,
            backgroundColor: _isHovered
                ? Colors.white.withValues(alpha: 0.96)
                : Colors.white.withValues(alpha: 0.86),
            borderColor: _isHovered
                ? cert.accentColor.withValues(alpha: 0.6)
                : const Color(0xFFE2E8F0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Certificate Thumbnail Preview with Zoom
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    color: const Color(0xFFF1F5F9),
                    child: Stack(
                      children: [
                        // Zooming Certificate Preview Image
                        AnimatedScale(
                          scale: _isHovered ? 1.06 : 1.0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          child: SizedBox.expand(
                            child: Image.asset(
                              cert.frontImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stack) {
                                return Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        cert.icon,
                                        size: 40,
                                        color: cert.accentColor,
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Preview Sertifikat',
                                        style: AppTypography.bodySmall,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Soft Gradient Overlay at Bottom of Image
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withValues(alpha: 0.25),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Verified Badge (Top Right)
                        Positioned(
                          top: 14,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.95),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFCBD5E1),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.08),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.verified_rounded,
                                  size: 13,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  cert.year,
                                  style: AppTypography.badge.copyWith(
                                    fontSize: 11,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 2 Pages Indicator Badge (Bottom Left)
                        Positioned(
                          bottom: 12,
                          left: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F172A).withValues(alpha: 0.75),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.pages_rounded,
                                  size: 12,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '2 Pages (Depan & Belakang)',
                                  style: AppTypography.code.copyWith(
                                    color: Colors.white,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
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

                // Card Details Body
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Issuer
                      Row(
                        children: [
                          Icon(
                            cert.icon,
                            size: 14,
                            color: cert.accentColor,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              cert.issuer,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.bodySmall.copyWith(
                                color: cert.accentColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 11.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Title
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.headingSmall.copyWith(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w700,
                          color: _isHovered
                              ? cert.accentColor
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Skills Chips
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: cert.skills.take(2).map((skill) {
                          return TechBadge(
                            label: skill,
                            color: cert.accentColor,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 18),

                      // Action Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              strings.viewCertificateDetail,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.button.copyWith(
                                color: cert.accentColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          AnimatedSlide(
                            offset: Offset(_isHovered ? 0.2 : 0, 0),
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: cert.accentColor.withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.open_in_new_rounded,
                                size: 14,
                                color: cert.accentColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
