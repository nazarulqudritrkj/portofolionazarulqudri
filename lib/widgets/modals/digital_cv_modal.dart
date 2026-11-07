import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_typography.dart';
import '../../core/utils/url_helper.dart';
import '../common/clean_button.dart';

class DigitalCvModal extends StatelessWidget {
  const DigitalCvModal({super.key});

  static Future<void> show(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Digital CV Modal',
      barrierColor: Colors.black.withValues(alpha: 0.55),
      transitionDuration: const Duration(milliseconds: 280),
      pageBuilder: (context, anim1, anim2) => const DigitalCvModal(),
      transitionBuilder: (context, anim1, anim2, child) {
        final curve = CurvedAnimation(parent: anim1, curve: Curves.easeOutCubic);
        return ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(curve),
          child: FadeTransition(opacity: curve, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 820, maxHeight: 860),
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.98),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.2),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Column(
                  children: [
                    // Modal Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                      decoration: const BoxDecoration(
                        color: AppColors.iceBlue,
                        border: Border(
                          bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.badge_rounded,
                                  color: AppColors.primary,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Curriculum Vitae (CV) Resmi Digital',
                                style: AppTypography.headingSmall.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close_rounded, size: 22),
                          ),
                        ],
                      ),
                    ),

                    // Scrollable CV Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Profile
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: AppColors.primary, width: 2.5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.primary.withValues(alpha: 0.2),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                    child: Image.asset(
                                      'lib/images/fotoprofil/fotoNazarulQudri_profile.jpg',
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppConstants.fullName,
                                        style: AppTypography.headingLarge.copyWith(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w800,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Sarjana Terapan Teknik (S.Tr.T.) • Teknologi Rekayasa Komputer Jaringan (TRKJ)',
                                        style: AppTypography.bodyMedium.copyWith(
                                          color: AppColors.primaryDark,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Wrap(
                                        spacing: 12,
                                        runSpacing: 6,
                                        children: [
                                          _buildContactChip(Icons.school_rounded, 'Politeknik Negeri Lhokseumawe'),
                                          _buildContactChip(Icons.location_on_rounded, 'Lhokseumawe, Aceh, Indonesia'),
                                          _buildContactChip(Icons.email_rounded, 'nazarulqudri@gmail.com'),
                                          _buildContactChip(Icons.code_rounded, 'github.com/nazarulqudritrkj'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),
                            const Divider(color: Color(0xFFE2E8F0)),
                            const SizedBox(height: 16),

                            // 1. Executive Summary
                            _buildSectionHeader('RINGKASAN PROFIL & PENGALAMAN', Icons.person_rounded),
                            const SizedBox(height: 8),
                            Text(
                              'Software Engineer dan lulusan Sarjana Terapan Teknik (S.Tr.T.) Program Studi D4 Teknologi Rekayasa Komputer Jaringan (TRKJ), Jurusan Teknologi Informasi dan Komputer (TIK) Politeknik Negeri Lhokseumawe. Memiliki spesialisasi mendalam dalam arsitektur mobile Flutter cross-platform (Clean Architecture & BLoC), rekayasa sistem siber-fisik (IoT CPS 7 Lapisan OSI Model & protokol MQTT/TLS), kecerdasan buatan (Rule-Based Decision Systems & Google AI Studio), serta pengembangan sistem informasi akademik berbasis web.',
                              style: AppTypography.bodyMedium.copyWith(
                                height: 1.6,
                                color: AppColors.textSecondary,
                                fontSize: 13.5,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // 2. Education
                            _buildSectionHeader('LATAR BELAKANG PENDIDIKAN FORMAL', Icons.school_rounded),
                            const SizedBox(height: 10),
                            _buildCvTimelineItem(
                              period: '2022 - 2026',
                              title: 'Sarjana Terapan Teknik (S.Tr.T.) • D4 Teknologi Rekayasa Komputer Jaringan (TRKJ)',
                              institution: 'Politeknik Negeri Lhokseumawe (PNL)',
                              details: [
                                'Jurusan: Teknologi Informasi dan Komputer (TIK)',
                                'Predikat Kelulusan: Sangat Memuaskan / Pujian (Lulus Sidang 29 Juli 2026)',
                                'Skripsi: "Rancang Bangun IoT pada Prototype Smart Home dengan Penerapan Rule-Based Decision System sebagai Artificial Intelligence" (Aplikasi STARZAR)',
                                'Pembimbing Skripsi: Husaini, S.Si., M.I.T. & Atthariq, S.S.T., M.T.',
                              ],
                            ),

                            const SizedBox(height: 24),

                            // 3. Core Competencies & Skills
                            _buildSectionHeader('KEAHLIAN UTAMA & SPESIALISASI TEKNIS', Icons.auto_awesome_rounded),
                            const SizedBox(height: 10),
                            _buildSkillGroup('Mobile Development', 'Flutter Cross-Platform, Dart Programming, Clean Architecture, Reactive BLoC, Riverpod, Custom Painters, 60 FPS Fluid UI.'),
                            _buildSkillGroup('Artificial Intelligence (AI)', 'Rule-Based Decision Systems (Forward Chaining Inference Engine), Generative AI Integration (Google AI Studio & Gemini API), Smart Embedded Logic.'),
                            _buildSkillGroup('IoT & Networking (CPS)', 'Cyber-Physical Systems (CPS) 7 OSI Layer, Telemetri Real-time MQTT/TLS (HiveMQ Cloud, QoS ITU-T Y.1010), ESP32, ESP8266, VLAN Routing.'),
                            _buildSkillGroup('Technical & Admin Tools', 'Microsoft Office (Word, Excel, PowerPoint) untuk dokumentasi teknis & laporan akademis profesional, Figma, VS Code, Git & GitHub CI/CD.'),

                            const SizedBox(height: 24),

                            // 4. Featured Engineering Projects
                            _buildSectionHeader('4 PROYEK REKAYASA UNGGULAN', Icons.terminal_rounded),
                            const SizedBox(height: 10),
                            _buildProjectItem('1. STARZAR - Smart Exclusive Home IoT & AI (Skripsi S.Tr.T. TRKJ PNL)', 'Implementasi penuh 7 Lapisan OSI Layer, mikrokontroler ESP32 multi-zona, AI Rule-Based 100% akurasi, latensi 180 ms, 0% Packet Loss.'),
                            _buildProjectItem('2. Website Sistem Informasi & Pendaftaran Kuliah Umum TIK PNL (2025 - 2026)', 'Portal pendaftaran seminar akademik mahasiswa TIK, kuota otomatis, sistem absensi digital QR Code, dan rekapitulasi data pendaftar.'),
                            _buildProjectItem('3. Website Sistem Informasi Sertifikat Dosen PNL (2025 - 2026)', 'Repositori kredensial sertifikasi dosen terpusat, audit Beban Kerja Dosen (BKD), verifikasi keabsahan dokumen QR code kampus.'),
                            _buildProjectItem('4. Website Sistem Informasi Sertifikat Mahasiswa/i TIK PNL (2025 - 2026)', 'Platform penerbitan e-sertifikat digital otomatis, validasi anti-pemalsuan, dan sinkronisasi Surat Keterangan Pendamping Ijazah (SKPI).'),

                            const SizedBox(height: 24),

                            // 5. Honors & Competitions
                            _buildSectionHeader('PRESTASI & KEJUARAAN TINGKAT NASIONAL', Icons.emoji_events_rounded),
                            const SizedBox(height: 10),
                            _buildBulletItem('Finalis Bidang Inovasi Perangkat Lunak - KMIPN VI 2025 (Kompetisi Mahasiswa Informatika Politeknik Nasional)'),
                            _buildBulletItem('Medali Emas / Juara Nasional - NSO 5 (National Science Olympiad V - Bidang English)'),
                            _buildBulletItem('Medali / Juara Nasional - OSPN (Olimpiade Sains Pemuda Nusantara - Bidang Akuntansi & Logika)'),
                            _buildBulletItem('Penghargaan Nasional - OSH 2025 (Olimpiade Sains Hardiknas - Bidang Bahasa Indonesia)'),

                            const SizedBox(height: 24),

                            // 6. Professional Training
                            _buildSectionHeader('11 SERTIFIKASI RESMI KOMINFO DIGITAL TALENT SCHOLARSHIP (DTS)', Icons.workspace_premium_rounded),
                            const SizedBox(height: 10),
                            _buildBulletItem('11 Kredensial Resmi Terverifikasi Kementerian Komunikasi dan Informatika Republik Indonesia (2024 - 2025) meliputi AI & Machine Learning, Cloud Architecture, Cybersecurity, Digital Product, dan Media Strategist.'),
                          ],
                        ),
                      ),
                    ),

                    // Modal Footer Actions
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CleanButton(
                            text: 'Unduh Berkas CV (PDF)',
                            icon: Icons.file_download_rounded,
                            variant: CleanButtonVariant.primary,
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            onPressed: () {
                              UrlHelper.downloadCv(context: context);
                            },
                          ),
                          CleanButton(
                            text: 'Tutup',
                            icon: Icons.close_rounded,
                            variant: CleanButtonVariant.outline,
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
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

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTypography.badge.copyWith(
            color: AppColors.textPrimary,
            fontSize: 12.5,
            letterSpacing: 1.1,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }

  Widget _buildContactChip(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTypography.code.copyWith(fontSize: 11.5, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildSkillGroup(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          style: AppTypography.bodySmall.copyWith(fontSize: 13, color: AppColors.textSecondary, height: 1.5),
          children: [
            TextSpan(text: '• $title: ', style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            TextSpan(text: desc),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectItem(String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w700, fontSize: 13.5, color: AppColors.primaryDark)),
          const SizedBox(height: 2),
          Text(desc, style: AppTypography.bodySmall.copyWith(fontSize: 12.5, color: AppColors.textSecondary, height: 1.4)),
        ],
      ),
    );
  }

  Widget _buildBulletItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 5,
            height: 5,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTypography.bodySmall.copyWith(fontSize: 13, color: AppColors.textSecondary, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCvTimelineItem({
    required String period,
    required String title,
    required String institution,
    required List<String> details,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.iceBlue.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFBAE6FD).withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary, fontSize: 13.5)),
              Text(period, style: AppTypography.code.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 2),
          Text(institution, style: AppTypography.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 12.5)),
          const SizedBox(height: 8),
          ...details.map((d) => Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text('• $d', style: AppTypography.bodySmall.copyWith(fontSize: 12.5, color: AppColors.textSecondary)),
              )),
        ],
      ),
    );
  }
}

