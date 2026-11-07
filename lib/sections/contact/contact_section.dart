import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/url_helper.dart';
import '../../widgets/cards/glass_card.dart';
import '../../widgets/common/section_title.dart';
import 'contact_form.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final strings = AppStrings(LocaleController.instance.currentLanguage);

        return ContentConstrainedBox(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 32,
            vertical: isMobile ? 50 : 90,
          ),
          child: Column(
            children: [
              // Section Title
              SectionTitle(
                tag: strings.contactTag,
                title: strings.contactTitle,
                subtitle: strings.contactSubtitle,
              ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 56),

              // Main Split: Info & Socials on Left, Form on Right
              isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Column: Direct Info & Social Channels
                        Expanded(
                          flex: 5,
                          child: _buildContactInfo(context, strings),
                        ),
                        const SizedBox(width: 48),
                        // Right Column: Interactive Form
                        Expanded(
                          flex: 7,
                          child: const ContactForm(),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildContactInfo(context, strings),
                        const SizedBox(height: 40),
                        const ContactForm(),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactInfo(BuildContext context, AppStrings strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Highlight Glass Card
        GlassCard(
          borderRadius: 24,
          blur: 16,
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strings.directChannels,
                style: AppTypography.headingSmall.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                strings.directChannelsDesc,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),

              // Email Item
              _buildContactItem(
                icon: Icons.alternate_email_rounded,
                title: 'Email Address',
                value: AppConstants.email,
                color: const Color(0xFF0284C7),
                onTap: () => UrlHelper.sendEmail(
                  AppConstants.email,
                  subject: 'Collaboration with Nazarul Qudri',
                ),
              ),
              const SizedBox(height: 16),

              // Location Item
              _buildContactItem(
                icon: Icons.map_outlined,
                title: 'Location & Timezone',
                value: AppConstants.location,
                color: const Color(0xFF2563EB),
              ),
              const SizedBox(height: 16),

              // Status Item
              _buildContactItem(
                icon: Icons.check_circle_outline_rounded,
                title: 'Availability',
                value: 'Full-time & High-Impact Contracts',
                color: const Color(0xFF10B981),
              ),
            ],
          ),
        ),

        const SizedBox(height: 28),

        // Social Media Buttons Bar
        Text(
          'CONNECT ACROSS PLATFORMS',
          style: AppTypography.badge.copyWith(
            color: AppColors.textPrimary,
            letterSpacing: 1.1,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 14),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _SocialIconButton(
              icon: FontAwesomeIcons.github,
              label: 'GitHub',
              color: const Color(0xFF0F172A),
              onTap: () => UrlHelper.openUrl(AppConstants.githubUrl, context: context),
            ),
            _SocialIconButton(
              icon: FontAwesomeIcons.linkedinIn,
              label: 'LinkedIn',
              color: const Color(0xFF0077B5),
              onTap: () => UrlHelper.openUrl(AppConstants.linkedinUrl, context: context),
            ),
            _SocialIconButton(
              icon: Icons.email_rounded,
              label: 'Email',
              color: AppColors.primary,
              onTap: () => UrlHelper.sendEmail(AppConstants.email),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    VoidCallback? onTap,
  }) {
    Widget item = Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (onTap != null) {
      item = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: item,
        ),
      );
    }

    return item;
  }
}

class _SocialIconButton extends StatefulWidget {
  final dynamic icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _isHovered = false;

  Widget _buildIcon(Color iconColor) {
    if (widget.icon is FaIconData) {
      return FaIcon(
        widget.icon as FaIconData,
        size: 16,
        color: iconColor,
      );
    }
    return Icon(
      widget.icon as IconData,
      size: 16,
      color: iconColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = _isHovered ? Colors.white : widget.color;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? widget.color : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered ? widget.color : const Color(0xFFE2E8F0),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? widget.color.withValues(alpha: 0.28)
                    : Colors.black.withValues(alpha: 0.03),
                blurRadius: _isHovered ? 16 : 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(iconColor),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: AppTypography.button.copyWith(
                  color: _isHovered ? Colors.white : AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
