import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../models/project_model.dart';
import '../../widgets/badges/tech_badge.dart';
import '../../widgets/cards/glass_card.dart';
import 'project_detail_modal.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.project;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => ProjectDetailModal.show(context, p),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          transform: Matrix4.translationValues(0, _isHovered ? -8 : 0, 0),
          child: GlassCard(
            borderRadius: 24,
            blur: 16,
            padding: EdgeInsets.zero,
            backgroundColor: _isHovered
                ? Colors.white.withValues(alpha: 0.95)
                : Colors.white.withValues(alpha: 0.85),
            borderColor: _isHovered
                ? p.primaryColor.withValues(alpha: 0.6)
                : const Color(0xFFE2E8F0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Graphic / Thumbnail Banner with smooth zoom
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  child: SizedBox(
                    height: 180,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        // Zooming Background Container
                        AnimatedScale(
                          scale: _isHovered ? 1.08 : 1.0,
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeOutCubic,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  p.primaryColor.withValues(alpha: 0.15),
                                  p.accentColor.withValues(alpha: 0.25),
                                  Colors.white,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: CustomPaint(
                              painter: _CardAbstractPainter(
                                color: p.primaryColor.withValues(alpha: 0.12),
                              ),
                              child: Container(),
                            ),
                          ),
                        ),

                        // Center Icon Emblem
                        Center(
                          child: AnimatedScale(
                            scale: _isHovered ? 1.15 : 1.0,
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeOutCubic,
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [p.primaryColor, p.accentColor],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: p.primaryColor.withValues(
                                      alpha: _isHovered ? 0.45 : 0.25,
                                    ),
                                    blurRadius: _isHovered ? 24 : 14,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Icon(
                                p.icon,
                                color: Colors.white,
                                size: 34,
                              ),
                            ),
                          ),
                        ),

                        // Metric Pill (Top Right)
                        Positioned(
                          top: 14,
                          right: 14,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE2E8F0),
                                width: 1.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: p.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  p.metric,
                                  style: AppTypography.badge.copyWith(
                                    fontSize: 11,
                                    color: AppColors.textPrimary,
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

                // Card Body
                Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        p.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.headingSmall.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: _isHovered
                              ? p.primaryColor
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Subtitle / Brief
                      Text(
                        p.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Tech Tags
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: p.tags.take(3).map((tag) {
                          return TechBadge(
                            label: tag,
                            color: p.primaryColor,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),

                      // Card Footer Action
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    AppStrings(LocaleController.instance.currentLanguage).viewDetails,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.button.copyWith(
                                      color: p.primaryColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                AnimatedSlide(
                                  offset: Offset(_isHovered ? 0.2 : 0, 0),
                                  duration: const Duration(milliseconds: 200),
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 15,
                                    color: p.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: AppColors.iceBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.north_east_rounded,
                              size: 14,
                              color: AppColors.primary,
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

class _CardAbstractPainter extends CustomPainter {
  final Color color;
  _CardAbstractPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.4,
      size.height * 0.3,
      size.width,
      size.height * 0.5,
    );

    final path2 = Path();
    path2.moveTo(0, size.height * 0.3);
    path2.quadraticBezierTo(
      size.width * 0.6,
      size.height * 0.9,
      size.width,
      size.height * 0.2,
    );

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

