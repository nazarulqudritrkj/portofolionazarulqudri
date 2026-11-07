import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../core/utils/responsive.dart';
import '../../models/skill_model.dart';
import '../../widgets/common/section_title.dart';
import 'skill_card.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  SkillCategory? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final strings = AppStrings(LocaleController.instance.currentLanguage);
        final allSkills = SkillModel.sampleSkills;
        final filteredSkills = _selectedCategory == null
            ? allSkills
            : allSkills.where((s) => s.category == _selectedCategory).toList();

        int crossAxisCount = 4;
        if (isMobile) {
          crossAxisCount = 1;
        } else if (isTablet) {
          crossAxisCount = 2;
        }

        return ContentConstrainedBox(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 32,
            vertical: isMobile ? 50 : 90,
          ),
          child: Column(
            children: [
              // Section Title
              SectionTitle(
                tag: strings.skillsTag,
                title: strings.skillsTitle,
                subtitle: strings.skillsSubtitle,
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 36),

              // Category Pill Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildFilterTab(
                      label: strings.allCapabilities,
                      category: null,
                    ),
                    const SizedBox(width: 8),
                    ...SkillCategory.values.map((cat) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildFilterTab(
                          label: cat.label,
                          category: cat,
                          icon: cat.icon,
                        ),
                      );
                    }),
                  ],
                ),
              ).animate().fadeIn(delay: 200.ms, duration: 600.ms),

              const SizedBox(height: 48),

              // Skills Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final double spacing = isMobile ? 18 : 24;
                  final double totalSpacing = spacing * (crossAxisCount - 1);
                  final double itemWidth =
                      (constraints.maxWidth - totalSpacing) / crossAxisCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: filteredSkills.asMap().entries.map((entry) {
                      final index = entry.key;
                      final skill = entry.value;

                      return SizedBox(
                        width: itemWidth,
                        child: SkillCard(skill: skill)
                            .animate()
                            .fadeIn(
                              delay: Duration(milliseconds: 70 * index),
                              duration: 450.ms,
                            )
                            .scale(
                              begin: const Offset(0.96, 0.96),
                              end: const Offset(1.0, 1.0),
                              delay: Duration(milliseconds: 70 * index),
                              duration: 450.ms,
                            ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterTab({
    required String label,
    required SkillCategory? category,
    IconData? icon,
  }) {
    final isSelected = _selectedCategory == category;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _selectedCategory = category),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? AppColors.primary : const Color(0xFFE2E8F0),
              width: 1.2,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.28),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 15,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
              ],
              Text(
                label,
                style: AppTypography.button.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
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

