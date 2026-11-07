// ignore_for_file: depend_on_referenced_packages
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Generates a professional styled PDF CV for Nazarul Qudri, S.Tr.T.
/// Uses MultiPage single-column layout to prevent page overflow errors.
class CvPdfGenerator {
  static const PdfColor _primary     = PdfColor.fromInt(0xFF0284C7);
  static const PdfColor _primaryDark = PdfColor.fromInt(0xFF1D4ED8);
  static const PdfColor _accent      = PdfColor.fromInt(0xFF06B6D4);
  static const PdfColor _dark        = PdfColor.fromInt(0xFF0F172A);
  static const PdfColor _textPri     = PdfColor.fromInt(0xFF1E293B);
  static const PdfColor _textSec     = PdfColor.fromInt(0xFF64748B);
  static const PdfColor _bgLight     = PdfColor.fromInt(0xFFF0F9FF);
  static const PdfColor _white       = PdfColor.fromInt(0xFFFFFFFF);
  static const PdfColor _divider     = PdfColor.fromInt(0xFFE2E8F0);
  static const PdfColor _green       = PdfColor.fromInt(0xFF10B981);
  static const PdfColor _purple      = PdfColor.fromInt(0xFF7C3AED);
  static const PdfColor _orange      = PdfColor.fromInt(0xFFF59E0B);

