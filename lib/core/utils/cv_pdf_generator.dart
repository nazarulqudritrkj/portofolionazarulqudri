// ignore_for_file: depend_on_referenced_packages
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Generates a professional styled PDF CV for Nazarul Qudri, S.Tr.T.
class CvPdfGenerator {
  // ── Brand Colors ──────────────────────────────────────────────
  static const PdfColor _primary = PdfColor.fromInt(0xFF0284C7);
  static const PdfColor _primaryDark = PdfColor.fromInt(0xFF1D4ED8);
  static const PdfColor _accent = PdfColor.fromInt(0xFF06B6D4);
  static const PdfColor _dark = PdfColor.fromInt(0xFF0F172A);
  static const PdfColor _textPrimary = PdfColor.fromInt(0xFF1E293B);
  static const PdfColor _textSecondary = PdfColor.fromInt(0xFF64748B);
  static const PdfColor _bgLight = PdfColor.fromInt(0xFFF0F9FF);
  static const PdfColor _white = PdfColor.fromInt(0xFFFFFFFF);
  static const PdfColor _divider = PdfColor.fromInt(0xFFE2E8F0);
  static const PdfColor _green = PdfColor.fromInt(0xFF10B981);
  static const PdfColor _purple = PdfColor.fromInt(0xFF7C3AED);
  static const PdfColor _orange = PdfColor.fromInt(0xFFF59E0B);

  static Future<Uint8List> generate() async {
    final pdf = pw.Document(
      title: 'CV Nazarul Qudri, S.Tr.T.',
      author: 'Nazarul Qudri',
      subject: 'Curriculum Vitae Resmi',
    );

    // Load fonts
    final fontRegular =
        await PdfGoogleFonts.interRegular();
    final fontMedium = await PdfGoogleFonts.interMedium();
    final fontBold = await PdfGoogleFonts.interBold();
    final fontExtraBold = await PdfGoogleFonts.interExtraBold();

    final baseTheme = pw.ThemeData.withFont(
      base: fontRegular,
      bold: fontBold,
    );

    pdf.addPage(
      pw.MultiPage(
        theme: baseTheme,
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (context) => [
          _buildHeader(fontExtraBold, fontBold, fontMedium, fontRegular),
          pw.SizedBox(height: 0),
          _buildBody(fontExtraBold, fontBold, fontMedium, fontRegular),
        ],
      ),
    );

    return pdf.save();
  }

