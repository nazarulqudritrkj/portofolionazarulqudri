// ignore_for_file: depend_on_referenced_packages
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Professional CV PDF Generator — Nazarul Qudri, S.Tr.T.
/// Bilingual support: Indonesian (default) & English
/// Clickable Portfolio Link embedded in Header and Footers
class CvPdfGenerator {
  // Official Portfolio URL
  static const String portfolioUrl = 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/';
  static const String portfolioDisplay = 'nazarulqudritrkj.github.io/portofolionazarulqudri';

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

  static Future<Uint8List> generate({bool isEnglish = false}) async {
    final pdf = pw.Document(
      title: isEnglish
          ? 'CV — Nazarul Qudri, S.Tr.T. (Bachelor of Applied Engineering)'
          : 'CV — Nazarul Qudri, S.Tr.T. (Sarjana Terapan Teknik)',
      author: 'Nazarul Qudri, S.Tr.T.',
      subject: isEnglish
          ? 'Official Curriculum Vitae — Bachelor of Applied Engineering'
          : 'Curriculum Vitae Resmi — Sarjana Terapan Teknik',
      creator: 'Politeknik Negeri Lhokseumawe — Jurusan TIK',
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
          _buildGradientHeader(fontEB, fontB, fontM, fontR, isEnglish),

          // ── PAGE BODY ──────────────────────────────────────
          pw.Expanded(
            child: pw.Container(
              color: _gray100,
              child: pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(28, 16, 28, 16),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [

                    // ── RINGKASAN PROFIL ──────────────────────
                    _sectionHeader(
                      isEnglish ? 'EXECUTIVE PROFILE SUMMARY' : 'RINGKASAN PROFIL EKSEKUTIF',
                      _blue, fontB,
                    ),
                    pw.SizedBox(height: 7),
                    pw.Container(
                      padding: const pw.EdgeInsets.all(13),
                      decoration: pw.BoxDecoration(
                        color: _white,
                        borderRadius: pw.BorderRadius.circular(8),
                        border: pw.Border(left: pw.BorderSide(color: _blue, width: 4)),
                      ),
                      child: pw.Text(
                        isEnglish
                            ? 'Software Engineer and Bachelor of Applied Engineering (S.Tr.T.) graduate in Computer Network Engineering Technology (D4 TRKJ), Department of Information and Computer Technology (TIK), Politeknik Negeri Lhokseumawe (Cum Laude). Specialized in cross-platform Flutter mobile applications (Reactive BLoC architecture), cyber-physical systems (IoT CPS) with complete 7-Layer OSI network model & MQTT HiveMQ Cloud, applied artificial intelligence (Rule-Based Decision Systems & Google AI Studio), and integrated enterprise academic web portals.'
                            : 'Software Engineer dan Sarjana Terapan Teknik (S.Tr.T.) Program Studi D4 Teknologi Rekayasa Komputer Jaringan (TRKJ), Jurusan Teknologi Informasi dan Komputer (TIK) Politeknik Negeri Lhokseumawe (Cum Laude). Spesialis dalam rekayasa aplikasi mobile Flutter cross-platform (Reactive BLoC), sistem siber-fisik IoT CPS berbasis 7 Lapisan OSI & MQTT HiveMQ Cloud, kecerdasan buatan (Rule-Based Decision Systems & AI Studio), serta pengembangan sistem informasi web akademik terintegrasi.',
                        style: pw.TextStyle(font: fontR, fontSize: 9.3, color: _gray800, lineSpacing: 1.55),
                      ),
                    ),
                    pw.SizedBox(height: 14),

                    // ── PENDIDIKAN FORMAL ─────────────────────
                    _sectionHeader(
                      isEnglish ? 'FORMAL EDUCATION & THESIS' : 'PENDIDIKAN FORMAL & SKRIPSI',
                      _purple, fontB,
                    ),
                    pw.SizedBox(height: 7),
                    _educationCard(fontB, fontM, fontR, isEnglish),
                    pw.SizedBox(height: 14),

                    // ── KEAHLIAN (2 KOLOM) ────────────────────
                    _sectionHeader(
                      isEnglish ? 'TECHNICAL COMPETENCIES & SPECIALIZATION' : 'KEAHLIAN UTAMA & SPESIALISASI',
                      _blue, fontB,
                    ),
                    pw.SizedBox(height: 7),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Kiri: Progress Bars
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(12),
                            decoration: pw.BoxDecoration(
                              color: _white,
                              borderRadius: pw.BorderRadius.circular(8),
                              border: pw.Border(left: pw.BorderSide(color: _blue, width: 4)),
                            ),
                            child: pw.Column(children: [
                              _skillBar('Mobile Dev — Flutter & Dart', 0.95, _blue, fontM, fontR),
                              pw.SizedBox(height: 7),
                              _skillBar('IoT & Networking — 7 OSI Layer', 0.92, _cyan, fontM, fontR),
                              pw.SizedBox(height: 7),
                              _skillBar('AI & Decision Systems', 0.90, _purple, fontM, fontR),
                              pw.SizedBox(height: 7),
                              _skillBar('Web Development (Laravel/PHP)', 0.85, _green, fontM, fontR),
                              pw.SizedBox(height: 7),
                              _skillBar('Tools & Administration', 0.88, _orange, fontM, fontR),
                            ]),
                          ),
                        ),
                        pw.SizedBox(width: 12),
                        // Kanan: Spesialisasi
                        pw.Expanded(
                          child: pw.Container(
                            padding: const pw.EdgeInsets.all(12),
                            decoration: pw.BoxDecoration(
                              color: _white,
                              borderRadius: pw.BorderRadius.circular(8),
                              border: pw.Border(left: pw.BorderSide(color: _cyan, width: 4)),
                            ),
                            child: pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                _specRow('Flutter & Dart', isEnglish ? 'Cross-Platform Mobile & Web (60 FPS)' : 'Aplikasi Mobile & Web Cross-Platform (60 FPS)', _blue, fontB, fontR),
                                pw.SizedBox(height: 6),
                                _specRow('BLoC Pattern', isEnglish ? 'Reactive State Management Architecture' : 'Manajemen State Terstruktur & Reaktif', _cyan, fontB, fontR),
                                pw.SizedBox(height: 6),
                                _specRow('IoT CPS', isEnglish ? 'ESP32, MQTT/TLS, 7 OSI Layer, Telemetry' : 'ESP32, MQTT/TLS, 7 Lapisan OSI, Sensor Cerdas', _green, fontB, fontR),
                                pw.SizedBox(height: 6),
                                _specRow('Applied AI', isEnglish ? 'Rule-Based Decision Systems & AI Studio' : 'Forward Chaining Decision Engine & AI Studio', _purple, fontB, fontR),
                                pw.SizedBox(height: 6),
                                _specRow('Web Stack', isEnglish ? 'Laravel, MySQL, REST API, HTML/CSS' : 'Laravel, MySQL, REST API, PHP, QR Validation', _orange, fontB, fontR),
                                pw.SizedBox(height: 6),
                                _specRow('Workflows', isEnglish ? 'Figma UI/UX, Git/GitHub, MS Office Suite' : 'Figma UI/UX, Git/GitHub, VS Code, MS Office', _gray500, fontB, fontR),
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
          _pageFooter(fontR, 1, 2, isEnglish),
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
                    style: pw.TextStyle(font: fontB, fontSize: 13, color: _white, letterSpacing: 0.8)),
                pw.Row(
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text(
                      isEnglish ? 'Curriculum Vitae — Page 2  •  ' : 'Curriculum Vitae — Halaman 2  •  ',
                      style: pw.TextStyle(font: fontR, fontSize: 9, color: PdfColor.fromInt(0xFF93C5FD)),
                    ),
                    pw.UrlLink(
                      destination: portfolioUrl,
                      child: pw.Text(
                        portfolioDisplay,
                        style: pw.TextStyle(
                          font: fontR,
                          fontSize: 8.5,
                          color: PdfColor.fromInt(0xFF7DD3FC),
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          pw.Expanded(
            child: pw.Container(
              color: _gray100,
              child: pw.Padding(
                padding: const pw.EdgeInsets.fromLTRB(28, 16, 28, 16),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [

                    // ── PROYEK REKAYASA ───────────────────────
                    _sectionHeader(
                      isEnglish ? 'FEATURED ENGINEERING HIGHLIGHTS' : 'PROYEK REKAYASA UNGGULAN',
                      _blue, fontB,
                    ),
                    pw.SizedBox(height: 7),
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(child: pw.Column(children: [
                          _projectCard(
                            no: '1', color: _blue,
                            title: 'STARZAR — Smart Exclusive Home IoT & AI',
                            role: isEnglish ? 'Lead Engineer / Researcher' : 'Ketua / Peneliti Utama',
                            period: '2024 – 2026',
                            desc: isEnglish
                                ? 'Cyber-Physical System smart home powered by ESP32, full 7-Layer OSI model, HiveMQ MQTT, and Rule-Based AI. 180ms latency, 0% Packet Loss.'
                                : 'Sistem siber-fisik Smart Home berbasis ESP32, 7 OSI Layer, MQTT HiveMQ, dan Rule-Based Artificial Intelligence. Latensi 180ms, Packet Loss 0%.',
                            tags: ['Flutter', 'ESP32', '7 OSI Layer', 'Rule-Based AI'],
                            fontB: fontB, fontM: fontM, fontR: fontR,
                          ),
                          pw.SizedBox(height: 7),
                          _projectCard(
                            no: '2', color: _cyan,
                            title: isEnglish
                                ? 'TIK PNL Public Lecture & Registration Web'
                                : 'Sistem Informasi & Pendaftaran Kuliah Umum',
                            role: 'Full-Stack Developer',
                            period: '2025 – 2026',
                            desc: isEnglish
                                ? 'Web portal for student registration, digital QR attendance, and event management for 1,000+ students at TIK PNL.'
                                : 'Portal web pendaftaran, registrasi peserta, absensi QR Code digital, dan pengelolaan agenda kuliah bagi 1.000+ mahasiswa Jurusan TIK PNL.',
                            tags: ['Laravel', 'MySQL', 'QR Absensi', 'Web Portal'],
                            fontB: fontB, fontM: fontM, fontR: fontR,
                          ),
                        ])),
                        pw.SizedBox(width: 10),
                        pw.Expanded(child: pw.Column(children: [
                          _projectCard(
                            no: '3', color: _purple,
                            title: isEnglish
                                ? 'PNL Faculty Certificate Repository System'
                                : 'Sistem Informasi Sertifikat Dosen PNL',
                            role: 'Full-Stack Developer',
                            period: '2025 – 2026',
                            desc: isEnglish
                                ? 'Centralized digital vault for indexing, verifying, and managing faculty competency certifications — supporting BKD & accreditation.'
                                : 'Repositori digital terpusat untuk pengarsipan, pencarian, dan verifikasi sertifikat kompetensi seluruh dosen — mendukung BKD & akreditasi.',
                            tags: ['Web System', 'Document Repo', 'Security Auth'],
                            fontB: fontB, fontM: fontM, fontR: fontR,
                          ),
                          pw.SizedBox(height: 7),
                          _projectCard(
                            no: '4', color: _green,
                            title: isEnglish
                                ? 'TIK PNL Student Certificate & SKPI Validation'
                                : 'Sistem Informasi Sertifikat Mahasiswa/i TIK',
                            role: 'Full-Stack Developer',
                            period: '2025 – 2026',
                            desc: isEnglish
                                ? 'E-certificate issuance and digital SKPI verification platform with anti-counterfeit QR code validation for TIK students.'
                                : 'Platform penerbitan e-sertifikat digital, validasi SKPI, dan manajemen dokumen akademik mahasiswa Jurusan TIK PNL secara terintegrasi.',
                            tags: ['E-Sertifikat', 'SKPI Digital', 'Web App'],
                            fontB: fontB, fontM: fontM, fontR: fontR,
                          ),
                        ])),
                      ],
                    ),
                    pw.SizedBox(height: 14),

                    // ── PRESTASI & SERTIFIKASI (2 KOLOM) ─────
                    pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        // Prestasi Nasional
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              _sectionHeader(
                                isEnglish ? 'NATIONAL HONORS & COMPETITIONS' : 'PRESTASI & JUARA LOMBA NASIONAL',
                                _orange, fontB,
                              ),
                              pw.SizedBox(height: 7),
                              pw.Container(
                                padding: const pw.EdgeInsets.all(12),
                                decoration: pw.BoxDecoration(
                                  color: _white,
                                  borderRadius: pw.BorderRadius.circular(8),
                                  border: pw.Border(left: pw.BorderSide(color: _orange, width: 4)),
                                ),
                                child: pw.Column(children: [
                                  _achieveRow(
                                    '1',
                                    isEnglish ? 'Software Innovation Finalist' : 'Finalis Inovasi Perangkat Lunak',
                                    'KMIPN VI 2025 — Politeknik Nasional', _orange, fontB, fontR,
                                  ),
                                  pw.SizedBox(height: 7),
                                  _achieveRow(
                                    '2',
                                    isEnglish ? 'National Medal Winner NSO 5' : 'Medali Nasional NSO 5',
                                    isEnglish ? 'National Science Olympiad — English Language' : 'National Science Olympiad — Bidang Bahasa Inggris',
                                    _orange, fontB, fontR,
                                  ),
                                  pw.SizedBox(height: 7),
                                  _achieveRow(
                                    '3',
                                    isEnglish ? 'National Medal Winner OSPN' : 'Medali Nasional OSPN',
                                    isEnglish ? 'Science Olympiad — Accounting & Logic' : 'Olimpiade Sains — Akuntansi & Logika Kuantitatif',
                                    _orange, fontB, fontR,
                                  ),
                                  pw.SizedBox(height: 7),
                                  _achieveRow(
                                    '4',
                                    isEnglish ? 'National Medal Winner OSH 2025' : 'Medali Nasional OSH 2025',
                                    isEnglish ? 'Science Olympiad — Indonesian Language' : 'Olimpiade Sains — Bidang Bahasa Indonesia',
                                    _orange, fontB, fontR,
                                  ),
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
                              _sectionHeader(
                                isEnglish ? '11x KOMINFO DTS CERTIFICATIONS' : '11 SERTIFIKASI KOMINFO DTS',
                                _green, fontB,
                              ),
                              pw.SizedBox(height: 7),
                              pw.Container(
                                padding: const pw.EdgeInsets.all(12),
                                decoration: pw.BoxDecoration(
                                  color: _white,
                                  borderRadius: pw.BorderRadius.circular(8),
                                  border: pw.Border(left: pw.BorderSide(color: _green, width: 4)),
                                ),
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Row(children: [
                                      pw.Container(
                                        width: 40, height: 40,
                                        decoration: const pw.BoxDecoration(
                                          gradient: pw.LinearGradient(
                                              colors: [_green, PdfColor.fromInt(0xFF34D399)]),
                                          shape: pw.BoxShape.circle,
                                        ),
                                        alignment: pw.Alignment.center,
                                        child: pw.Text('11',
                                            style: pw.TextStyle(font: fontEB, fontSize: 15, color: _white)),
                                      ),
                                      pw.SizedBox(width: 10),
                                      pw.Expanded(child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(
                                            isEnglish ? '11 Verified Credentials' : '11 Sertifikasi Resmi',
                                            style: pw.TextStyle(font: fontB, fontSize: 9.5, color: _gray800),
                                          ),
                                          pw.Text(
                                            isEnglish ? 'Verified by Ministry of Communications & IT' : 'Terverifikasi Kemenkominfo RI',
                                            style: pw.TextStyle(font: fontM, fontSize: 8, color: _green),
                                          ),
                                        ],
                                      )),
                                    ]),
                                    pw.SizedBox(height: 8),
                                    pw.Container(height: 0.8, color: _gray200),
                                    pw.SizedBox(height: 8),
                                    pw.Text(
                                      isEnglish
                                          ? 'Digital Talent Scholarship (DTS)\nMinistry of Communication and Information Technology\nRepublic of Indonesia — 2024 to 2025'
                                          : 'Digital Talent Scholarship (DTS)\nKementerian Komunikasi dan Informatika\nRepublik Indonesia — 2024 s.d. 2025',
                                      style: pw.TextStyle(font: fontR, fontSize: 8.5, color: _gray500, lineSpacing: 1.35),
                                    ),
                                    pw.SizedBox(height: 6),
                                    pw.Text(
                                      isEnglish
                                          ? 'Domains: Flutter Development, IoT Systems, Web Engineering, AI/ML, Cybersecurity, Cloud Computing, Data Analytics, Digital Marketing, and MS Office Productivity.'
                                          : 'Bidang kompetensi: Flutter Development, IoT Systems, Web Development, AI/ML, Cybersecurity, Data Analytics, Cloud Computing, Digital Marketing, dan tools produktivitas.',
                                      style: pw.TextStyle(font: fontR, fontSize: 8, color: _gray500, lineSpacing: 1.35),
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
          _pageFooter(fontR, 2, 2, isEnglish),
        ],
      ),
    ));

    return pdf.save();
  }

  // ════════════════════════════════════════════════════════════
  // GRADIENT HEADER (Page 1)
  // ════════════════════════════════════════════════════════════
  static pw.Widget _buildGradientHeader(
      pw.Font eb, pw.Font b, pw.Font m, pw.Font r, bool isEnglish) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_navy, _blueD, _blue],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.fromLTRB(28, 16, 28, 14),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Name + Contact Row
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('NAZARUL QUDRI, S.Tr.T.',
                        style: pw.TextStyle(font: eb, fontSize: 21, color: _white, letterSpacing: 1.2)),
                    pw.SizedBox(height: 3),
                    pw.Text(
                      'Software Engineer  •  Flutter Developer  •  IoT CPS Specialist',
                      style: pw.TextStyle(font: m, fontSize: 9.5, color: PdfColor.fromInt(0xFFBAE6FD)),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Text(
                      isEnglish
                          ? 'D4 Computer Network Engineering Technology — Politeknik Negeri Lhokseumawe'
                          : 'D4 Teknologi Rekayasa Komputer Jaringan — Politeknik Negeri Lhokseumawe',
                      style: pw.TextStyle(font: r, fontSize: 8.5, color: PdfColor.fromInt(0xFF93C5FD)),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(width: 14),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                decoration: pw.BoxDecoration(
                  color: PdfColor.fromInt(0x22FFFFFF),
                  borderRadius: pw.BorderRadius.circular(8),
                  border: pw.Border.all(color: PdfColor.fromInt(0x44FFFFFF), width: 0.8),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _contactRow('Email', 'zarqud@gmail.com', r, m),
                    pw.SizedBox(height: 2.5),
                    _contactRow('GitHub', 'github.com/nazarulqudritrkj', r, m),
                    pw.SizedBox(height: 2.5),
                    _contactRow('LinkedIn', 'in/nazarul-qudri-62178824a', r, m),
                    pw.SizedBox(height: 2.5),
                    _contactLinkRow('Web', portfolioDisplay, portfolioUrl, r, m),
                    pw.SizedBox(height: 2.5),
                    _contactRow(isEnglish ? 'Location' : 'Lokasi', 'Lhokseumawe, Aceh, ID', r, m),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 9),
          pw.Container(
              height: 0.8,
              color: PdfColor.fromInt(0x44FFFFFF),
              margin: const pw.EdgeInsets.only(bottom: 7)),
          // Chips (Wrap prevents cutoff at edge)
          pw.Wrap(
            spacing: 6,
            runSpacing: 4,
            children: [
              _chip('Cum Laude Graduate', _green, b),
              _chip(isEnglish ? 'Available for Opportunities' : 'Tersedia untuk Kolaborasi', _cyan, b),
              _chip(isEnglish ? '4+ Years Engineering Experience' : '4+ Tahun Pengalaman Rekayasa', _blueD, b),
              _chip(isEnglish ? '11x Kominfo DTS Certifications' : '11 Sertifikasi Kominfo DTS', _orange, b),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _contactRow(String label, String value, pw.Font r, pw.Font m) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.SizedBox(
          width: 44,
          child: pw.Text(label,
              style: pw.TextStyle(font: m, fontSize: 7.5, color: PdfColor.fromInt(0xFF7DD3FC))),
        ),
        pw.Text(': ', style: pw.TextStyle(font: r, fontSize: 7.5, color: PdfColor.fromInt(0xFF7DD3FC))),
        pw.Text(value, style: pw.TextStyle(font: r, fontSize: 7.5, color: PdfColor.fromInt(0xFFCBD5E1))),
      ],
    );
  }

  static pw.Widget _contactLinkRow(String label, String value, String url, pw.Font r, pw.Font m) {
    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      children: [
        pw.SizedBox(
          width: 44,
          child: pw.Text(label,
              style: pw.TextStyle(font: m, fontSize: 7.5, color: PdfColor.fromInt(0xFF7DD3FC))),
        ),
        pw.Text(': ', style: pw.TextStyle(font: r, fontSize: 7.5, color: PdfColor.fromInt(0xFF7DD3FC))),
        pw.UrlLink(
          destination: url,
          child: pw.Text(
            value,
            style: pw.TextStyle(
              font: r,
              fontSize: 7.5,
              color: PdfColor.fromInt(0xFF93C5FD),
              decoration: pw.TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  static pw.Widget _chip(String t, PdfColor c, pw.Font b) =>
      pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 9, vertical: 3.5),
        decoration: pw.BoxDecoration(
          color: c,
          borderRadius: pw.BorderRadius.circular(4),
          border: pw.Border.all(color: PdfColor.fromInt(0x55FFFFFF), width: 0.8),
        ),
        child: pw.Text(t,
            style: pw.TextStyle(
              font: b,
              fontSize: 7.5,
              color: _white,
              letterSpacing: 0.2,
            )),
      );

  // ════════════════════════════════════════════════════════════
  // SECTION HEADER
  // ════════════════════════════════════════════════════════════
  static pw.Widget _sectionHeader(String title, PdfColor color, pw.Font fontB) {
    return pw.Row(children: [
      pw.Container(width: 4, height: 15, color: color,
          decoration: pw.BoxDecoration(borderRadius: pw.BorderRadius.circular(2))),
      pw.SizedBox(width: 7),
      pw.Text(title,
          style: pw.TextStyle(font: fontB, fontSize: 9.5, color: _gray800, letterSpacing: 0.5)),
      pw.SizedBox(width: 8),
      pw.Expanded(child: pw.Container(height: 0.8, color: _gray200)),
    ]);
  }

  // ════════════════════════════════════════════════════════════
  // EDUCATION CARD
  // ════════════════════════════════════════════════════════════
  static pw.Widget _educationCard(pw.Font b, pw.Font m, pw.Font r, bool isEnglish) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(14),
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
                    isEnglish
                        ? 'D4 Computer Network Engineering Technology (TRKJ)'
                        : 'D4 Teknologi Rekayasa Komputer Jaringan (TRKJ)',
                    style: pw.TextStyle(font: b, fontSize: 10, color: _gray800),
                  ),
                  pw.SizedBox(height: 2),
                  pw.Text(
                    isEnglish
                        ? 'Politeknik Negeri Lhokseumawe (PNL)  •  Department of Information & Computer Technology'
                        : 'Politeknik Negeri Lhokseumawe (PNL)  •  Jurusan Teknologi Informasi dan Komputer (TIK)',
                    style: pw.TextStyle(font: m, fontSize: 8.5, color: _purple),
                  ),
                ],
              )),
              pw.SizedBox(width: 10),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: pw.BoxDecoration(
                  gradient: const pw.LinearGradient(
                      colors: [_purple, PdfColor.fromInt(0xFF9333EA)]),
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Text('2022 – 2026',
                    style: pw.TextStyle(font: b, fontSize: 8, color: _white)),
              ),
            ],
          ),
          pw.SizedBox(height: 8),
          pw.Container(height: 0.8, color: _gray200),
          pw.SizedBox(height: 8),
          // Info Grid
          pw.Row(children: [
            pw.Expanded(child: pw.Column(children: [
              _infoRow(
                isEnglish ? 'Academic Degree' : 'Gelar Akademis',
                'Sarjana Terapan Teknik (S.Tr.T.)', b, r,
              ),
              pw.SizedBox(height: 4),
              _infoRow(
                isEnglish ? 'Graduation Honor' : 'Predikat Kelulusan',
                'Cum Laude', b, r, valueColor: _green,
              ),
            ])),
            pw.SizedBox(width: 16),
            pw.Expanded(child: pw.Column(children: [
              _infoRow(isEnglish ? 'Defense Date' : 'Tanggal Lulus', '29 Juli 2026', b, r),
              pw.SizedBox(height: 4),
              _infoRow(isEnglish ? 'Principal Advisor' : 'Pembimbing I', 'Husaini, S.Si., M.IT.', b, r),
            ])),
          ]),
          pw.SizedBox(height: 8),
          pw.Container(
            padding: const pw.EdgeInsets.all(9),
            decoration: pw.BoxDecoration(
              color: _purpleL,
              borderRadius: pw.BorderRadius.circular(6),
              border: pw.Border.all(color: PdfColor.fromInt(0xFFDDD6FE), width: 0.8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  isEnglish ? 'BACHELOR THESIS / SCIENTIFIC RESEARCH:' : 'TUGAS AKHIR / SKRIPSI ILMIAH:',
                  style: pw.TextStyle(font: b, fontSize: 7.5, color: _purple, letterSpacing: 0.5),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  isEnglish
                      ? '"Design and Construction of IoT Prototype Smart Home with Rule-Based Decision System as Artificial Intelligence" (STARZAR Application — Full 7-Layer OSI Model Implementation & HiveMQ Cloud MQTT)'
                      : '"Rancang Bangun IoT pada Prototype Smart Home dengan Penerapan Rule-Based Decision System sebagai Artificial Intelligence" (Aplikasi STARZAR — Implementasi Lengkap 7 OSI Layer & MQTT HiveMQ)',
                  style: pw.TextStyle(font: r, fontSize: 8.5, color: _gray800, lineSpacing: 1.45),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _infoRow(String label, String value, pw.Font b, pw.Font r, {PdfColor? valueColor}) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(
          width: 95,
          child: pw.Text(label, style: pw.TextStyle(font: b, fontSize: 8, color: _gray500)),
        ),
        pw.Text(':  ', style: pw.TextStyle(font: b, fontSize: 8, color: _gray500)),
        pw.Expanded(
          child: pw.Text(value, style: pw.TextStyle(font: b, fontSize: 8, color: valueColor ?? _gray800)),
        ),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // SKILL BAR
  // ════════════════════════════════════════════════════════════
  static pw.Widget _skillBar(String name, double pct, PdfColor color, pw.Font m, pw.Font r) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(name, style: pw.TextStyle(font: m, fontSize: 8.5, color: _gray800)),
            pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
              decoration: pw.BoxDecoration(
                color: color.shade(0.15),
                borderRadius: pw.BorderRadius.circular(3),
              ),
              child: pw.Text('${(pct * 100).toInt()}%',
                  style: pw.TextStyle(font: m, fontSize: 7.5, color: color)),
            ),
          ],
        ),
        pw.SizedBox(height: 3),
        pw.Stack(children: [
          pw.Container(
            height: 6,
            decoration: pw.BoxDecoration(
              color: _gray200,
              borderRadius: pw.BorderRadius.circular(3),
            ),
          ),
          pw.Container(
            height: 6,
            width: 215 * pct,
            decoration: pw.BoxDecoration(
              gradient: pw.LinearGradient(colors: [color, color.shade(0.65)]),
              borderRadius: pw.BorderRadius.circular(3),
            ),
          ),
        ]),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // SPEC ROW
  // ════════════════════════════════════════════════════════════
  static pw.Widget _specRow(String title, String desc, PdfColor color, pw.Font b, pw.Font r) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: 5, height: 5,
          margin: const pw.EdgeInsets.only(top: 3, right: 6),
          decoration: pw.BoxDecoration(color: color, shape: pw.BoxShape.circle),
        ),
        pw.Expanded(child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(title, style: pw.TextStyle(font: b, fontSize: 8.5, color: _gray800)),
            pw.Text(desc, style: pw.TextStyle(font: r, fontSize: 8, color: _gray500)),
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
      padding: const pw.EdgeInsets.all(11),
      decoration: pw.BoxDecoration(
        color: _white,
        borderRadius: pw.BorderRadius.circular(7),
        border: pw.Border(left: pw.BorderSide(color: color, width: 3.5)),
        boxShadow: [
          pw.BoxShadow(
            color: PdfColor.fromInt(0x0A000000),
            blurRadius: 5,
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
                width: 20, height: 20,
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(colors: [color, color.shade(0.7)]),
                  shape: pw.BoxShape.circle,
                ),
                alignment: pw.Alignment.center,
                child: pw.Text(no, style: pw.TextStyle(font: fontB, fontSize: 9, color: _white)),
              ),
              pw.SizedBox(width: 7),
              pw.Expanded(child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(title, style: pw.TextStyle(font: fontB, fontSize: 8.5, color: _gray800)),
                  pw.Row(children: [
                    pw.Text(role, style: pw.TextStyle(font: fontM, fontSize: 7.5, color: color)),
                    pw.Text('  •  ', style: pw.TextStyle(font: fontR, fontSize: 7.5, color: _gray500)),
                    pw.Text(period, style: pw.TextStyle(font: fontM, fontSize: 7.5, color: _gray500)),
                  ]),
                ],
              )),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Text(desc, style: pw.TextStyle(font: fontR, fontSize: 8, color: _gray500, lineSpacing: 1.35)),
          pw.SizedBox(height: 5),
          pw.Wrap(
            spacing: 4, runSpacing: 3,
            children: tags.map((t) => pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
              decoration: pw.BoxDecoration(
                color: color,
                borderRadius: pw.BorderRadius.circular(3),
              ),
              child: pw.Text(t, style: pw.TextStyle(font: fontB, fontSize: 7, color: _white)),
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
          width: 18, height: 18,
          decoration: pw.BoxDecoration(color: color.shade(0.15), shape: pw.BoxShape.circle),
          alignment: pw.Alignment.center,
          child: pw.Text(no, style: pw.TextStyle(font: b, fontSize: 8.5, color: color)),
        ),
        pw.SizedBox(width: 7),
        pw.Expanded(child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(title, style: pw.TextStyle(font: b, fontSize: 8.5, color: _gray800)),
            pw.Text(sub, style: pw.TextStyle(font: r, fontSize: 7.5, color: _gray500)),
          ],
        )),
      ],
    );
  }

