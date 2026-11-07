import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../core/utils/responsive.dart';
import '../../models/certification_model.dart';
import '../../widgets/common/section_title.dart';
import 'certification_card.dart';

class CertificationsSection extends StatefulWidget {
  const CertificationsSection({super.key});

  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection> {
  CertificationCategory _selectedCategory = CertificationCategory.all;
  bool _isCarouselView = false;
  int _currentCarouselIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final strings = AppStrings(LocaleController.instance.currentLanguage);

    final allCerts = CertificationModel.trainingCertifications;
    final trainingCategories = [
      CertificationCategory.all,
      CertificationCategory.aiTech,
      CertificationCategory.cloudSecurity,
      CertificationCategory.digitalProduct,
      CertificationCategory.strategy,
    ];
    final filteredCerts = _selectedCategory == CertificationCategory.all
        ? allCerts
        : allCerts.where((c) => c.category == _selectedCategory).toList();

    int crossAxisCount = 3;
    if (isMobile) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    }

    final double viewportFraction = isMobile ? 0.90 : (isTablet ? 0.52 : 0.36);

    return ContentConstrainedBox(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 50 : 90,
      ),
      child: Column(
        children: [
          // Section Title
          SectionTitle(
            tag: strings.certsTag,
            title: strings.certsTitle,
            subtitle: strings.certsSubtitle,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),

          const SizedBox(height: 36),

          // Category Filter Tabs & View Mode Switcher
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              // Category Filter Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: trainingCategories.map((cat) {
                    final label = strings.isId ? cat.labelId : cat.labelEn;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildCategoryPill(label, cat),
                    );
                  }).toList(),
                ),
              ),

              // View Mode Toggle Button
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildViewToggleButton(
                      icon: Icons.grid_view_rounded,
                      tooltip: 'Grid View',
                      isSelected: !_isCarouselView,
                      onTap: () => setState(() => _isCarouselView = false),
                    ),
                    const SizedBox(width: 4),
                    _buildViewToggleButton(
                      icon: Icons.view_carousel_rounded,
                      tooltip: 'Horizontal Snap Carousel',
                      isSelected: _isCarouselView,
                      onTap: () => setState(() => _isCarouselView = true),
                    ),
                  ],
                ),
              ),
            ],
          ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

          const SizedBox(height: 44),

          // Certifications Display
          _isCarouselView
              ? _buildCarouselView(filteredCerts, viewportFraction)
              : _buildGridView(filteredCerts, crossAxisCount, isMobile),
        ],
      ),
    );
  }

  Widget _buildCarouselView(
    List<CertificationModel> filteredCerts,
    double viewportFraction,
  ) {
    return Column(
      children: [
        SizedBox(
          height: 460,
          child: PageView.builder(
            controller: PageController(
              viewportFraction: viewportFraction,
              initialPage: _currentCarouselIndex,
            ),
            physics: const BouncingScrollPhysics(),
            onPageChanged: (i) => setState(() => _currentCarouselIndex = i),
            itemCount: filteredCerts.length,
            itemBuilder: (context, index) {
              final cert = filteredCerts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CertificationCard(cert: cert),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(filteredCerts.length, (index) {
            final isSelected = _currentCarouselIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isSelected ? 24 : 8,
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: isSelected ? AppColors.primary : const Color(0xFFCBD5E1),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildGridView(
    List<CertificationModel> filteredCerts,
    int crossAxisCount,
    bool isMobile,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double spacing = isMobile ? 20 : 28;
        final double totalSpacing = spacing * (crossAxisCount - 1);
        final double itemWidth =
            (constraints.maxWidth - totalSpacing) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: filteredCerts.asMap().entries.map((entry) {
            final index = entry.key;
            final cert = entry.value;

            return SizedBox(
              width: itemWidth,
              child: CertificationCard(cert: cert)
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 80 * index),
                    duration: 450.ms,
                  )
                  .scale(
                    begin: const Offset(0.96, 0.96),
                    end: const Offset(1.0, 1.0),
                    delay: Duration(milliseconds: 80 * index),
                    duration: 450.ms,
                  ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildCategoryPill(String label, CertificationCategory category) {
    final isSelected = _selectedCategory == category;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategory = category),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
              width: 1.2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.28),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Text(
            label,
            style: AppTypography.button.copyWith(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 12.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildViewToggleButton({
    required IconData icon,
    required String tooltip,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.softCyan : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 18,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}

