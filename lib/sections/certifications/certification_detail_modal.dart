import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../models/certification_model.dart';
import '../../widgets/badges/tech_badge.dart';

class CertificationDetailModal extends StatefulWidget {
  final CertificationModel cert;

  const CertificationDetailModal({super.key, required this.cert});

  static Future<void> show(BuildContext context, CertificationModel cert) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Certification Details',
      barrierColor: Colors.black.withValues(alpha: 0.65),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, anim1, anim2) {
        return CertificationDetailModal(cert: cert);
      },
      transitionBuilder: (context, anim1, anim2, child) {
        final curve = CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic);
        return ScaleTransition(
          scale: Tween<double>(begin: 0.94, end: 1.0).animate(curve),
          child: FadeTransition(
            opacity: curve,
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<CertificationDetailModal> createState() =>
      _CertificationDetailModalState();
}

class _CertificationDetailModalState extends State<CertificationDetailModal> {
  int _activePage = 0; // 0 = Front (Page 1), 1 = Back (Page 2)
  final TransformationController _transformController = TransformationController();

  @override
  void dispose() {
    _transformController.dispose();
    super.dispose();
  }

  void _resetZoom() {
    _transformController.value = Matrix4.identity();
  }

  @override
  Widget build(BuildContext context) {
    final cert = widget.cert;
    final strings = AppStrings(LocaleController.instance.currentLanguage);
    final title = strings.isId ? cert.titleId : cert.titleEn;
    final desc = strings.isId ? cert.descriptionId : cert.descriptionEn;
    final currentImage = _activePage == 0 ? cert.frontImage : cert.backImage;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 880, maxHeight: 900),
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.98),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.22),
                  blurRadius: 48,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Modal Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 18,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8FAFC),
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFE2E8F0),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: cert.accentColor.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  cert.icon,
                                  color: cert.accentColor,
                                  size: 22,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 260,
                                    child: Text(
                                      title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTypography.headingSmall.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    cert.issuer,
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.primary,
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              // Reset Zoom button
                              Tooltip(
                                message: 'Reset Zoom (100%)',
                                child: IconButton(
                                  onPressed: _resetZoom,
                                  icon: const Icon(Icons.refresh_rounded, size: 20),
                                ),
                              ),
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.close_rounded),
                                style: IconButton.styleFrom(
                                  backgroundColor: const Color(0xFFE2E8F0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Scrollable Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Page Segmented Switcher (Shown only if certificate has 2 distinct pages)
                            if (cert.frontImage != cert.backImage && cert.backImage.isNotEmpty)
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: const Color(0xFFCBD5E1),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _buildPageTab(
                                        label: cert.category == CertificationCategory.academic
                                            ? '🇮🇩 Versi Indonesia'
                                            : strings.page1Front,
                                        icon: cert.category == CertificationCategory.academic
                                            ? Icons.translate_rounded
                                            : Icons.workspace_premium_rounded,
                                        isSelected: _activePage == 0,
                                        onTap: () {
                                          setState(() => _activePage = 0);
                                          _resetZoom();
                                        },
                                      ),
                                      const SizedBox(width: 6),
                                      _buildPageTab(
                                        label: cert.category == CertificationCategory.academic
                                            ? '🇬🇧 English Version'
                                            : strings.page2Back,
                                        icon: cert.category == CertificationCategory.academic
                                            ? Icons.language_rounded
                                            : Icons.menu_book_rounded,
                                        isSelected: _activePage == 1,
                                        onTap: () {
                                          setState(() => _activePage = 1);
                                          _resetZoom();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: AppColors.softCyan.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.verified_rounded, size: 16, color: AppColors.primary),
                                      const SizedBox(width: 6),
                                      Text(
                                        strings.isId ? 'Piagam Resmi • Full Resolution' : 'Official Document • Full Resolution',
                                        style: AppTypography.bodySmall.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(height: 18),

                            // Interactive Zoomable Certificate Viewer
                            Container(
                              height: 380,
                              decoration: BoxDecoration(
                                color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                  width: 1.5,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    InteractiveViewer(
                                      transformationController: _transformController,
                                      minScale: 0.8,
                                      maxScale: 4.0,
                                      child: Center(
                                        child: Image.asset(
                                          currentImage,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stack) {
                                            return Center(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.broken_image_rounded,
                                                    size: 48,
                                                    color: AppColors.textMuted,
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    'Dokumen $currentImage',
                                                    style: AppTypography.bodySmall,
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),

                                    // Zoom Hint Pill
                                    Positioned(
                                      bottom: 12,
                                      right: 12,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.9),
                                          borderRadius: BorderRadius.circular(12),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withValues(alpha: 0.06),
                                              blurRadius: 8,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(
                                              Icons.zoom_in_rounded,
                                              size: 14,
                                              color: AppColors.primary,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              strings.tapToZoom,
                                              style: AppTypography.bodySmall.copyWith(
                                                fontSize: 11,
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
                            const SizedBox(height: 20),

                            // Description
                            Text(
                              desc,
                              style: AppTypography.bodyMedium.copyWith(
                                fontSize: 14.5,
                                height: 1.6,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: 18),

                            // Skills tags
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: cert.skills.map((skill) {
                                return TechBadge(
                                  label: skill,
                                  color: cert.accentColor,
                                );
                              }).toList(),
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
      ),
    );
  }

  Widget _buildPageTab({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: const Color(0xFFCBD5E1), width: 1.0)
                : null,
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 15,
                color: isSelected ? AppColors.primary : AppColors.textMuted,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTypography.button.copyWith(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

