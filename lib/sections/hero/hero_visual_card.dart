import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../widgets/cards/glass_card.dart';
import '../../widgets/cards/tilt_card.dart';

class HeroVisualCard extends StatefulWidget {
  const HeroVisualCard({super.key});

  @override
  State<HeroVisualCard> createState() => _HeroVisualCardState();
}

class _HeroVisualCardState extends State<HeroVisualCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final strings = AppStrings(LocaleController.instance.currentLanguage);

        return AnimatedBuilder(
          animation: _floatAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _floatAnimation.value),
              child: child,
            );
          },
          child: TiltCard(
            maxTiltAngle: 12,
            perspective: 0.0015,
            borderRadius: 32,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Main Profile Glass Card
                  GlassCard(
                    borderRadius: 32,
                    blur: 24,
                    padding: const EdgeInsets.all(28),
                    backgroundColor: Colors.white.withValues(alpha: 0.88),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar / Branding Circle with Nazarul's Photo
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Soft pulsing ring
                            Container(
                              width: 165,
                              height: 165,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    AppColors.primaryLight.withValues(alpha: 0.45),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                            // Inner circle with high-resolution profile photo
                            Container(
                              width: 135,
                              height: 135,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF38BDF8),
                                    Color(0xFF0284C7),
                                    Color(0xFF1D4ED8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.35),
                                    blurRadius: 24,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: ClipOval(
                                child: Image.asset(
                                  'lib/images/fotoprofil/fotoNazarulQudri_profile.jpg',
                                  width: 135,
                                  height: 135,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    'lib/images/fotoprofil/fotoNazarulQudri.jpeg',
                                    width: 135,
                                    height: 135,
                                    fit: BoxFit.cover,
                                    alignment: const Alignment(0, -0.6),
                                    filterQuality: FilterQuality.high,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(
                                      Icons.person_rounded,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Floating online status indicator
                            Positioned(
                              bottom: 6,
                              right: 12,
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.onlineGreen,
                                  border: Border.all(color: Colors.white, width: 3.5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.onlineGreen.withValues(alpha: 0.5),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Name & Designation
                        Text(
                          AppConstants.fullName,
                          style: AppTypography.headingLarge.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                strings.heroRole,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),

                        // Quick Stats Row inside Card
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.iceBlue.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: const Color(0xFFBAE6FD).withValues(alpha: 0.6),
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: _buildMiniStat(
                                  title: AppConstants.yearsExperience,
                                  label: strings.expYearsLabel,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 28,
                                color: const Color(0xFFCBD5E1),
                              ),
                              Expanded(
                                child: _buildMiniStat(
                                  title: AppConstants.completedProjects,
                                  label: strings.projectsDoneLabel,
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 28,
                                color: const Color(0xFFCBD5E1),
                              ),
                              Expanded(
                                child: _buildMiniStat(
                                  title: '11',
                                  label: strings.certsLabel,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),

                        // Mini Code snippet preview chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle_outline_rounded,
                                size: 14,
                                color: AppColors.primary,
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  'Clean Architecture • Reactive BLoC',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.code.copyWith(
                                    fontSize: 11.5,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Floating Satellite Badge 1 (Top Left)
                  Positioned(
                    top: -16,
                    left: -20,
                    child: _buildSatelliteBadge(
                      icon: Icons.flutter_dash,
                      iconColor: const Color(0xFF0284C7),
                      title: strings.isId ? 'Spesialis Flutter' : 'Flutter Specialist',
                      subtitle: 'Web, Mobile, Desktop',
                    ),
                  ),

                  // Floating Satellite Badge 2 (Bottom Right)
                  Positioned(
                    bottom: -16,
                    right: -20,
                    child: _buildSatelliteBadge(
                      icon: Icons.workspace_premium_rounded,
                      iconColor: const Color(0xFF2563EB),
                      title: strings.isId ? '11 Sertifikasi Resmi' : '11 Credentials',
                      subtitle: strings.isId ? 'Kominfo DTS Terverifikasi' : 'Verified Talent',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMiniStat({required String title, required String label}) {
    return Column(
      children: [
        Text(
          title,
          style: AppTypography.headingSmall.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            fontSize: 17,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSatelliteBadge({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTypography.badge.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                subtitle,
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 10,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
