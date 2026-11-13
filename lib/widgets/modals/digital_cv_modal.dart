import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/localization/app_locale.dart';
import '../../core/utils/cv_pdf_generator.dart';
import '../../core/utils/portfolio_pdf_generator.dart';
import '../../core/utils/pdf_downloader_stub.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) '../../core/utils/pdf_downloader_web.dart';

class DigitalCvModal extends StatelessWidget {
  const DigitalCvModal({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'CV Preview',
      barrierColor: Colors.black.withValues(alpha: 0.65),
      transitionDuration: const Duration(milliseconds: 320),
      pageBuilder: (context, anim1, anim2) => const DigitalCvModal(),
      transitionBuilder: (context, anim1, anim2, child) {
        final curve = CurvedAnimation(parent: anim1, curve: Curves.easeOutExpo);
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(curve),
          child: FadeTransition(opacity: curve, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isNarrow = size.width < 700;

    return ListenableBuilder(
      listenable: LocaleController.instance,
      builder: (context, _) {
        final isEn = LocaleController.instance.isEnglish;
        final strings = AppStrings(LocaleController.instance.currentLanguage);

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isNarrow ? size.width - 24 : 920,
              maxHeight: size.height * 0.93,
            ),
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: isNarrow ? 12 : 24,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.28),
                      blurRadius: 60,
                      spreadRadius: -4,
                      offset: const Offset(0, 20),
                    ),
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      blurRadius: 40,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Column(
                    children: [
                      // ─── PREMIUM HEADER BANNER WITH LANGUAGE SWITCHER ─────
                      _CvHeaderBanner(
                        isEn: isEn,
                        onClose: () => Navigator.of(context).pop(),
                      ),

                      // ─── SCROLLABLE BODY ─────────────────────────────────────────
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              // Profile identity strip
                              _CvProfileStrip(isNarrow: isNarrow, isEn: isEn),

                              // Divider with gradient
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32),
                                child: Container(
                                  height: 1,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.transparent,
                                        AppColors.primary.withValues(alpha: 0.3),
                                        Colors.transparent,
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // CV Content Sections
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isNarrow ? 20 : 36,
                                  vertical: 28,
                                ),
                                child: isNarrow
                                    ? _CvSingleColumnContent(isEn: isEn)
                                    : _CvTwoColumnContent(isEn: isEn),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ─── STICKY DOWNLOAD FOOTER (BILINGUAL) ───────────────
                      _CvDownloadFooter(isEn: isEn, strings: strings),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HEADER BANNER WITH LANGUAGE TOGGLE
// ─────────────────────────────────────────────────────────────────────────────
class _CvHeaderBanner extends StatelessWidget {
  final bool isEn;
  final VoidCallback onClose;
  const _CvHeaderBanner({required this.isEn, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF0C4A6E), Color(0xFF0284C7)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Badge icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
            ),
            child: const Icon(Icons.badge_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEn ? 'Official Curriculum Vitae' : 'Curriculum Vitae Resmi',
                  style: AppTypography.headingSmall.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                Text(
                  'Nazarul Qudri, S.Tr.T. • TRKJ PNL • Lhokseumawe, Aceh',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: 11.5,
                  ),
                ),
              ],
            ),
          ),
          // Language Switcher Pill inside Modal
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLangChip('ID', !isEn, () => LocaleController.instance.setLanguage(AppLanguage.id)),
                _buildLangChip('EN', isEn, () => LocaleController.instance.setLanguage(AppLanguage.en)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Status chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF10B981),
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  isEn ? 'Active 2026' : 'Aktif 2026',
                  style: AppTypography.code.copyWith(
                    color: const Color(0xFF6EE7B7),
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Close button
          InkWell(
            onTap: onClose,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.close_rounded, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLangChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: AppTypography.code.copyWith(
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            color: isSelected ? const Color(0xFF0F172A) : Colors.white70,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PROFILE STRIP
// ─────────────────────────────────────────────────────────────────────────────
class _CvProfileStrip extends StatelessWidget {
  final bool isNarrow;
  final bool isEn;
  const _CvProfileStrip({required this.isNarrow, required this.isEn});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF8FAFC),
      padding: EdgeInsets.symmetric(
        horizontal: isNarrow ? 20 : 36,
        vertical: 24,
      ),
      child: isNarrow
          ? _buildNarrowProfile()
          : _buildWideProfile(),
    );
  }

  Widget _buildWideProfile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(),
        const SizedBox(width: 24),
        Expanded(child: _buildNameBlock()),
        const SizedBox(width: 24),
        _buildContactBlock(),
      ],
    );
  }