  static Future<Uint8List> generate() async {
    final pdf = pw.Document(
      title: 'CV Nazarul Qudri, S.Tr.T.',
      author: 'Nazarul Qudri',
      subject: 'Curriculum Vitae Resmi',
    );

    final fontR  = await PdfGoogleFonts.interRegular();
    final fontM  = await PdfGoogleFonts.interMedium();
    final fontB  = await PdfGoogleFonts.interBold();
    final fontEB = await PdfGoogleFonts.interExtraBold();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(0, 0, 0, 0),
        theme: pw.ThemeData.withFont(base: fontR, bold: fontB),
        header: (ctx) => _buildHeader(fontEB, fontB, fontM, fontR),
        footer: (ctx) => _buildFooter(fontR, ctx),
        build: (ctx) => [
          pw.Padding(
            padding: const pw.EdgeInsets.fromLTRB(28, 16, 28, 0),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // ── RINGKASAN PROFIL ──────────────────────
                _sectionTitle('RINGKASAN PROFIL', _primary, fontB),
                pw.SizedBox(height: 6),
                pw.Text(
                  'Software Engineer dan Sarjana Terapan Teknik (S.Tr.T.) Program Studi D4 Teknologi Rekayasa Komputer Jaringan (TRKJ), Jurusan Teknologi Informasi dan Komputer (TIK) Politeknik Negeri Lhokseumawe. Spesialis dalam rekayasa aplikasi mobile Flutter cross-platform (Dart & BLoC), sistem siber-fisik IoT CPS berbasis 7 Lapisan OSI & MQTT/TLS, kecerdasan buatan (Rule-Based Decision Systems & AI Studio), serta pengembangan sistem informasi web akademik terintegrasi.',
                  style: pw.TextStyle(font: fontR, fontSize: 9, color: _textPri, lineSpacing: 1.5),
                ),
                pw.SizedBox(height: 14),

                // ── PENDIDIKAN FORMAL ─────────────────────
                _sectionTitle('PENDIDIKAN FORMAL', _purple, fontB),
                pw.SizedBox(height: 6),
                _educationCard(fontB, fontM, fontR),
                pw.SizedBox(height: 14),

                // ── KEAHLIAN UTAMA (2 column) ─────────────
                _sectionTitle('KEAHLIAN UTAMA & SPESIALISASI', _primary, fontB),
                pw.SizedBox(height: 6),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _skillBar('Mobile Dev — Flutter & Dart', 0.95, _primary, fontM),
                          pw.SizedBox(height: 6),
                          _skillBar('IoT & Networking — 7 OSI Layer', 0.92, _accent, fontM),
                          pw.SizedBox(height: 6),
                          _skillBar('AI & Decision Systems', 0.90, _purple, fontM),
                          pw.SizedBox(height: 6),
                          _skillBar('Web Development', 0.85, _green, fontM),
                          pw.SizedBox(height: 6),
                          _skillBar('Tools & Admin', 0.88, _orange, fontM),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _specItem('Flutter & Dart', 'Cross-Platform Mobile & Web (60 FPS)', _primary, fontB, fontR),
                          _specItem('BLoC Pattern', 'Reactive State Management', _accent, fontB, fontR),
                          _specItem('IoT CPS', 'ESP32, ESP8266, MQTT/TLS, VLAN', _green, fontB, fontR),
                          _specItem('AI / Rule-Based', 'Decision System & AI Studio', _purple, fontB, fontR),
                          _specItem('Web Dev', 'Laravel, MySQL, HTML/CSS, PHP', _orange, fontB, fontR),
                          _specItem('Tools', 'Figma, VS Code, Git/GitHub, MS Office', _textSec, fontB, fontR),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 14),

                // ── PROYEK (2 column) ─────────────────────
                _sectionTitle('PROYEK REKAYASA UNGGULAN', _primary, fontB),
                pw.SizedBox(height: 6),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(child: pw.Column(children: [
                      _projectCard(
                        no: '1', color: _primary,
                        title: 'STARZAR — Smart Exclusive Home IoT & AI',
                        sub: 'Skripsi S.Tr.T. TRKJ PNL • 2024–2026',
                        desc: 'Smart Home berbasis ESP32, 7 OSI Layer, MQTT HiveMQ & Rule-Based AI. Latensi 180ms, 0% Packet Loss, Predikat Sangat Memuaskan.',
                        tags: ['Flutter', 'ESP32', 'MQTT/TLS', 'AI'],
                        fontB: fontB, fontM: fontM, fontR: fontR,
                      ),
                      pw.SizedBox(height: 6),
                      _projectCard(
                        no: '2', color: _accent,
                        title: 'Sistem Informasi & Pendaftaran Kuliah Umum',
                        sub: 'Jurusan TIK PNL • 2025–2026',
                        desc: 'Portal web pendaftaran, absensi QR Code digital, dan agenda kuliah bagi 1.000+ mahasiswa TIK PNL.',
                        tags: ['Laravel', 'MySQL', 'QR Absensi'],
                        fontB: fontB, fontM: fontM, fontR: fontR,
                      ),
                    ])),
                    pw.SizedBox(width: 10),
                    pw.Expanded(child: pw.Column(children: [
                      _projectCard(
                        no: '3', color: _purple,
                        title: 'Sistem Informasi Sertifikat Dosen PNL',
                        sub: 'Politeknik Negeri Lhokseumawe • 2025–2026',
                        desc: 'Repositori digital pengarsipan & verifikasi sertifikat kompetensi dosen — mendukung BKD & akreditasi jurusan.',
                        tags: ['Web System', 'Repository', 'Auth'],
                        fontB: fontB, fontM: fontM, fontR: fontR,
                      ),
                      pw.SizedBox(height: 6),
                      _projectCard(
                        no: '4', color: _green,
                        title: 'Sistem Informasi Sertifikat Mahasiswa/i TIK',
                        sub: 'Jurusan TIK PNL • 2025–2026',
                        desc: 'Platform penerbitan e-sertifikat digital, validasi SKPI, dan manajemen dokumen akademik terintegrasi.',
                        tags: ['E-Sertifikat', 'SKPI', 'Web'],
                        fontB: fontB, fontM: fontM, fontR: fontR,
                      ),
                    ])),
                  ],
                ),
                pw.SizedBox(height: 14),