  // ════════════════════════════════════════════════════════════
  // PAGE FOOTER WITH CLICKABLE URL
  // ════════════════════════════════════════════════════════════
  static pw.Widget _pageFooter(pw.Font r, int page, int total, bool isEnglish) {
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
            isEnglish
                ? '© 2026 Nazarul Qudri, S.Tr.T.  •  Protected under UU ITE  •  Official S.Tr.T. Portfolio'
                : '© 2026 Nazarul Qudri, S.Tr.T.  •  Terlindungi UU ITE  •  Portofolio Resmi S.Tr.T.',
            style: pw.TextStyle(font: r, fontSize: 7.5, color: PdfColor.fromInt(0xFF93C5FD)),
          ),
          pw.Row(
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Text(
                isEnglish ? 'Page $page of $total  •  ' : 'Halaman $page dari $total  •  ',
                style: pw.TextStyle(font: r, fontSize: 7.5, color: PdfColor.fromInt(0xFFCBD5E1)),
              ),
              pw.UrlLink(
                destination: portfolioUrl,
                child: pw.Text(
                  portfolioDisplay,
                  style: pw.TextStyle(
                    font: r,
                    fontSize: 7.5,
                    color: PdfColor.fromInt(0xFF7DD3FC),
                    decoration: pw.TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