  // ══════════════════════════════════════════════════════════════
  // HEADER SECTION
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _buildHeader(
    pw.Font fontExtraBold,
    pw.Font fontBold,
    pw.Font fontMedium,
    pw.Font fontRegular,
  ) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_dark, _primaryDark, _primary],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.fromLTRB(32, 28, 32, 24),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Name Row
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Left: Name + Title
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'NAZARUL QUDRI',
                      style: pw.TextStyle(
                        font: fontExtraBold,
                        fontSize: 26,
                        color: _white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    pw.Text(
                      'S.Tr.T.',
                      style: pw.TextStyle(
                        font: fontBold,
                        fontSize: 18,
                        color: _accent,
                        letterSpacing: 0.8,
                      ),
                    ),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      'Flutter Developer  •  IoT CPS & AI Specialist',
                      style: pw.TextStyle(
                        font: fontMedium,
                        fontSize: 11,
                        color: PdfColor.fromInt(0xFFBAE6FD),
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      'D4 Teknologi Rekayasa Komputer Jaringan — Politeknik Negeri Lhokseumawe',
                      style: pw.TextStyle(
                        font: fontRegular,
                        fontSize: 9.5,
                        color: PdfColor.fromInt(0xFF93C5FD),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(width: 24),
              // Right: Contact Info
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  _headerContact('zarqud@gmail.com', fontRegular),
                  _headerContact('github.com/nazarulqudritrkj', fontRegular),
                  _headerContact('linkedin.com/in/nazarul-qudri-62178824a', fontRegular),
                  _headerContact('Lhokseumawe, Aceh, Indonesia', fontRegular),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 14),
          // Divider
          pw.Container(
            height: 1,
            color: PdfColor.fromInt(0x33FFFFFF),
          ),
          pw.SizedBox(height: 10),
          // Status chips row
          pw.Row(
            children: [
              _headerChip('Tersedia untuk Kolaborasi', _green, fontMedium),
              pw.SizedBox(width: 8),
              _headerChip('4+ Tahun Pengalaman', _accent, fontMedium),
              pw.SizedBox(width: 8),
              _headerChip('11 Sertifikasi Kominfo DTS', _orange, fontMedium),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _headerContact(String text, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 3),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          font: font,
          fontSize: 8.5,
          color: PdfColor.fromInt(0xFFCBD5E1),
        ),
      ),
    );
  }

  static pw.Widget _headerChip(String text, PdfColor color, pw.Font font) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: pw.BoxDecoration(
        color: color.shade(0.25),
        borderRadius: pw.BorderRadius.circular(20),
        border: pw.Border.all(color: color, width: 0.8),
      ),
      child: pw.Text(
        text,
        style: pw.TextStyle(font: font, fontSize: 8, color: color),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // BODY — TWO COLUMN LAYOUT
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _buildBody(
    pw.Font fontExtraBold,
    pw.Font fontBold,
    pw.Font fontMedium,
    pw.Font fontRegular,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.fromLTRB(28, 20, 28, 20),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // ── LEFT COLUMN (60%) ──
          pw.Expanded(
            flex: 60,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: 'RINGKASAN PROFIL',
                  icon: '◈',
                  color: _primary,
                  fontBold: fontBold,
                  fontMedium: fontMedium,
                  content: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Software Engineer dan Sarjana Terapan Teknik (S.Tr.T.) Program Studi D4 Teknologi Rekayasa Komputer Jaringan (TRKJ), Jurusan Teknologi Informasi dan Komputer (TIK) Politeknik Negeri Lhokseumawe.',
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 9.5,
                          color: _textPrimary,
                          lineSpacing: 1.4,
                        ),
                      ),
                      pw.SizedBox(height: 6),
                      pw.Text(
                        'Spesialis dalam rekayasa aplikasi mobile Flutter cross-platform (Dart & BLoC), sistem siber-fisik IoT CPS berbasis 7 Lapisan OSI Model & MQTT/TLS, kecerdasan buatan (Rule-Based Decision Systems & AI Studio), dan pengembangan sistem informasi web akademik terintegrasi.',
                        style: pw.TextStyle(
                          font: fontRegular,
                          fontSize: 9.5,
                          color: _textPrimary,
                          lineSpacing: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                _buildSection(
                  title: 'PENDIDIKAN FORMAL',
                  icon: '◈',
                  color: _purple,
                  fontBold: fontBold,
                  fontMedium: fontMedium,
                  content: _buildEducationCard(fontBold, fontMedium, fontRegular),
                ),
                pw.SizedBox(height: 16),

                _buildSection(
                  title: 'PROYEK REKAYASA UNGGULAN',
                  icon: '◈',
                  color: _primary,
                  fontBold: fontBold,
                  fontMedium: fontMedium,
                  content: pw.Column(
                    children: [
                      _buildProject(
                        no: '1',
                        title: 'STARZAR — Smart Exclusive Home IoT & AI',
                        subtitle: 'Skripsi S.Tr.T. TRKJ PNL • 2024–2026',
                        desc: 'Sistem siber-fisik Smart Home berbasis ESP32, 7 OSI Layer, MQTT HiveMQ, dan Rule-Based AI. Latensi 180ms, 0% Packet Loss, Predikat Sangat Memuaskan.',
                        tags: ['Flutter', 'ESP32', '7 OSI Layer', 'MQTT', 'AI'],
                        color: _primary,
                        fontBold: fontBold,
                        fontMedium: fontMedium,
                        fontRegular: fontRegular,
                      ),
                      pw.SizedBox(height: 8),
                      _buildProject(
                        no: '2',
                        title: 'Sistem Informasi & Pendaftaran Kuliah Umum',
                        subtitle: 'Jurusan TIK PNL • 2025–2026',
                        desc: 'Portal web pendaftaran, registrasi peserta, absensi digital QR Code, dan pengelolaan agenda kuliah umum bagi 1.000+ mahasiswa TIK.',
                        tags: ['Laravel', 'Web Portal', 'MySQL', 'QR Absensi'],
                        color: _accent,
                        fontBold: fontBold,
                        fontMedium: fontMedium,
                        fontRegular: fontRegular,
                      ),
                      pw.SizedBox(height: 8),
                      _buildProject(
                        no: '3',
                        title: 'Sistem Informasi Sertifikat Dosen PNL',
                        subtitle: 'Politeknik Negeri Lhokseumawe • 2025–2026',
                        desc: 'Repositori digital terpusat untuk pengarsipan, pencarian, dan verifikasi sertifikat kompetensi seluruh dosen PNL — mendukung BKD & akreditasi jurusan.',
                        tags: ['Web System', 'Document Repository', 'Security Auth'],
                        color: _purple,
                        fontBold: fontBold,
                        fontMedium: fontMedium,
                        fontRegular: fontRegular,
                      ),
                      pw.SizedBox(height: 8),
                      _buildProject(
                        no: '4',
                        title: 'Sistem Informasi Sertifikat Mahasiswa/i TIK',
                        subtitle: 'Jurusan TIK PNL • 2025–2026',
                        desc: 'Platform penerbitan e-sertifikat digital, validasi SKPI, dan manajemen dokumen akademik mahasiswa Jurusan TIK PNL secara terintegrasi.',
                        tags: ['E-Sertifikat', 'SKPI Validation', 'Web'],
                        color: _green,
                        fontBold: fontBold,
                        fontMedium: fontMedium,
                        fontRegular: fontRegular,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          pw.SizedBox(width: 18),

          // ── RIGHT COLUMN (40%) ──
          pw.Expanded(
            flex: 40,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _buildSection(
                  title: 'KEAHLIAN UTAMA',
                  icon: '◈',
                  color: _primary,
                  fontBold: fontBold,
                  fontMedium: fontMedium,
                  content: pw.Column(
                    children: [
                      _buildSkillBar('Mobile Dev (Flutter & Dart)', 0.95, _primary, fontMedium, fontRegular),
                      pw.SizedBox(height: 8),
                      _buildSkillBar('IoT & Networking (7 OSI Layer)', 0.92, _accent, fontMedium, fontRegular),
                      pw.SizedBox(height: 8),
                      _buildSkillBar('AI & Decision Systems', 0.90, _purple, fontMedium, fontRegular),
                      pw.SizedBox(height: 8),
                      _buildSkillBar('Web Development', 0.85, _green, fontMedium, fontRegular),
                      pw.SizedBox(height: 8),
                      _buildSkillBar('Tools & Admin (Office, Figma, Git)', 0.88, _orange, fontMedium, fontRegular),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                _buildSection(
                  title: 'SPESIALISASI TEKNIS',
                  icon: '◈',
                  color: _accent,
                  fontBold: fontBold,
                  fontMedium: fontMedium,
                  content: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildSpecItem('Flutter', 'Cross-Platform Mobile & Web', fontBold, fontRegular, _primary),
                      _buildSpecItem('Dart & BLoC', 'Reactive State Management', fontBold, fontRegular, _accent),
                      _buildSpecItem('IoT CPS', 'ESP32, ESP8266, MQTT/TLS, VLAN', fontBold, fontRegular, _green),
                      _buildSpecItem('AI/ML', 'Rule-Based Decision System, AI Studio', fontBold, fontRegular, _purple),
                      _buildSpecItem('Web', 'Laravel, MySQL, HTML/CSS, PHP', fontBold, fontRegular, _orange),
                      _buildSpecItem('Tools', 'Figma, VS Code, Git, MS Office', fontBold, fontRegular, _textSecondary),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                _buildSection(
                  title: 'PRESTASI NASIONAL',
                  icon: '◈',
                  color: _orange,
                  fontBold: fontBold,
                  fontMedium: fontMedium,
                  content: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      _buildAchievement('🥇', 'Finalis Inovasi Perangkat Lunak', 'KMIPN VI 2025 — Politeknik Nasional', fontBold, fontRegular),
                      pw.SizedBox(height: 6),
                      _buildAchievement('🥈', 'Medali Nasional NSO 5', 'National Science Olympiad — Bidang Bahasa Inggris', fontBold, fontRegular),
                      pw.SizedBox(height: 6),
                      _buildAchievement('🏅', 'Medali Nasional OSPN', 'Olimpiade Sains — Akuntansi & Logika Kuantitatif', fontBold, fontRegular),
                      pw.SizedBox(height: 6),
                      _buildAchievement('🏆', 'Medali Nasional OSH 2025', 'Olimpiade Sains — Bidang Bahasa Indonesia', fontBold, fontRegular),
                    ],
                  ),
                ),
                pw.SizedBox(height: 16),

                _buildSection(
                  title: 'SERTIFIKASI KOMINFO DTS',
                  icon: '◈',
                  color: _green,
                  fontBold: fontBold,
                  fontMedium: fontMedium,
                  content: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Container(
                        padding: const pw.EdgeInsets.all(10),
                        decoration: pw.BoxDecoration(
                          color: _bgLight,
                          borderRadius: pw.BorderRadius.circular(8),
                          border: pw.Border.all(color: _green.shade(0.3), width: 0.8),
                        ),
                        child: pw.Row(
                          children: [
                            pw.Container(
                              width: 36,
                              height: 36,
                              decoration: pw.BoxDecoration(
                                color: _green.shade(0.15),
                                shape: pw.BoxShape.circle,
                              ),
                              alignment: pw.Alignment.center,
                              child: pw.Text(
                                '11',
                                style: pw.TextStyle(
                                  font: fontBold,
                                  fontSize: 14,
                                  color: _green,
                                ),
                              ),
                            ),
                            pw.SizedBox(width: 10),
                            pw.Expanded(
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    'Sertifikasi Resmi Terverifikasi',
                                    style: pw.TextStyle(
                                      font: fontBold,
                                      fontSize: 9,
                                      color: _textPrimary,
                                    ),
                                  ),
                                  pw.Text(
                                    'Kementerian Komunikasi & Informatika RI\nDigital Talent Scholarship 2024–2025',
                                    style: pw.TextStyle(
                                      font: fontRegular,
                                      fontSize: 8,
                                      color: _textSecondary,
                                      lineSpacing: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // REUSABLE WIDGETS
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _buildSection({
    required String title,
    required String icon,
    required PdfColor color,
    required pw.Font fontBold,
    required pw.Font fontMedium,
    required pw.Widget content,
  }) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Section Header
        pw.Row(
          children: [
            pw.Container(width: 3, height: 16, color: color),
            pw.SizedBox(width: 8),
            pw.Text(
              title,
              style: pw.TextStyle(
                font: fontBold,
                fontSize: 10,
                color: _dark,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Container(
          height: 0.8,
          color: _divider,
          margin: const pw.EdgeInsets.only(bottom: 10),
        ),
        content,
      ],
    );
  }

  static pw.Widget _buildEducationCard(
    pw.Font fontBold,
    pw.Font fontMedium,
    pw.Font fontRegular,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(0xFFF5F3FF),
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border(left: pw.BorderSide(color: _purple, width: 3)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                'D4 Teknologi Rekayasa Komputer Jaringan (TRKJ)',
                style: pw.TextStyle(font: fontBold, fontSize: 9.5, color: _dark),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: pw.BoxDecoration(
                  color: _purple.shade(0.15),
                  borderRadius: pw.BorderRadius.circular(10),
                ),
                child: pw.Text(
                  '2022 – 2026',
                  style: pw.TextStyle(font: fontBold, fontSize: 8, color: _purple),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Politeknik Negeri Lhokseumawe (PNL)  •  Jurusan TIK',
            style: pw.TextStyle(font: fontMedium, fontSize: 9, color: _purple),
          ),
          pw.SizedBox(height: 8),
          _eduRow('Gelar Akademis', 'Sarjana Terapan Teknik (S.Tr.T.)', fontBold, fontRegular),
          _eduRow('Predikat', 'Sangat Memuaskan / Pujian', fontBold, fontRegular),
          _eduRow('Lulus Sidang', '29 Juli 2026', fontBold, fontRegular),
          _eduRow('Pembimbing I', 'Husaini, S.Si., M.I.T.', fontBold, fontRegular),
          pw.SizedBox(height: 6),
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromInt(0xFFEDE9FE),
              borderRadius: pw.BorderRadius.circular(6),
            ),
            child: pw.Text(
              'Skripsi: Rancang Bangun IoT pada Prototype Smart Home dengan Penerapan Rule-Based Decision System sebagai Artificial Intelligence (Aplikasi STARZAR — Implementasi Lengkap 7 OSI Layer & MQTT HiveMQ)',
              style: pw.TextStyle(
                font: fontRegular,
                fontSize: 8.5,
                color: _purple,
                lineSpacing: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _eduRow(
    String label,
    String value,
    pw.Font fontBold,
    pw.Font fontRegular,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 3),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 80,
            child: pw.Text(
              label,
              style: pw.TextStyle(font: fontBold, fontSize: 8.5, color: _textSecondary),
            ),
          ),
          pw.Text(
            ':  ',
            style: pw.TextStyle(font: fontBold, fontSize: 8.5, color: _textSecondary),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              style: pw.TextStyle(font: fontRegular, fontSize: 8.5, color: _textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildProject({
    required String no,
    required String title,
    required String subtitle,
    required String desc,
    required List<String> tags,
    required PdfColor color,
    required pw.Font fontBold,
    required pw.Font fontMedium,
    required pw.Font fontRegular,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: _white,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border(left: pw.BorderSide(color: color, width: 3)),
        boxShadow: [
          pw.BoxShadow(
            color: PdfColor.fromInt(0x0A000000),
            blurRadius: 4,
            offset: const PdfPoint(0, 2),
          ),
        ],
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            children: [
              pw.Container(
                width: 20,
                height: 20,
                decoration: pw.BoxDecoration(
                  color: color.shade(0.15),
                  shape: pw.BoxShape.circle,
                ),
                alignment: pw.Alignment.center,
                child: pw.Text(
                  no,
                  style: pw.TextStyle(font: fontBold, fontSize: 9, color: color),
                ),
              ),
              pw.SizedBox(width: 8),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      title,
                      style: pw.TextStyle(font: fontBold, fontSize: 9.5, color: _dark),
                    ),
                    pw.Text(
                      subtitle,
                      style: pw.TextStyle(font: fontMedium, fontSize: 8, color: color),
                    ),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Text(
            desc,
            style: pw.TextStyle(
              font: fontRegular,
              fontSize: 8.5,
              color: _textSecondary,
              lineSpacing: 1.3,
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Wrap(
            spacing: 4,
            runSpacing: 3,
            children: tags
                .map(
                  (tag) => pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: pw.BoxDecoration(
                      color: color.shade(0.1),
                      borderRadius: pw.BorderRadius.circular(10),
                      border: pw.Border.all(color: color.shade(0.4), width: 0.5),
                    ),
                    child: pw.Text(
                      tag,
                      style: pw.TextStyle(font: fontMedium, fontSize: 7.5, color: color),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildSkillBar(
    String name,
    double percent,
    PdfColor color,
    pw.Font fontMedium,
    pw.Font fontRegular,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              name,
              style: pw.TextStyle(font: fontMedium, fontSize: 8.5, color: _textPrimary),
            ),
            pw.Text(
              '${(percent * 100).toInt()}%',
              style: pw.TextStyle(font: fontMedium, fontSize: 8.5, color: color),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Stack(
          children: [
            // Background track
            pw.Container(
              height: 6,
              decoration: pw.BoxDecoration(
                color: _divider,
                borderRadius: pw.BorderRadius.circular(3),
              ),
            ),
            // Filled portion using LayoutBuilder equivalent
            pw.Container(
              height: 6,
              width: 160 * percent, // approximate width for skill bars
              decoration: pw.BoxDecoration(
                gradient: pw.LinearGradient(
                  colors: [color, color.shade(0.7)],
                ),
                borderRadius: pw.BorderRadius.circular(3),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildSpecItem(
    String title,
    String desc,
    pw.Font fontBold,
    pw.Font fontRegular,
    PdfColor color,
  ) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 5),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 4,
            height: 4,
            margin: const pw.EdgeInsets.only(top: 3, right: 6),
            decoration: pw.BoxDecoration(color: color, shape: pw.BoxShape.circle),
          ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  title,
                  style: pw.TextStyle(font: fontBold, fontSize: 8.5, color: _textPrimary),
                ),
                pw.Text(
                  desc,
                  style: pw.TextStyle(font: fontRegular, fontSize: 8, color: _textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildAchievement(
    String emoji,
    String title,
    String subtitle,
    pw.Font fontBold,
    pw.Font fontRegular,
  ) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(emoji, style: const pw.TextStyle(fontSize: 12)),
        pw.SizedBox(width: 6),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                title,
                style: pw.TextStyle(font: fontBold, fontSize: 8.5, color: _textPrimary),
              ),
              pw.Text(
                subtitle,
                style: pw.TextStyle(font: fontRegular, fontSize: 8, color: _textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
