import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/portfolio_pdf_generator.dart';
import '../../core/utils/pdf_downloader_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) '../../core/utils/pdf_downloader_web.dart';
import '../../models/project_model.dart';
import '../../widgets/common/section_title.dart';
import 'project_card.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  ProjectCategory _selectedCategory = ProjectCategory.all;
  bool _isCarouselView = false;
  late final PageController _pageController;
  int _currentCarouselIndex = 0;
  bool _isDownloadingDossier = false;

  Future<void> _downloadPortfolioDossier() async {
    setState(() => _isDownloadingDossier = true);
    try {
      final isEn = LocaleController.instance.isEnglish;
      final pdfBytes = await PortfolioPdfGenerator.generate(isEnglish: isEn);
      final filename = isEn
          ? 'Portfolio_Dossier_Nazarul_Qudri_STRT_EN.pdf'
          : 'Portofolio_Lengkap_Nazarul_Qudri_STRT.pdf';
      await downloadPdfBytes(pdfBytes, filename);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal generate Portofolio: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloadingDossier = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final strings = AppStrings(LocaleController.instance.currentLanguage);
        final allProjects = ProjectModel.sampleProjects;
        final filteredProjects = _selectedCategory == ProjectCategory.all
            ? allProjects
            : allProjects.where((p) => p.category == _selectedCategory).toList();

        int crossAxisCount = 3;
        if (isMobile) {
          crossAxisCount = 1;
        } else if (isTablet) {
          crossAxisCount = 2;
        }

        final double viewportFraction =
            isMobile ? 0.90 : (isTablet ? 0.52 : 0.36);

        return ContentConstrainedBox(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 32,
            vertical: isMobile ? 50 : 90,
          ),
          child: Column(
            children: [
              // Section Title
              SectionTitle(
                tag: strings.projectsTag,
                title: strings.projectsTitle,
                subtitle: strings.projectsSubtitle,
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 36),

              // Category Filter Tabs & Layout Switcher
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
                      children: ProjectCategory.values.map((cat) {
                        final label = strings.isId ? cat.labelId : cat.labelEn;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: _buildCategoryPill(label, cat),
                        );
                      }).toList(),
                    ),
                  ),

                  // View Mode Toggle (Grid vs Snap Carousel)
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

              // Display: Either Snap Carousel or Grid
              _isCarouselView
                  ? _buildCarouselView(filteredProjects, viewportFraction)
                  : _buildGridView(filteredProjects, crossAxisCount, isMobile),

              const SizedBox(height: 48),

              // Download Dossier PDF Banner
              _buildDownloadDossierBanner(context, strings, isMobile),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDownloadDossierBanner(
    BuildContext context,
    AppStrings strings,
    bool isMobile,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 18 : 28,
        vertical: isMobile ? 20 : 24,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.menu_book_rounded,
                        color: Color(0xFF7C3AED),
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strings.dossierBannerTitle,
                            style: AppTypography.headingSmall.copyWith(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            strings.dossierBannerDesc,
                            style: AppTypography.bodySmall.copyWith(
                              fontSize: 11.5,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildDossierButton(strings),
              ],
            )
          : Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.menu_book_rounded,
                    color: Color(0xFF7C3AED),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.dossierBannerTitle,
                        style: AppTypography.headingSmall.copyWith(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        strings.dossierBannerDesc,
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 12,
                          color: const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                _buildDossierButton(strings),
              ],
            ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildDossierButton(AppStrings strings) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _isDownloadingDossier ? null : _downloadPortfolioDossier,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF7C3AED), Color(0xFFA855F7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isDownloadingDossier)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              else
                const Icon(Icons.file_download_rounded, color: Colors.white, size: 18),
              const SizedBox(width: 8),
              Text(
                _isDownloadingDossier ? strings.generatingDossier : strings.dossierBannerBtn,
                style: AppTypography.button.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCarouselView(
    List<ProjectModel> filteredProjects,
    double viewportFraction,
  ) {
    return Column(
      children: [
        SizedBox(
          height: 430,
          child: PageView.builder(
            controller: PageController(
              viewportFraction: viewportFraction,
              initialPage: _currentCarouselIndex,
            ),
            physics: const BouncingScrollPhysics(),
            onPageChanged: (i) => setState(() => _currentCarouselIndex = i),
            itemCount: filteredProjects.length,
            itemBuilder: (context, index) {
              final project = filteredProjects[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ProjectCard(project: project),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
        // Dots navigation
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(filteredProjects.length, (index) {
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
    List<ProjectModel> filteredProjects,
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
          children: filteredProjects.asMap().entries.map((entry) {
            final index = entry.key;
            final project = entry.value;

            return SizedBox(
              width: itemWidth,
              child: ProjectCard(project: project)
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 90 * index),
                    duration: 450.ms,
                  )
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    end: const Offset(1.0, 1.0),
                    delay: Duration(milliseconds: 90 * index),
                    duration: 450.ms,
                  ),
            );
          }).toList(),
        );
      },
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

  Widget _buildCategoryPill(String label, ProjectCategory category) {
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
}
