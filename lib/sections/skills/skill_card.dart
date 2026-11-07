import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../models/skill_model.dart';
import '../../widgets/cards/glass_card.dart';

class SkillCard extends StatefulWidget {
  final SkillModel skill;

  const SkillCard({super.key, required this.skill});

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = widget.skill;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -6 : 0, 0),
        child: GlassCard(
          borderRadius: 20,
          blur: 14,
          padding: const EdgeInsets.all(20),
          backgroundColor: _isHovered
              ? Colors.white.withValues(alpha: 0.94)
              : Colors.white.withValues(alpha: 0.82),
          borderColor: _isHovered
              ? s.accentColor.withValues(alpha: 0.7)
              : const Color(0xFFE2E8F0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Icon + Level Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedScale(
                    scale: _isHovered ? 1.12 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? s.accentColor.withValues(alpha: 0.18)
                            : s.accentColor.withValues(alpha: 0.09),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: s.accentColor.withValues(
                            alpha: _isHovered ? 0.4 : 0.15,
                          ),
                          width: 1.0,
                        ),
                        boxShadow: _isHovered
                            ? [
                                BoxShadow(
                                  color: s.accentColor.withValues(alpha: 0.25),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                )
                              ]
                            : [],
                      ),
                      child: Icon(
                        s.icon,
                        color: s.accentColor,
                        size: 24,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.iceBlue,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFBAE6FD),
                        width: 1.0,
                      ),
                    ),
                    child: Text(
                      s.experienceYears,
                      style: AppTypography.badge.copyWith(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Skill Name
              Text(
                s.name,
                style: AppTypography.headingSmall.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: _isHovered ? s.accentColor : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),

              // Description
              Text(
                s.description,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),

              // Proficiency Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      s.level,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.badge.copyWith(
                        color: AppColors.textMuted,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${(s.proficiency * 100).toInt()}%',
                    style: AppTypography.badge.copyWith(
                      color: s.accentColor,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Progress Bar Track
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Stack(
                  children: [
                    Container(
                      height: 6,
                      width: double.infinity,
                      color: const Color(0xFFE2E8F0),
                    ),
                    AnimatedFractionallySizedBox(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      widthFactor: s.proficiency,
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [s.accentColor, AppColors.primaryLight],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: s.accentColor.withValues(alpha: 0.5),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

