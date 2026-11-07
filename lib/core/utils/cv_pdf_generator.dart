// ignore_for_file: depend_on_referenced_packages
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Professional CV PDF Generator — Nazarul Qudri, S.Tr.T.
/// Layout: 2-page A4, gradient header, clean sections, readable typography
class CvPdfGenerator {
  // Brand Colors
  static const PdfColor _navy    = PdfColor.fromInt(0xFF0F172A);
  static const PdfColor _blue    = PdfColor.fromInt(0xFF0284C7);
  static const PdfColor _blueD   = PdfColor.fromInt(0xFF1D4ED8);
  static const PdfColor _cyan    = PdfColor.fromInt(0xFF06B6D4);
  static const PdfColor _purple  = PdfColor.fromInt(0xFF7C3AED);
  static const PdfColor _green   = PdfColor.fromInt(0xFF059669);
  static const PdfColor _orange  = PdfColor.fromInt(0xFFD97706);
  static const PdfColor _white   = PdfColor.fromInt(0xFFFFFFFF);
  static const PdfColor _gray100 = PdfColor.fromInt(0xFFF1F5F9);
  static const PdfColor _gray200 = PdfColor.fromInt(0xFFE2E8F0);
  static const PdfColor _gray500 = PdfColor.fromInt(0xFF64748B);
  static const PdfColor _gray800 = PdfColor.fromInt(0xFF1E293B);
  static const PdfColor _purpleL = PdfColor.fromInt(0xFFF5F3FF);