  Widget _buildNarrowProfile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(),
        const SizedBox(height: 16),
        _buildNameBlock(centered: true),
        const SizedBox(height: 14),
        _buildContactBlock(centered: true),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF38BDF8), Color(0xFF0284C7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: ClipOval(
          child: Image.asset(
            'lib/images/fotoprofil/fotoNazarulQudri_profile.jpg',
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }

  Widget _buildNameBlock({bool centered = false}) {
    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          AppConstants.fullName,
          textAlign: centered ? TextAlign.center : TextAlign.start,
          style: AppTypography.headingLarge.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF0F172A),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
            ),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFBFDBFE)),
          ),
          child: Text(
            isEn
                ? 'Bachelor of Applied Engineering (S.Tr.T.) • D4 TRKJ • Politeknik Negeri Lhokseumawe'
                : 'Sarjana Terapan Teknik (S.Tr.T.) • D4 TRKJ • Politeknik Negeri Lhokseumawe',
            textAlign: centered ? TextAlign.center : TextAlign.start,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
              fontSize: 11.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: centered ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            _buildBadgePill(Icons.location_on_rounded, 'Lhokseumawe, Aceh', const Color(0xFF7C3AED)),
            const SizedBox(width: 8),
            _buildBadgePill(
              Icons.check_circle_rounded,
              isEn ? 'Available for Opportunities' : 'Tersedia untuk Kolaborasi',
              const Color(0xFF10B981),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContactBlock({bool centered = false}) {
    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.end,
      children: [
        _buildContactRow(Icons.email_rounded, AppConstants.email),
        const SizedBox(height: 6),
        _buildContactRow(Icons.code_rounded, 'github.com/nazarulqudritrkj'),
        const SizedBox(height: 6),
        _buildContactRow(Icons.link_rounded, 'linkedin.com/in/nazarul-qudri'),
      ],
    );
  }

  Widget _buildBadgePill(IconData icon, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: color),
          const SizedBox(width: 4),
          Text(
            text,
            style: AppTypography.code.copyWith(
              fontSize: 10.5,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppTypography.code.copyWith(
            fontSize: 11,
            color: const Color(0xFF475569),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TWO-COLUMN CONTENT (Desktop)
// ─────────────────────────────────────────────────────────────────────────────
class _CvTwoColumnContent extends StatelessWidget {
  final bool isEn;
  const _CvTwoColumnContent({required this.isEn});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // LEFT COLUMN
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CvSection(
                title: isEn ? 'PROFILE SUMMARY' : 'RINGKASAN PROFIL',
                icon: Icons.person_outline_rounded,
                accentColor: AppColors.primary,
                child: _SummaryContent(isEn: isEn),
              ),
              const SizedBox(height: 20),
              _CvSection(
                title: isEn ? 'FORMAL HIGHER EDUCATION' : 'PENDIDIKAN FORMAL',
                icon: Icons.school_outlined,
                accentColor: const Color(0xFF7C3AED),
                child: _EducationContent(isEn: isEn),
              ),
              const SizedBox(height: 20),
              _CvSection(
                title: isEn ? 'FEATURED ENGINEERING HIGHLIGHTS' : '4 PROYEK REKAYASA UNGGULAN',
                icon: Icons.terminal_rounded,
                accentColor: const Color(0xFF0EA5E9),
                child: _ProjectsContent(isEn: isEn),
              ),
            ],
          ),
        ),
        const SizedBox(width: 24),
        // RIGHT COLUMN
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CvSection(
                title: isEn ? 'TECHNICAL COMPETENCIES' : 'KEAHLIAN UTAMA',
                icon: Icons.auto_awesome_rounded,
                accentColor: const Color(0xFF10B981),
                child: _SkillsContent(isEn: isEn),
              ),
              const SizedBox(height: 20),
              _CvSection(
                title: isEn ? 'NATIONAL COMPETITIVE HONORS' : 'PRESTASI NASIONAL',
                icon: Icons.emoji_events_outlined,
                accentColor: const Color(0xFFD97706),
                child: _AchievementsContent(isEn: isEn),
              ),
              const SizedBox(height: 20),
              _CvSection(
                title: isEn ? 'KOMINFO DTS CERTIFICATIONS' : 'SERTIFIKASI KOMINFO DTS',
                icon: Icons.workspace_premium_outlined,
                accentColor: AppColors.primary,
                child: _CertsContent(isEn: isEn),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SINGLE-COLUMN CONTENT (Mobile)
// ─────────────────────────────────────────────────────────────────────────────
class _CvSingleColumnContent extends StatelessWidget {
  final bool isEn;
  const _CvSingleColumnContent({required this.isEn});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CvSection(
          title: isEn ? 'PROFILE SUMMARY' : 'RINGKASAN PROFIL',
          icon: Icons.person_outline_rounded,
          accentColor: AppColors.primary,
          child: _SummaryContent(isEn: isEn),
        ),
        const SizedBox(height: 20),
        _CvSection(
          title: isEn ? 'FORMAL HIGHER EDUCATION' : 'PENDIDIKAN FORMAL',
          icon: Icons.school_outlined,
          accentColor: const Color(0xFF7C3AED),
          child: _EducationContent(isEn: isEn),
        ),
        const SizedBox(height: 20),
        _CvSection(
          title: isEn ? 'TECHNICAL COMPETENCIES' : 'KEAHLIAN UTAMA',
          icon: Icons.auto_awesome_rounded,
          accentColor: const Color(0xFF10B981),
          child: _SkillsContent(isEn: isEn),
        ),
        const SizedBox(height: 20),
        _CvSection(
          title: isEn ? 'FEATURED ENGINEERING HIGHLIGHTS' : '4 PROYEK UNGGULAN',
          icon: Icons.terminal_rounded,
          accentColor: const Color(0xFF0EA5E9),
          child: _ProjectsContent(isEn: isEn),
        ),
        const SizedBox(height: 20),
        _CvSection(
          title: isEn ? 'NATIONAL COMPETITIVE HONORS' : 'PRESTASI NASIONAL',
          icon: Icons.emoji_events_outlined,
          accentColor: const Color(0xFFD97706),
          child: _AchievementsContent(isEn: isEn),
        ),
        const SizedBox(height: 20),
        _CvSection(
          title: isEn ? 'KOMINFO DTS CERTIFICATIONS' : 'SERTIFIKASI KOMINFO DTS',
          icon: Icons.workspace_premium_outlined,
          accentColor: AppColors.primary,
          child: _CertsContent(isEn: isEn),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION WRAPPER
// ─────────────────────────────────────────────────────────────────────────────
class _CvSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color accentColor;
  final Widget child;

  const _CvSection({
    required this.title,
    required this.icon,
    required this.accentColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 3,
              height: 18,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Icon(icon, size: 15, color: accentColor),
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTypography.badge.copyWith(
                color: const Color(0xFF0F172A),
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Container(
          height: 1,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [accentColor.withValues(alpha: 0.5), Colors.transparent],
            ),
          ),
        ),
        child,
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION CONTENTS (BILINGUAL)
// ─────────────────────────────────────────────────────────────────────────────
class _SummaryContent extends StatelessWidget {
  final bool isEn;
  const _SummaryContent({required this.isEn});

  @override
  Widget build(BuildContext context) {
    return Text(
      isEn
          ? 'Software Engineer and Bachelor of Applied Engineering (S.Tr.T.) graduate in Computer Network Engineering Technology (D4 TRKJ), Department of Information and Computer Technology (TIK), Politeknik Negeri Lhokseumawe (Cum Laude). Specialized in cross-platform Flutter mobile applications (Reactive BLoC), cyber-physical systems (IoT CPS) with complete 7-Layer OSI network model & MQTT HiveMQ Cloud, applied artificial intelligence (Rule-Based Decision Systems & Google AI Studio), and integrated enterprise academic web portals.'
          : 'Software Engineer dan lulusan Sarjana Terapan Teknik (S.Tr.T.) Program Studi D4 Teknologi Rekayasa Komputer Jaringan (TRKJ), Jurusan Teknologi Informasi dan Komputer (TIK) Politeknik Negeri Lhokseumawe. Spesialis dalam rekayasa aplikasi mobile Flutter cross-platform (Dart & BLoC), sistem siber-fisik IoT 7 Lapisan OSI Model & MQTT/TLS, kecerdasan buatan Rule-Based Decision Systems & AI Studio, serta pengembangan sistem informasi web institusi akademik.',
      style: AppTypography.bodySmall.copyWith(
        fontSize: 13,
        height: 1.65,
        color: const Color(0xFF475569),
      ),
    );
  }
}

class _EducationContent extends StatelessWidget {
  final bool isEn;
  const _EducationContent({required this.isEn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F3FF),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFDDD6FE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  isEn
                      ? 'D4 Computer Network Engineering Technology (TRKJ)'
                      : 'D4 Teknologi Rekayasa Komputer Jaringan (TRKJ)',
                  style: AppTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: const Color(0xFF1E1B4B),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '2022 – 2026',
                  style: AppTypography.code.copyWith(
                    fontSize: 11,
                    color: const Color(0xFF7C3AED),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            isEn
                ? 'Politeknik Negeri Lhokseumawe (PNL) • Department of ICT'
                : 'Politeknik Negeri Lhokseumawe (PNL) • Jurusan TIK',
            style: AppTypography.bodySmall.copyWith(
              fontSize: 12,
              color: const Color(0xFF7C3AED),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          _infoRow(isEn ? 'Degree' : 'Gelar', 'Sarjana Terapan Teknik (S.Tr.T.)'),
          _infoRow(isEn ? 'Honors' : 'Predikat', 'Cum Laude (GPA 3.75 / 4.00)'),
          _infoRow(isEn ? 'Defense Date' : 'Lulus Sidang', '29 Juli 2026'),
          _infoRow(isEn ? 'Advisor I' : 'Pembimbing I', 'Husaini, S.Si., M.IT.'),
          _infoRow(isEn ? 'Advisor II' : 'Pembimbing II', 'Atthariq, S.S.T., M.T.'),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.2)),
            ),
            child: Text(
              isEn
                  ? '📌 Thesis: "Design and Construction of IoT Prototype Smart Home with Rule-Based Decision System as Artificial Intelligence" (STARZAR Application - Complete 7-Layer OSI Model & MQTT HiveMQ Cloud)'
                  : '📌 Skripsi: "Rancang Bangun IoT pada Prototype Smart Home dengan Penerapan Rule-Based Decision System sebagai Artificial Intelligence" (Aplikasi STARZAR - 7 OSI Layer & MQTT HiveMQ)',
              style: AppTypography.bodySmall.copyWith(
                fontSize: 11.5,
                height: 1.5,
                color: const Color(0xFF4C1D95),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              '$label:',
              style: AppTypography.bodySmall.copyWith(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.bodySmall.copyWith(
                fontSize: 11.5,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillsContent extends StatelessWidget {
  final bool isEn;
  const _SkillsContent({required this.isEn});

  @override
  Widget build(BuildContext context) {
    final skills = [
      _SkillData(
        'Mobile Dev',
        isEn ? 'Flutter • Dart • BLoC • 60 FPS UI' : 'Flutter • Dart • BLoC • UI 60 FPS',
        const Color(0xFF0284C7),
        Icons.phone_android_rounded,
        0.95,
      ),
      _SkillData(
        'IoT & Networking',
        isEn ? '7 OSI Layer • MQTT/TLS • ESP32 • VLAN' : '7 Lapisan OSI • MQTT/TLS • ESP32 • VLAN',
        const Color(0xFF10B981),
        Icons.lan_rounded,
        0.92,
      ),
      _SkillData(
        'AI & Decision Sys.',
        isEn ? 'Rule-Based • Forward Chain • AI Studio' : 'Rule-Based AI • Forward Chaining • AI Studio',
        const Color(0xFF7C3AED),
        Icons.psychology_rounded,
        0.90,
      ),
      _SkillData(
        'Tools & Admin',
        isEn ? 'MS Office • Figma • Git • VS Code' : 'MS Office • Figma • Git • VS Code',
        const Color(0xFFD97706),
        Icons.build_rounded,
        0.88,
      ),
    ];
    return Column(
      children: skills.map((s) => _SkillBar(data: s)).toList(),
    );
  }
}

class _SkillData {
  final String label, desc;
  final Color color;
  final IconData icon;
  final double level;
  const _SkillData(this.label, this.desc, this.color, this.icon, this.level);
}

class _SkillBar extends StatelessWidget {
  final _SkillData data;
  const _SkillBar({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: data.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Icon(data.icon, size: 12, color: data.color),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.label,
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 11.5,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    Text(
                      data.desc,
                      style: AppTypography.code.copyWith(
                        fontSize: 10,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${(data.level * 100).toInt()}%',
                style: AppTypography.code.copyWith(
                  fontSize: 11,
                  color: data.color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: data.level,
              minHeight: 5,
              backgroundColor: data.color.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(data.color),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectsContent extends StatelessWidget {
  final bool isEn;
  const _ProjectsContent({required this.isEn});

  @override
  Widget build(BuildContext context) {
    final projects = [
      _ProjectData(
        '1. STARZAR – Smart Exclusive Home IoT & AI',
        isEn
            ? 'Bachelor Thesis TRKJ PNL | Flutter + ESP32 + MQTT HiveMQ'
            : 'Skripsi S.Tr.T. TRKJ PNL | Flutter + ESP32 + MQTT HiveMQ',
        isEn
            ? 'Complete 7-Layer OSI Model, 100% Rule-Based AI accuracy, 180 ms latency, 0% Packet Loss.'
            : '7 OSI Layer penuh, Rule-Based AI 100% akurasi, latensi 180 ms, 0% Packet Loss, QoS ITU-T Y.1010.',
        const Color(0xFF0284C7),
        Icons.home_work_rounded,
      ),
      _ProjectData(
        isEn
            ? '2. TIK PNL Public Lecture & Event Registration System'
            : '2. Sistem Informasi Kuliah Umum TIK PNL',
        isEn
            ? 'Academic Seminar Registration Web Platform (2025-2026)'
            : 'Web Portal Pendaftaran Seminar Akademik (2025-2026)',
        isEn
            ? 'Participant registration, encrypted digital QR attendance, quota checks & real-time analytics.'
            : 'Registrasi peserta, absensi QR Code digital, kuota otomatis & rekapitulasi data seminar.',
        const Color(0xFF7C3AED),
        Icons.school_rounded,
      ),
      _ProjectData(
        isEn
            ? '3. PNL Faculty Certificate Repository System'
            : '3. Sistem Informasi Sertifikat Dosen PNL',
        isEn
            ? 'Centralized Faculty Credential Vault (2025-2026)'
            : 'Repositori Kredensial Dosen Terpusat (2025-2026)',
        isEn
            ? 'Certification archiving, BKD institutional reporting, and campus QR code verification.'
            : 'Arsip sertifikasi dosen, audit BKD, verifikasi dokumen berbasis QR Code kampus.',
        const Color(0xFF10B981),
        Icons.workspace_premium_rounded,
      ),
      _ProjectData(
        isEn
            ? '4. TIK PNL Student Certificate & SKPI Validation'
            : '4. Sistem Informasi Sertifikat Mahasiswa/i TIK',
        isEn
            ? 'Digital E-Certificate & SKPI Portal (2025-2026)'
            : 'Platform E-Certificate Digital PNL (2025-2026)',
        isEn
            ? 'Automated e-certificate generation, anti-fraud QR verification, and student SKPI linkage.'
            : 'Penerbitan e-sertifikat otomatis, validasi anti-pemalsuan, sinkronisasi SKPI mahasiswa.',
        const Color(0xFFD97706),
        Icons.card_membership_rounded,
      ),
    ];
    return Column(
      children: projects.map((p) => _ProjectCard(data: p)).toList(),
    );
  }
}

class _ProjectData {
  final String title, subtitle, desc;
  final Color color;
  final IconData icon;
  const _ProjectData(this.title, this.subtitle, this.desc, this.color, this.icon);
}

class _ProjectCard extends StatelessWidget {
  final _ProjectData data;
  const _ProjectCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: data.color.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: data.color.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: data.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(data.icon, size: 14, color: data.color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data.subtitle,
                  style: AppTypography.code.copyWith(
                    fontSize: 10.5,
                    color: data.color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.desc,
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 11.5,
                    height: 1.4,
                    color: const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementsContent extends StatelessWidget {
  final bool isEn;
  const _AchievementsContent({required this.isEn});

  @override
  Widget build(BuildContext context) {
    final items = isEn
        ? [
            'Software Innovation Finalist – KMIPN VI 2025 (National Polytechnic Informatics Competition)',
            'National Medal Winner – NSO 5 (National Science Olympiad V, English Category)',
            'National Winner – OSPN (National Youth Science Olympiad, Accounting & Logic)',
            'National Honor – OSH 2025 (Hardiknas Science Olympiad, Indonesian Language)',
          ]
        : [
            'Finalis Inovasi Perangkat Lunak – KMIPN VI 2025 (Kompetisi Mahasiswa Informatika Politeknik Nasional)',
            'Medali Nasional – NSO 5 (National Science Olympiad V, Bidang Bahasa Inggris)',
            'Juara Nasional – OSPN (Olimpiade Sains Pemuda Nusantara, Bidang Akuntansi & Logika)',
            'Penghargaan Nasional – OSH 2025 (Olimpiade Sains Hardiknas, Bidang Bahasa Indonesia)',
          ];
    return Column(
      children: items.asMap().entries.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFD97706).withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '${e.key + 1}',
                  style: AppTypography.code.copyWith(
                    fontSize: 10,
                    color: const Color(0xFFD97706),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  e.value,
                  style: AppTypography.bodySmall.copyWith(
                    fontSize: 12,
                    height: 1.4,
                    color: const Color(0xFF334155),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _CertsContent extends StatelessWidget {
  final bool isEn;
  const _CertsContent({required this.isEn});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEFF6FF), Color(0xFFF0F9FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.verified_rounded, color: Color(0xFF0284C7), size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isEn ? '11 Verified Professional Credentials' : '11 Sertifikasi Resmi Terverifikasi',
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    color: const Color(0xFF0C4A6E),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            isEn
                ? 'Ministry of Communication and Informatics RI (Kominfo) – Digital Talent Scholarship (DTS) 2024–2025. Covering: AI & Machine Learning, Cloud Architecture, Cybersecurity, Digital Product Management, and Media Strategy.'
                : 'Kementerian Komunikasi dan Informatika RI (Kominfo) – Digital Talent Scholarship (DTS) 2024–2025. Meliputi: AI & Machine Learning, Cloud Architecture, Cybersecurity, Digital Product Management, dan Media Strategist.',
            style: AppTypography.bodySmall.copyWith(
              fontSize: 11.5,
              height: 1.5,
              color: const Color(0xFF1E40AF),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STICKY DOWNLOAD FOOTER (BILINGUAL)
// ─────────────────────────────────────────────────────────────────────────────
class _CvDownloadFooter extends StatelessWidget {
  final bool isEn;
  final AppStrings strings;

  const _CvDownloadFooter({required this.isEn, required this.strings});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE2E8F0), width: 1.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0F0F172A),
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 640;
          if (isCompact) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      strings.downloadOfficialDocs,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      strings.downloadDocsDesc,
                      textAlign: TextAlign.center,
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 11,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _DownloadActionButton(
                      label: strings.downloadCvBtn,
                      loadingLabel: strings.generatingCv,
                      icon: Icons.file_download_rounded,
                      gradientColors: const [Color(0xFF0284C7), Color(0xFF38BDF8)],
                      hoverColors: const [Color(0xFF0C4A6E), Color(0xFF0284C7)],
                      onGenerate: () => CvPdfGenerator.generate(isEnglish: isEn),
                      filename: isEn ? 'CV_Nazarul_Qudri_STRT_EN.pdf' : 'CV_Nazarul_Qudri_STRT.pdf',
                    ),
                    _DownloadActionButton(
                      label: strings.downloadPortfolioBtn,
                      loadingLabel: strings.generatingDossier,
                      icon: Icons.menu_book_rounded,
                      gradientColors: const [Color(0xFF7C3AED), Color(0xFFA855F7)],
                      hoverColors: const [Color(0xFF581C87), Color(0xFF7C3AED)],
                      onGenerate: () => PortfolioPdfGenerator.generate(isEnglish: isEn),
                      filename: isEn ? 'Portfolio_Dossier_Nazarul_Qudri_STRT_EN.pdf' : 'Portofolio_Lengkap_Nazarul_Qudri_STRT.pdf',
                    ),
                  ],
                ),
              ],
            );
          }
          return Row(
            children: [
              // Info text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      strings.downloadOfficialDocs,
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      strings.downloadDocsDesc,
                      style: AppTypography.bodySmall.copyWith(
                        fontSize: 11.5,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              _DownloadActionButton(
                label: strings.downloadCvBtn,
                loadingLabel: strings.generatingCv,
                icon: Icons.file_download_rounded,
                gradientColors: const [Color(0xFF0284C7), Color(0xFF38BDF8)],
                hoverColors: const [Color(0xFF0C4A6E), Color(0xFF0284C7)],
                onGenerate: () => CvPdfGenerator.generate(isEnglish: isEn),
                filename: isEn ? 'CV_Nazarul_Qudri_STRT_EN.pdf' : 'CV_Nazarul_Qudri_STRT.pdf',
              ),
              const SizedBox(width: 10),
              _DownloadActionButton(
                label: strings.downloadPortfolioBtn,
                loadingLabel: strings.generatingDossier,
                icon: Icons.menu_book_rounded,
                gradientColors: const [Color(0xFF7C3AED), Color(0xFFA855F7)],
                hoverColors: const [Color(0xFF581C87), Color(0xFF7C3AED)],
                onGenerate: () => PortfolioPdfGenerator.generate(isEnglish: isEn),
                filename: isEn ? 'Portfolio_Dossier_Nazarul_Qudri_STRT_EN.pdf' : 'Portofolio_Lengkap_Nazarul_Qudri_STRT.pdf',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _DownloadActionButton extends StatefulWidget {
  final String label;
  final String loadingLabel;
  final IconData icon;
  final List<Color> gradientColors;
  final List<Color> hoverColors;
  final Future<Uint8List> Function() onGenerate;
  final String filename;

  const _DownloadActionButton({
    required this.label,
    required this.loadingLabel,
    required this.icon,
    required this.gradientColors,
    required this.hoverColors,
    required this.onGenerate,
    required this.filename,
  });

  @override
  State<_DownloadActionButton> createState() => _DownloadActionButtonState();
}

class _DownloadActionButtonState extends State<_DownloadActionButton> {
  bool _isHovered = false;
  bool _isLoading = false;

  Future<void> _handleDownload() async {
    setState(() => _isLoading = true);
    try {
      final pdfBytes = await widget.onGenerate();
      await downloadPdfBytes(pdfBytes, widget.filename);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal generate PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: _isLoading ? null : _handleDownload,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovered ? widget.hoverColors : widget.gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: widget.gradientColors.first.withValues(alpha: _isHovered ? 0.45 : 0.28),
                blurRadius: _isHovered ? 18 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_isLoading)
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              else
                Icon(widget.icon, color: Colors.white, size: 17),
              const SizedBox(width: 7),
              Text(
                _isLoading ? widget.loadingLabel : widget.label,
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
}