                // ── PRESTASI & SERTIFIKASI (2 column) ─────
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _sectionTitle('PRESTASI NASIONAL', _orange, fontB),
                          pw.SizedBox(height: 6),
                          _achievementItem('1', 'Finalis Inovasi Perangkat Lunak', 'KMIPN VI 2025 — Politeknik Nasional', _orange, fontB, fontR),
                          pw.SizedBox(height: 5),
                          _achievementItem('2', 'Medali Nasional NSO 5', 'National Science Olympiad — Bahasa Inggris', _orange, fontB, fontR),
                          pw.SizedBox(height: 5),
                          _achievementItem('3', 'Medali Nasional OSPN', 'Olimpiade Sains — Akuntansi & Logika Kuantitatif', _orange, fontB, fontR),
                          pw.SizedBox(height: 5),
                          _achievementItem('4', 'Medali Nasional OSH 2025', 'Olimpiade Sains — Bahasa Indonesia', _orange, fontB, fontR),
                        ],
                      ),
                    ),
                    pw.SizedBox(width: 20),
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          _sectionTitle('SERTIFIKASI KOMINFO DTS', _green, fontB),
                          pw.SizedBox(height: 6),
                          pw.Container(
                            padding: const pw.EdgeInsets.all(10),
                            decoration: pw.BoxDecoration(
                              color: _bgLight,
                              borderRadius: pw.BorderRadius.circular(8),
                              border: pw.Border.all(
                                  color: _green.shade(0.3), width: 0.8),
                            ),
                            child: pw.Row(
                              children: [
                                pw.Container(
                                  width: 36, height: 36,
                                  decoration: pw.BoxDecoration(
                                    color: _green.shade(0.15),
                                    shape: pw.BoxShape.circle,
                                  ),
                                  alignment: pw.Alignment.center,
                                  child: pw.Text('11',
                                      style: pw.TextStyle(
                                          font: fontB, fontSize: 14,
                                          color: _green)),
                                ),
                                pw.SizedBox(width: 10),
                                pw.Expanded(child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text('Sertifikasi Resmi Terverifikasi',
                                        style: pw.TextStyle(font: fontB,
                                            fontSize: 9, color: _textPri)),
                                    pw.SizedBox(height: 2),
                                    pw.Text(
                                      'Kementerian Komunikasi & Informatika RI\nDigital Talent Scholarship 2024–2025',
                                      style: pw.TextStyle(font: fontR,
                                          fontSize: 8, color: _textSec,
                                          lineSpacing: 1.3),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );

    return pdf.save();
  }

  // ══════════════════════════════════════════════════════════════
  // HEADER (shown on every page via MultiPage.header)
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _buildHeader(
      pw.Font eb, pw.Font b, pw.Font m, pw.Font r) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_dark, _primaryDark, _primary],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.fromLTRB(28, 20, 28, 16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('NAZARUL QUDRI, S.Tr.T.',
                      style: pw.TextStyle(font: eb, fontSize: 22,
                          color: _white, letterSpacing: 1.3)),
                  pw.SizedBox(height: 2),
                  pw.Text('Flutter Developer  •  IoT CPS & AI Specialist',
                      style: pw.TextStyle(font: m, fontSize: 10,
                          color: PdfColor.fromInt(0xFFBAE6FD))),
                  pw.Text(
                      'D4 Teknologi Rekayasa Komputer Jaringan — Politeknik Negeri Lhokseumawe',
                      style: pw.TextStyle(font: r, fontSize: 8.5,
                          color: PdfColor.fromInt(0xFF93C5FD))),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  _hContact('zarqud@gmail.com', r),
                  _hContact('github.com/nazarulqudritrkj', r),
                  _hContact('linkedin.com/in/nazarul-qudri-62178824a', r),
                  _hContact('Lhokseumawe, Aceh, Indonesia', r),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Container(
              height: 0.8,
              color: PdfColor.fromInt(0x44FFFFFF),
              margin: const pw.EdgeInsets.only(bottom: 8)),
          pw.Row(children: [
            _chip('Tersedia untuk Kolaborasi', _green, m),
            pw.SizedBox(width: 6),
            _chip('4+ Tahun Pengalaman', _accent, m),
            pw.SizedBox(width: 6),
            _chip('11 Sertifikasi Kominfo DTS', _orange, m),
            pw.SizedBox(width: 6),
            _chip('Lhokseumawe, Aceh', _primary, m),
          ]),
        ],
      ),
    );
  }

  static pw.Widget _hContact(String t, pw.Font r) => pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 2),
    child: pw.Text(t,
        style: pw.TextStyle(font: r, fontSize: 8,
            color: PdfColor.fromInt(0xFFCBD5E1))),
  );

  static pw.Widget _chip(String t, PdfColor c, pw.Font m) =>
      pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: pw.BoxDecoration(
          color: c.shade(0.2),
          borderRadius: pw.BorderRadius.circular(20),
          border: pw.Border.all(color: c, width: 0.6),
        ),
        child: pw.Text(t,
            style: pw.TextStyle(font: m, fontSize: 7.5, color: c)),
      );

  // ══════════════════════════════════════════════════════════════
  // FOOTER
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _buildFooter(pw.Font r, pw.Context ctx) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_dark, _primaryDark],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            '© 2026 Nazarul Qudri, S.Tr.T.  •  Terlindungi UU ITE',
            style: pw.TextStyle(font: r, fontSize: 8,
                color: PdfColor.fromInt(0xFF93C5FD)),
          ),
          pw.Text(
            'Halaman ${ctx.pageNumber} / ${ctx.pagesCount}',
            style: pw.TextStyle(font: r, fontSize: 8,
                color: PdfColor.fromInt(0xFF64748B)),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // SECTION TITLE
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _sectionTitle(
      String title, PdfColor color, pw.Font fontB) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(children: [
          pw.Container(width: 3, height: 14, color: color),
          pw.SizedBox(width: 7),
          pw.Text(title,
              style: pw.TextStyle(font: fontB, fontSize: 9,
                  color: _dark, letterSpacing: 0.7)),
        ]),
        pw.Container(
            height: 0.7, color: _divider,
            margin: const pw.EdgeInsets.only(top: 3)),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════
  // EDUCATION CARD
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _educationCard(
      pw.Font b, pw.Font m, pw.Font r) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(0xFFF5F3FF),
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border(left: pw.BorderSide(color: _purple, width: 3)),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'D4 Teknologi Rekayasa Komputer Jaringan (TRKJ)',
                      style: pw.TextStyle(font: b, fontSize: 9, color: _dark),
                    ),
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: pw.BoxDecoration(
                        color: _purple.shade(0.15),
                        borderRadius: pw.BorderRadius.circular(10),
                      ),
                      child: pw.Text('2022 – 2026',
                          style: pw.TextStyle(
                              font: b, fontSize: 7.5, color: _purple)),
                    ),
                  ],
                ),
                pw.SizedBox(height: 2),
                pw.Text('Politeknik Negeri Lhokseumawe (PNL)  •  Jurusan TIK',
                    style: pw.TextStyle(font: m, fontSize: 8.5, color: _purple)),
                pw.SizedBox(height: 8),
                pw.Row(children: [
                  pw.Expanded(child: pw.Column(children: [
                    _eRow('Gelar', 'Sarjana Terapan Teknik (S.Tr.T.)', b, r),
                    _eRow('Predikat', 'Sangat Memuaskan / Pujian', b, r),
                  ])),
                  pw.SizedBox(width: 10),
                  pw.Expanded(child: pw.Column(children: [
                    _eRow('Lulus Sidang', '29 Juli 2026', b, r),
                    _eRow('Pembimbing I', 'Husaini, S.Si., M.I.T.', b, r),
                  ])),
                ]),
                pw.SizedBox(height: 6),
                pw.Container(
                  padding: const pw.EdgeInsets.all(8),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFFEDE9FE),
                    borderRadius: pw.BorderRadius.circular(6),
                  ),
                  child: pw.Text(
                    'Skripsi: Rancang Bangun IoT pada Prototype Smart Home dengan Penerapan Rule-Based Decision System sebagai Artificial Intelligence (Aplikasi STARZAR — Implementasi Lengkap 7 OSI Layer & MQTT HiveMQ)',
                    style: pw.TextStyle(font: r, fontSize: 8,
                        color: _purple, lineSpacing: 1.3),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _eRow(String l, String v, pw.Font b, pw.Font r) =>
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 3),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(
                width: 70,
                child: pw.Text(l,
                    style: pw.TextStyle(font: b, fontSize: 8, color: _textSec))),
            pw.Text(':  ',
                style: pw.TextStyle(font: b, fontSize: 8, color: _textSec)),
            pw.Expanded(
                child: pw.Text(v,
                    style: pw.TextStyle(font: r, fontSize: 8, color: _textPri))),
          ],
        ),
      );

  // ══════════════════════════════════════════════════════════════
  // SKILL BAR
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _skillBar(
      String name, double pct, PdfColor color, pw.Font m) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(name,
                style: pw.TextStyle(font: m, fontSize: 8.5, color: _textPri)),
            pw.Text('${(pct * 100).toInt()}%',
                style: pw.TextStyle(font: m, fontSize: 8.5, color: color)),
          ],
        ),
        pw.SizedBox(height: 3),
        pw.Stack(children: [
          pw.Container(
            height: 6,
            decoration: pw.BoxDecoration(
              color: _divider,
              borderRadius: pw.BorderRadius.circular(3),
            ),
          ),
          pw.Container(
            height: 6,
            width: 220 * pct,
            decoration: pw.BoxDecoration(
              gradient: pw.LinearGradient(
                  colors: [color, color.shade(0.65)]),
              borderRadius: pw.BorderRadius.circular(3),
            ),
          ),
        ]),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════
  // SPEC ITEM
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _specItem(
      String title, String desc, PdfColor color,
      pw.Font b, pw.Font r) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 6),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 5, height: 5,
            margin: const pw.EdgeInsets.only(top: 2.5, right: 6),
            decoration: pw.BoxDecoration(
                color: color, shape: pw.BoxShape.circle),
          ),
          pw.Expanded(child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(title,
                  style: pw.TextStyle(font: b, fontSize: 8.5, color: _textPri)),
              pw.Text(desc,
                  style: pw.TextStyle(font: r, fontSize: 8, color: _textSec)),
            ],
          )),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // PROJECT CARD
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _projectCard({
    required String no,
    required PdfColor color,
    required String title,
    required String sub,
    required String desc,
    required List<String> tags,
    required pw.Font fontB,
    required pw.Font fontM,
    required pw.Font fontR,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: _white,
        borderRadius: pw.BorderRadius.circular(7),
        border: pw.Border(left: pw.BorderSide(color: color, width: 3)),
        boxShadow: [
          pw.BoxShadow(
            color: PdfColor.fromInt(0x0C000000),
            blurRadius: 6,
            offset: const PdfPoint(0, 2),
          ),
        ],
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 18, height: 18,
                decoration: pw.BoxDecoration(
                  color: color.shade(0.15),
                  shape: pw.BoxShape.circle,
                ),
                alignment: pw.Alignment.center,
                child: pw.Text(no,
                    style: pw.TextStyle(font: fontB, fontSize: 8, color: color)),
              ),
              pw.SizedBox(width: 6),
              pw.Expanded(child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(title,
                      style: pw.TextStyle(font: fontB, fontSize: 8.5, color: _dark)),
                  pw.Text(sub,
                      style: pw.TextStyle(font: fontM, fontSize: 7.5, color: color)),
                ],
              )),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Text(desc,
              style: pw.TextStyle(font: fontR, fontSize: 8,
                  color: _textSec, lineSpacing: 1.3)),
          pw.SizedBox(height: 5),
          pw.Wrap(
            spacing: 4,
            runSpacing: 3,
            children: tags.map((t) => pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                  horizontal: 6, vertical: 2),
              decoration: pw.BoxDecoration(
                color: color.shade(0.1),
                borderRadius: pw.BorderRadius.circular(10),
                border: pw.Border.all(color: color.shade(0.4), width: 0.5),
              ),
              child: pw.Text(t,
                  style: pw.TextStyle(font: fontM, fontSize: 7.5, color: color)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════
  // ACHIEVEMENT ITEM
  // ══════════════════════════════════════════════════════════════
  static pw.Widget _achievementItem(
      String no, String title, String sub,
      PdfColor color, pw.Font b, pw.Font r) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 18, height: 18,
          decoration: pw.BoxDecoration(
            color: color.shade(0.15), shape: pw.BoxShape.circle),
          alignment: pw.Alignment.center,
          child: pw.Text(no,
              style: pw.TextStyle(font: b, fontSize: 8, color: color)),
        ),
        pw.SizedBox(width: 7),
        pw.Expanded(child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(title,
                style: pw.TextStyle(font: b, fontSize: 8.5, color: _textPri)),
            pw.Text(sub,
                style: pw.TextStyle(font: r, fontSize: 8, color: _textSec)),
          ],
        )),
      ],
    );
  }
}