  static Future<Uint8List> generate() async {
    final pdf = pw.Document(
      title: 'CV Nazarul Qudri, S.Tr.T.',
      author: 'Nazarul Qudri, S.Tr.T.',
      subject: 'Curriculum Vitae Resmi — Sarjana Terapan Teknik',
      creator: 'Portfolio System — Politeknik Negeri Lhokseumawe',
    );

    final fontR  = await PdfGoogleFonts.interRegular();
    final fontM  = await PdfGoogleFonts.interMedium();
    final fontB  = await PdfGoogleFonts.interBold();
    final fontEB = await PdfGoogleFonts.interExtraBold();

    // ═══════════════════════════════════════════════════════════
    // PAGE 1 — Header + Profile + Education + Skills
    // ═══════════════════════════════════════════════════════════
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      theme: pw.ThemeData.withFont(base: fontR, bold: fontB),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // ── HEADER ─────────────────────────────────────────
          _buildGradientHeader(fontEB, fontB, fontM, fontR),

          // ── PAGE BODY ──────────────────────────────────────
          pw.Expanded(
            child: pw.Container(
              color: _gray100,
              child: pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(28, 18, 28, 18),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [

                    // ── RINGKASAN PROFIL ──────────────────────
                    _sectionHeader('RINGKASAN PROFIL', _blue, fontB),
                    pw.SizedBox(height: 8),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(14),
                      decoration: pw.BoxDecoration(
                        color: _white,
                        borderRadius: pw.BorderRadius.circular(8),
                        border: pw.Border(
                            left: pw.BorderSide(color: _blue, width: 4)),
                      ),
                      child: pw.Text(
                        'Software Engineer dan Sarjana Terapan Teknik (S.Tr.T.) Program Studi D4 Teknologi Rekayasa Komputer Jaringan (TRKJ), Jurusan Teknologi Informasi dan Komputer (TIK) Politeknik Negeri Lhokseumawe. Spesialis dalam rekayasa aplikasi mobile Flutter cross-platform (Dart & BLoC), sistem siber-fisik IoT CPS berbasis 7 Lapisan OSI & MQTT/TLS, kecerdasan buatan (Rule-Based Decision Systems & AI Studio), serta pengembangan sistem informasi web akademik terintegrasi.',
                        style: pw.TextStyle(font: fontR, fontSize: 9.5,
                            color: _gray800, lineSpacing: 1.6),
                      ),
                    ),
                    pw.SizedBox(height: 16),

                    // ── PENDIDIKAN FORMAL ─────────────────────
                    _sectionHeader('PENDIDIKAN FORMAL', _purple, fontB),
                    pw.SizedBox(height: 8),
                    _educationCard(fontB, fontM, fontR),
                    pw.SizedBox(height: 16),

                    // ── KEAHLIAN (2 KOLOM) ────────────────────
                    _sectionHeader('KEAHLIAN UTAMA & SPESIALISASI', _blue, fontB),
                    pw.SizedBox(height: 8),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Kiri: Progress Bars
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(14),
                            decoration: pw.BoxDecoration(
                              color: _white,
                              borderRadius: pw.BorderRadius.circular(8),
                              border: pw.Border(
                                  left: pw.BorderSide(color: _blue, width: 4)),
                            ),
                            child: pw.Column(children: [
                              _skillBar('Mobile Dev — Flutter & Dart', 0.95, _blue, fontM, fontR),
                              pw.SizedBox(height: 8),
                              _skillBar('IoT & Networking — 7 OSI Layer', 0.92, _cyan, fontM, fontR),
                              pw.SizedBox(height: 8),
                              _skillBar('AI & Decision Systems', 0.90, _purple, fontM, fontR),
                              pw.SizedBox(height: 8),
                              _skillBar('Web Development', 0.85, _green, fontM, fontR),
                              pw.SizedBox(height: 8),
                              _skillBar('Tools & Administration', 0.88, _orange, fontM, fontR),
                            ]),
                          ),
                        ),
                        pw.SizedBox(width: 12),
                        // Kanan: Spesialisasi
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(14),
                            decoration: pw.BoxDecoration(
                              color: _white,
                              borderRadius: pw.BorderRadius.circular(8),
                              border: pw.Border(
                                  left: pw.BorderSide(color: _cyan, width: 4)),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _specRow('Flutter & Dart', 'Cross-Platform Mobile & Web (60 FPS)', _blue, fontB, fontR),
                                pw.SizedBox(height: 7),
                                _specRow('BLoC Pattern', 'Reactive State Management', _cyan, fontB, fontR),
                                pw.SizedBox(height: 7),
                                _specRow('IoT CPS', 'ESP32 / ESP8266, MQTT/TLS, VLAN', _green, fontB, fontR),
                                pw.SizedBox(height: 7),
                                _specRow('AI / Rule-Based', 'Decision System & Google AI Studio', _purple, fontB, fontR),
                                pw.SizedBox(height: 7),
                                _specRow('Web Dev', 'Laravel, MySQL, HTML/CSS, PHP', _orange, fontB, fontR),
                                pw.SizedBox(height: 7),
                                _specRow('Tools', 'Figma, VS Code, Git/GitHub, MS Office', _gray500, fontB, fontR),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── PAGE 1 FOOTER ───────────────────────────────────
          _pageFooter(fontR, 1, 2),
        ],
      ),
    ));

    // ═══════════════════════════════════════════════════════════
    // PAGE 2 — Projects + Achievements + Certification
    // ═══════════════════════════════════════════════════════════
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      theme: pw.ThemeData.withFont(base: fontR, bold: fontB),
      build: (ctx) => pw.Column(
        children: [
          // ── PAGE 2 MINI HEADER ──────────────────────────────
          pw.Container(
            decoration: const pw.BoxDecoration(
              gradient: pw.LinearGradient(
                colors: [_navy, _blueD],
                begin: pw.Alignment.centerLeft,
                end: pw.Alignment.centerRight,
              ),
            ),
            padding: const pw.EdgeInsets.fromLTRB(28, 12, 28, 12),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('NAZARUL QUDRI, S.Tr.T.',
                    style: pw.TextStyle(font: fontB, fontSize: 13,
                        color: _white, letterSpacing: 0.8)),
                pw.Text('Curriculum Vitae — Halaman 2',
                    style: pw.TextStyle(font: fontR, fontSize: 9,
                        color: PdfColor.fromInt(0xFF93C5FD))),
              ],
            ),
          ),

          pw.Expanded(
            child: pw.Container(
              color: _gray100,
              child: pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(28, 18, 28, 18),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [

                    // ── PROYEK REKAYASA ───────────────────────
                    _sectionHeader('PROYEK REKAYASA UNGGULAN', _blue, fontB),
                    pw.SizedBox(height: 8),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(child: pw.Column(children: [
                          _projectCard(
                            no: '1', color: _blue,
                            title: 'STARZAR — Smart Exclusive Home IoT & AI',
                            role: 'Ketua / Peneliti Utama',
                            period: '2024 – 2026',
                            desc: 'Sistem siber-fisik Smart Home berbasis ESP32, 7 OSI Layer, MQTT HiveMQ, dan Rule-Based Artificial Intelligence. Latensi 180ms, Packet Loss 0%.',
                            tags: ['Flutter', 'ESP32', 'MQTT/TLS', 'Rule-Based AI'],
                            fontB: fontB, fontM: fontM, fontR: fontR,
                          ),
                          pw.SizedBox(height: 8),
                          _projectCard(
                            no: '2', color: _cyan,
                            title: 'Sistem Informasi & Pendaftaran Kuliah Umum',
                            role: 'Full-Stack Developer',
                            period: '2025 – 2026',
                            desc: 'Portal web pendaftaran, registrasi peserta, absensi QR Code digital, dan pengelolaan agenda kuliah bagi 1.000+ mahasiswa Jurusan TIK PNL.',
                            tags: ['Laravel', 'MySQL', 'QR Absensi', 'Web Portal'],
                            fontB: fontB, fontM: fontM, fontR: fontR,
                          ),
                        ])),
                        pw.SizedBox(width: 10),
                        pw.Expanded(child: pw.Column(children: [
                          _projectCard(
                            no: '3', color: _purple,
                            title: 'Sistem Informasi Sertifikat Dosen PNL',
                            role: 'Backend Developer',
                            period: '2025 – 2026',
                            desc: 'Repositori digital terpusat untuk pengarsipan, pencarian, dan verifikasi sertifikat kompetensi seluruh dosen — mendukung BKD & akreditasi jurusan.',
                            tags: ['Web System', 'Document Repo', 'Security Auth'],
                            fontB: fontB, fontM: fontM, fontR: fontR,
                          ),
                          pw.SizedBox(height: 8),
                          _projectCard(
                            no: '4', color: _green,
                            title: 'Sistem Informasi Sertifikat Mahasiswa/i TIK',
                            role: 'Full-Stack Developer',
                            period: '2025 – 2026',
                            desc: 'Platform penerbitan e-sertifikat digital, validasi SKPI, dan manajemen dokumen akademik mahasiswa Jurusan TIK PNL secara terintegrasi.',
                            tags: ['E-Sertifikat', 'SKPI Digital', 'Web App'],
                            fontB: fontB, fontM: fontM, fontR: fontR,
                          ),
                        ])),
                      ],
                    ),
                    pw.SizedBox(height: 16),

                    // ── PRESTASI & SERTIFIKASI (2 KOLOM) ─────
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Prestasi Nasional
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              _sectionHeader('PRESTASI NASIONAL', _orange, fontB),
                              pw.SizedBox(height: 8),
                              pw.Container(
                                padding: const pw.EdgeInsets.all(14),
                                decoration: pw.BoxDecoration(
                                  color: _white,
                                  borderRadius: pw.BorderRadius.circular(8),
                                  border: pw.Border(
                                      left: pw.BorderSide(
                                          color: _orange, width: 4)),
                                ),
                                child: pw.Column(children: [
                                  _achieveRow('1', 'Finalis Inovasi Perangkat Lunak',
                                      'KMIPN VI 2025 — Politeknik Nasional', _orange, fontB, fontR),
                                  pw.SizedBox(height: 8),
                                  _achieveRow('2', 'Medali Nasional NSO 5',
                                      'National Science Olympiad — Bidang Bahasa Inggris', _orange, fontB, fontR),
                                  pw.SizedBox(height: 8),
                                  _achieveRow('3', 'Medali Nasional OSPN',
                                      'Olimpiade Sains — Akuntansi & Logika Kuantitatif', _orange, fontB, fontR),
                                  pw.SizedBox(height: 8),
                                  _achieveRow('4', 'Medali Nasional OSH 2025',
                                      'Olimpiade Sains — Bidang Bahasa Indonesia', _orange, fontB, fontR),
                                ]),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(width: 12),
                        // Sertifikasi
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              _sectionHeader('SERTIFIKASI KOMINFO DTS', _green, fontB),
                              pw.SizedBox(height: 8),
                              pw.Container(
                                padding: const pw.EdgeInsets.all(14),
                                decoration: pw.BoxDecoration(
                                  color: _white,
                                  borderRadius: pw.BorderRadius.circular(8),
                                  border: pw.Border(
                                      left: pw.BorderSide(
                                          color: _green, width: 4)),
                                ),
                                child: pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Row(children: [
                                      pw.Container(
                                        width: 44, height: 44,
                                        decoration: pw.BoxDecoration(
                                          gradient: const pw.LinearGradient(
                                              colors: [_green,
                                                PdfColor.fromInt(0xFF34D399)]),
                                          shape: pw.BoxShape.circle,
                                        ),
                                        alignment: pw.Alignment.center,
                                        child: pw.Text('11',
                                            style: pw.TextStyle(
                                                font: fontEB, fontSize: 16,
                                                color: _white)),
                                      ),
                                      pw.SizedBox(width: 12),
                                      pw.Expanded(child: pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text('Sertifikasi Resmi',
                                              style: pw.TextStyle(
                                                  font: fontB, fontSize: 10,
                                                  color: _gray800)),
                                          pw.Text('Terverifikasi Kemenkominfo RI',
                                              style: pw.TextStyle(
                                                  font: fontM, fontSize: 8.5,
                                                  color: _green)),
                                        ],
                                      )),
                                    ]),
                                    pw.SizedBox(height: 10),
                                    pw.Container(
                                      height: 0.8, color: _gray200),
                                    pw.SizedBox(height: 10),
                                    pw.Text(
                                      'Digital Talent Scholarship (DTS)\nKementerian Komunikasi dan Informatika\nRepublik Indonesia — 2024 s.d. 2025',
                                      style: pw.TextStyle(font: fontR,
                                          fontSize: 9, color: _gray500,
                                          lineSpacing: 1.4),
                                    ),
                                    pw.SizedBox(height: 8),
                                    pw.Text(
                                      'Bidang kompetensi: Flutter Development, IoT Systems, Web Development, AI/ML, Cybersecurity, Data Analytics, Cloud Computing, Digital Marketing, Microsoft Office & tools produktivitas profesional.',
                                      style: pw.TextStyle(font: fontR,
                                          fontSize: 8.5, color: _gray500,
                                          lineSpacing: 1.4),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── PAGE 2 FOOTER ───────────────────────────────────
          _pageFooter(fontR, 2, 2),
        ],
      ),
    ));

    return pdf.save();
  }

  // ════════════════════════════════════════════════════════════
  // GRADIENT HEADER (Page 1)
  // ════════════════════════════════════════════════════════════
  static pw.Widget _buildGradientHeader(
      pw.Font eb, pw.Font b, pw.Font m, pw.Font r) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_navy, _blueD, _blue],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.fromLTRB(28, 22, 28, 18),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Name + Contact Row
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('NAZARUL QUDRI, S.Tr.T.',
                      style: pw.TextStyle(font: eb, fontSize: 24,
                          color: _white, letterSpacing: 1.5)),
                  pw.SizedBox(height: 4),
                  pw.Text(
                      'Flutter Developer  •  IoT CPS Specialist  •  AI Engineer',
                      style: pw.TextStyle(font: m, fontSize: 10.5,
                          color: PdfColor.fromInt(0xFFBAE6FD))),
                  pw.SizedBox(height: 2),
                  pw.Text(
                      'D4 Teknologi Rekayasa Komputer Jaringan — Politeknik Negeri Lhokseumawe',
                      style: pw.TextStyle(font: r, fontSize: 9,
                          color: PdfColor.fromInt(0xFF93C5FD))),
                ],
              ),
              pw.SizedBox(width: 24),
              pw.Container(
                padding: const pw.EdgeInsets.all(12),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromInt(0x22FFFFFF),
                  borderRadius: pw.BorderRadius.circular(10),
                  border: pw.Border.all(
                      color: PdfColor.fromInt(0x44FFFFFF), width: 0.8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _contactRow('Email', 'zarqud@gmail.com', r, m),
                    pw.SizedBox(height: 4),
                    _contactRow('GitHub', 'github.com/nazarulqudritrkj', r, m),
                    pw.SizedBox(height: 4),
                    _contactRow('LinkedIn',
                        'linkedin.com/in/nazarul-qudri-62178824a', r, m),
                    pw.SizedBox(height: 4),
                    _contactRow('Lokasi',
                        'Lhokseumawe, Aceh, Indonesia', r, m),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 14),
          pw.Container(
              height: 0.8,
              color: PdfColor.fromInt(0x44FFFFFF),
              margin: const pw.EdgeInsets.only(bottom: 10)),
          // Chips
          pw.Row(children: [
            _chip('Cum Laude Graduate', _green, m),
            pw.SizedBox(width: 6),
            _chip('Tersedia untuk Kolaborasi', _cyan, m),
            pw.SizedBox(width: 6),
            _chip('4+ Tahun Pengalaman', _blue, m),
            pw.SizedBox(width: 6),
            _chip('11 Sertifikasi Kominfo DTS', _orange, m),
          ]),
        ],
      ),
    );
  }

  static pw.Widget _contactRow(
      String label, String value, pw.Font r, pw.Font m) {
    return pw.Row(children: [
      pw.SizedBox(
        width: 52,
        child: pw.Text(label,
            style: pw.TextStyle(font: m, fontSize: 8,
                color: PdfColor.fromInt(0xFF7DD3FC))),
      ),
      pw.Text(':  ',
          style: pw.TextStyle(font: r, fontSize: 8,
              color: PdfColor.fromInt(0xFF7DD3FC))),
      pw.Text(value,
          style: pw.TextStyle(font: r, fontSize: 8,
              color: PdfColor.fromInt(0xFFCBD5E1))),
    ]);
  }

  static pw.Widget _chip(String t, PdfColor c, pw.Font m) =>
      pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: pw.BoxDecoration(
          color: c.shade(0.2),
          borderRadius: pw.BorderRadius.circular(20),
          border: pw.Border.all(color: c, width: 0.7),
        ),
        child: pw.Text(t,
            style: pw.TextStyle(font: m, fontSize: 8, color: c)),
      );

  // ════════════════════════════════════════════════════════════
  // SECTION HEADER
  // ════════════════════════════════════════════════════════════
  static pw.Widget _sectionHeader(
      String title, PdfColor color, pw.Font fontB) {
    return pw.Row(children: [
      pw.Container(width: 4, height: 16, color: color,
          decoration: pw.BoxDecoration(
              borderRadius: pw.BorderRadius.circular(2))),
      pw.SizedBox(width: 8),
      pw.Text(title,
          style: pw.TextStyle(font: fontB, fontSize: 10,
              color: _gray800, letterSpacing: 0.6)),
      pw.SizedBox(width: 10),
      pw.Expanded(child: pw.Container(height: 0.8, color: _gray200)),
    ]);
  }

  // ════════════════════════════════════════════════════════════
  // EDUCATION CARD
  // ════════════════════════════════════════════════════════════
  static pw.Widget _educationCard(pw.Font b, pw.Font m, pw.Font r) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: _white,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border(left: pw.BorderSide(color: _purple, width: 4)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Institution Row
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'D4 Teknologi Rekayasa Komputer Jaringan (TRKJ)',
                    style: pw.TextStyle(font: b, fontSize: 10, color: _gray800),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Text(
                    'Politeknik Negeri Lhokseumawe (PNL)  •  Jurusan Teknologi Informasi dan Komputer (TIK)',
                    style: pw.TextStyle(font: m, fontSize: 9, color: _purple),
                  ),
                ],
              )),
              pw.SizedBox(width: 10),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: pw.BoxDecoration(
                  gradient: const pw.LinearGradient(
                      colors: [_purple,
                        PdfColor.fromInt(0xFF9333EA)]),
                  borderRadius: pw.BorderRadius.circular(12),
                ),
                child: pw.Text('2022 – 2026',
                    style: pw.TextStyle(
                        font: b, fontSize: 8.5, color: _white)),
              ),
            ],
          ),
          pw.SizedBox(height: 10),
          pw.Container(height: 0.8, color: _gray200),
          pw.SizedBox(height: 10),
          // Info Grid
          pw.Row(children: [
            pw.Expanded(child: pw.Column(children: [
              _infoRow('Gelar Akademis',
                  'Sarjana Terapan Teknik (S.Tr.T.)', b, r),
              pw.SizedBox(height: 5),
              _infoRow('Predikat Kelulusan',
                  'Cum Laude', b, r, valueColor: _green),
            ])),
            pw.SizedBox(width: 16),
            pw.Expanded(child: pw.Column(children: [
              _infoRow('Tanggal Lulus', '29 Juli 2026', b, r),
              pw.SizedBox(height: 5),
              _infoRow('Pembimbing I',
                  'Husaini, S.Si., M.I.T.', b, r),
            ])),
          ]),
          pw.SizedBox(height: 10),
          pw.Container(
            padding: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              color: _purpleL,
              borderRadius: pw.BorderRadius.circular(6),
              border: pw.Border.all(
                  color: PdfColor.fromInt(0xFFDDD6FE), width: 0.8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('TUGAS AKHIR / SKRIPSI',
                    style: pw.TextStyle(font: b, fontSize: 8,
                        color: _purple, letterSpacing: 0.5)),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Rancang Bangun IoT pada Prototype Smart Home dengan Penerapan Rule-Based Decision System sebagai Artificial Intelligence (Aplikasi STARZAR — Implementasi Lengkap 7 OSI Layer & MQTT HiveMQ)',
                  style: pw.TextStyle(font: r, fontSize: 9,
                      color: _gray800, lineSpacing: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _infoRow(String label, String value, pw.Font b, pw.Font r,
      {PdfColor? valueColor}) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(width: 100,
            child: pw.Text(label,
                style: pw.TextStyle(font: b, fontSize: 8.5,
                    color: _gray500))),
        pw.Text(':  ',
            style: pw.TextStyle(font: b, fontSize: 8.5, color: _gray500)),
        pw.Expanded(child: pw.Text(value,
            style: pw.TextStyle(font: b, fontSize: 8.5,
                color: valueColor ?? _gray800))),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // SKILL BAR
  // ════════════════════════════════════════════════════════════
  static pw.Widget _skillBar(
      String name, double pct, PdfColor color, pw.Font m, pw.Font r) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(name,
                style: pw.TextStyle(font: m, fontSize: 9, color: _gray800)),
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: pw.BoxDecoration(
                color: color.shade(0.15),
                borderRadius: pw.BorderRadius.circular(10),
              ),
              child: pw.Text('${(pct * 100).toInt()}%',
                  style: pw.TextStyle(font: m, fontSize: 8, color: color)),
            ),
          ],
        ),
        pw.SizedBox(height: 4),
        pw.Stack(children: [
          pw.Container(
            height: 7,
            decoration: pw.BoxDecoration(
              color: _gray200,
              borderRadius: pw.BorderRadius.circular(4),
            ),
          ),
          pw.Container(
            height: 7,
            width: 215 * pct,
            decoration: pw.BoxDecoration(
              gradient: pw.LinearGradient(
                  colors: [color, color.shade(0.65)]),
              borderRadius: pw.BorderRadius.circular(4),
            ),
          ),
        ]),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // SPEC ROW
  // ════════════════════════════════════════════════════════════
  static pw.Widget _specRow(
      String title, String desc, PdfColor color,
      pw.Font b, pw.Font r) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 6, height: 6,
          margin: const pw.EdgeInsets.only(top: 3, right: 7),
          decoration: pw.BoxDecoration(
              color: color, shape: pw.BoxShape.circle),
        ),
        pw.Expanded(child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(title,
                style: pw.TextStyle(font: b, fontSize: 9, color: _gray800)),
            pw.Text(desc,
                style: pw.TextStyle(font: r, fontSize: 8.5, color: _gray500)),
          ],
        )),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // PROJECT CARD
  // ════════════════════════════════════════════════════════════
  static pw.Widget _projectCard({
    required String no,
    required PdfColor color,
    required String title,
    required String role,
    required String period,
    required String desc,
    required List<String> tags,
    required pw.Font fontB,
    required pw.Font fontM,
    required pw.Font fontR,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: _white,
        borderRadius: pw.BorderRadius.circular(8),
        border: pw.Border(left: pw.BorderSide(color: color, width: 4)),
        boxShadow: [
          pw.BoxShadow(
            color: PdfColor.fromInt(0x0A000000),
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
                width: 22, height: 22,
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(
                      colors: [color, color.shade(0.7)]),
                  shape: pw.BoxShape.circle,
                ),
                alignment: pw.Alignment.center,
                child: pw.Text(no,
                    style: pw.TextStyle(
                        font: fontB, fontSize: 10, color: _white)),
              ),
              pw.SizedBox(width: 8),
              pw.Expanded(child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(title,
                      style: pw.TextStyle(
                          font: fontB, fontSize: 9, color: _gray800)),
                  pw.Row(children: [
                    pw.Text(role,
                        style: pw.TextStyle(
                            font: fontM, fontSize: 8, color: color)),
                    pw.Text('  •  ',
                        style: pw.TextStyle(
                            font: fontR, fontSize: 8, color: _gray500)),
                    pw.Text(period,
                        style: pw.TextStyle(
                            font: fontM, fontSize: 8, color: _gray500)),
                  ]),
                ],
              )),
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Text(desc,
              style: pw.TextStyle(font: fontR, fontSize: 8.5,
                  color: _gray500, lineSpacing: 1.4)),
          pw.SizedBox(height: 6),
          pw.Wrap(spacing: 4, runSpacing: 3,
            children: tags.map((t) => pw.Container(
              padding: const pw.EdgeInsets.symmetric(
                  horizontal: 7, vertical: 2.5),
              decoration: pw.BoxDecoration(
                color: color.shade(0.1),
                borderRadius: pw.BorderRadius.circular(10),
                border: pw.Border.all(
                    color: color.shade(0.4), width: 0.6),
              ),
              child: pw.Text(t,
                  style: pw.TextStyle(
                      font: fontM, fontSize: 8, color: color)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  // ACHIEVEMENT ROW
  // ════════════════════════════════════════════════════════════
  static pw.Widget _achieveRow(
      String no, String title, String sub,
      PdfColor color, pw.Font b, pw.Font r) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 20, height: 20,
          decoration: pw.BoxDecoration(
            color: color.shade(0.15), shape: pw.BoxShape.circle),
          alignment: pw.Alignment.center,
          child: pw.Text(no,
              style: pw.TextStyle(font: b, fontSize: 9, color: color)),
        ),
        pw.SizedBox(width: 8),
        pw.Expanded(child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(title,
                style: pw.TextStyle(font: b, fontSize: 9, color: _gray800)),
            pw.Text(sub,
                style: pw.TextStyle(font: r, fontSize: 8.5, color: _gray500)),
          ],
        )),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // PAGE FOOTER
  // ════════════════════════════════════════════════════════════
  static pw.Widget _pageFooter(pw.Font r, int page, int total) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_navy, _blueD],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 28, vertical: 9),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            '© 2026 Nazarul Qudri, S.Tr.T.  •  Terlindungi UU ITE  •  Portofolio Resmi S.Tr.T.',
            style: pw.TextStyle(font: r, fontSize: 8,
                color: PdfColor.fromInt(0xFF93C5FD)),
          ),
          pw.Text(
            'Halaman $page dari $total  •  nazarulqudritrkj.github.io',
            style: pw.TextStyle(font: r, fontSize: 8,
                color: PdfColor.fromInt(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}
