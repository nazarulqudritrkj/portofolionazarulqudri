// ignore_for_file: depend_on_referenced_packages
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Generates a professional styled PDF CV for Nazarul Qudri, S.Tr.T.
class CvPdfGenerator {
  static const PdfColor _primary    = PdfColor.fromInt(0xFF0284C7);
  static const PdfColor _primaryDark= PdfColor.fromInt(0xFF1D4ED8);
  static const PdfColor _accent     = PdfColor.fromInt(0xFF06B6D4);
  static const PdfColor _dark       = PdfColor.fromInt(0xFF0F172A);
  static const PdfColor _textPri    = PdfColor.fromInt(0xFF1E293B);
  static const PdfColor _textSec    = PdfColor.fromInt(0xFF64748B);
  static const PdfColor _bgLight    = PdfColor.fromInt(0xFFF0F9FF);
  static const PdfColor _white      = PdfColor.fromInt(0xFFFFFFFF);
  static const PdfColor _divider    = PdfColor.fromInt(0xFFE2E8F0);
  static const PdfColor _green      = PdfColor.fromInt(0xFF10B981);
  static const PdfColor _purple     = PdfColor.fromInt(0xFF7C3AED);
  static const PdfColor _orange     = PdfColor.fromInt(0xFFF59E0B);

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

    // Page 1 — Header + two-column body
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      theme: pw.ThemeData.withFont(base: fontR, bold: fontB),
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _header(fontEB, fontB, fontM, fontR),
          pw.Expanded(
            child: pw.Padding(
              padding: const pw.EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // ── LEFT 60% ──────────────────────────────
                  pw.Expanded(
                    flex: 60,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _section('RINGKASAN PROFIL', _primary, fontB,
                            _profileText(fontR)),
                        _gap(10),
                        _section('PENDIDIKAN FORMAL', _purple, fontB,
                            _education(fontB, fontM, fontR)),
                        _gap(10),
                        _section('PROYEK REKAYASA UNGGULAN', _primary, fontB,
                            _projects(fontB, fontM, fontR)),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 14),
                  // ── RIGHT 40% ─────────────────────────────
                  pw.Expanded(
                    flex: 40,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _section('KEAHLIAN UTAMA', _primary, fontB,
                            _skills(fontM, fontR)),
                        _gap(10),
                        _section('SPESIALISASI TEKNIS', _accent, fontB,
                            _specializations(fontB, fontR)),
                        _gap(10),
                        _section('PRESTASI NASIONAL', _orange, fontB,
                            _achievements(fontB, fontR)),
                        _gap(10),
                        _section('SERTIFIKASI KOMINFO DTS', _green, fontB,
                            _certification(fontB, fontR)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _footer(fontR),
        ],
      ),
    ));

    return pdf.save();
  }

  // ── HEADER ──────────────────────────────────────────────────
  static pw.Widget _header(pw.Font eb, pw.Font b, pw.Font m, pw.Font r) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_dark, _primaryDark, _primary],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.fromLTRB(24, 18, 24, 14),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('NAZARUL QUDRI, S.Tr.T.',
                        style: pw.TextStyle(font: eb, fontSize: 20,
                            color: _white, letterSpacing: 1.2)),
                    pw.SizedBox(height: 3),
                    pw.Text('Flutter Developer  •  IoT CPS & AI Specialist',
                        style: pw.TextStyle(font: m, fontSize: 9.5,
                            color: PdfColor.fromInt(0xFFBAE6FD))),
                    pw.Text(
                        'D4 Teknologi Rekayasa Komputer Jaringan — Politeknik Negeri Lhokseumawe',
                        style: pw.TextStyle(font: r, fontSize: 8.5,
                            color: PdfColor.fromInt(0xFF93C5FD))),
                  ],
                ),
              ),
              pw.SizedBox(width: 20),
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
          pw.Container(height: 0.8,
              color: PdfColor.fromInt(0x44FFFFFF),
              margin: const pw.EdgeInsets.only(bottom: 8)),
          pw.Row(
            children: [
              _chip('Tersedia untuk Kolaborasi', _green, m),
              pw.SizedBox(width: 6),
              _chip('4+ Tahun Pengalaman', _accent, m),
              pw.SizedBox(width: 6),
              _chip('11 Sertifikasi Kominfo DTS', _orange, m),
            ],
          ),
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
          color: c.shade(0.25),
          borderRadius: pw.BorderRadius.circular(20),
          border: pw.Border.all(color: c, width: 0.7),
        ),
        child: pw.Text(t,
            style: pw.TextStyle(font: m, fontSize: 7.5, color: c)),
      );

  // ── SECTION HEADER ──────────────────────────────────────────
  static pw.Widget _section(String title, PdfColor color,
      pw.Font fontB, pw.Widget content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(children: [
          pw.Container(width: 3, height: 13, color: color),
          pw.SizedBox(width: 6),
          pw.Text(title,
              style: pw.TextStyle(font: fontB, fontSize: 8.5,
                  color: _dark, letterSpacing: 0.6)),
        ]),
        pw.Container(height: 0.7, color: _divider,
            margin: const pw.EdgeInsets.only(top: 3, bottom: 7)),
        content,
      ],
    );
  }

  static pw.Widget _gap(double h) => pw.SizedBox(height: h);

  // ── PROFILE TEXT ────────────────────────────────────────────
  static pw.Widget _profileText(pw.Font r) => pw.Text(
    'Software Engineer dan Sarjana Terapan Teknik (S.Tr.T.) Program Studi D4 TRKJ, Jurusan TIK Politeknik Negeri Lhokseumawe. Spesialis dalam rekayasa aplikasi mobile Flutter (Dart & BLoC), sistem siber-fisik IoT CPS berbasis 7 Lapisan OSI & MQTT/TLS, kecerdasan buatan (Rule-Based Decision Systems & AI Studio), dan pengembangan sistem informasi web akademik terintegrasi.',
    style: pw.TextStyle(font: r, fontSize: 8.5,
        color: _textPri, lineSpacing: 1.4),
  );

  // ── EDUCATION ───────────────────────────────────────────────
  static pw.Widget _education(pw.Font b, pw.Font m, pw.Font r) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(9),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromInt(0xFFF5F3FF),
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border(left: pw.BorderSide(color: _purple, width: 3)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('D4 Teknologi Rekayasa Komputer Jaringan (TRKJ)',
                  style: pw.TextStyle(font: b, fontSize: 8.5, color: _dark)),
              _badge('2022 – 2026', _purple, b),
            ],
          ),
          pw.SizedBox(height: 2),
          pw.Text('Politeknik Negeri Lhokseumawe (PNL)  •  Jurusan TIK',
              style: pw.TextStyle(font: m, fontSize: 8, color: _purple)),
          pw.SizedBox(height: 6),
          _eRow('Gelar', 'Sarjana Terapan Teknik (S.Tr.T.)', b, r),
          _eRow('Predikat', 'Sangat Memuaskan / Pujian', b, r),
          _eRow('Lulus', '29 Juli 2026', b, r),
          _eRow('Pembimbing', 'Husaini, S.Si., M.I.T.', b, r),
          pw.SizedBox(height: 5),
          pw.Container(
            padding: const pw.EdgeInsets.all(6),
            decoration: pw.BoxDecoration(
              color: PdfColor.fromInt(0xFFEDE9FE),
              borderRadius: pw.BorderRadius.circular(5),
            ),
            child: pw.Text(
              'Skripsi: Rancang Bangun IoT pada Prototype Smart Home dengan Penerapan Rule-Based Decision System sebagai Artificial Intelligence (STARZAR — 7 OSI Layer & MQTT HiveMQ)',
              style: pw.TextStyle(font: r, fontSize: 7.5,
                  color: _purple, lineSpacing: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _eRow(String l, String v, pw.Font b, pw.Font r) =>
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: 2),
        child: pw.Row(children: [
          pw.SizedBox(width: 65,
              child: pw.Text(l,
                  style: pw.TextStyle(font: b, fontSize: 7.5,
                      color: _textSec))),
          pw.Text(':  ',
              style: pw.TextStyle(font: b, fontSize: 7.5, color: _textSec)),
          pw.Expanded(child: pw.Text(v,
              style: pw.TextStyle(font: r, fontSize: 7.5, color: _textPri))),
        ]),
      );

  static pw.Widget _badge(String t, PdfColor c, pw.Font b) =>
      pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: pw.BoxDecoration(
          color: c.shade(0.15),
          borderRadius: pw.BorderRadius.circular(10),
        ),
        child: pw.Text(t,
            style: pw.TextStyle(font: b, fontSize: 7.5, color: c)),
      );

  // ── PROJECTS ────────────────────────────────────────────────
  static pw.Widget _projects(pw.Font b, pw.Font m, pw.Font r) {
    final data = [
      {
        'no': '1', 'color': _primary,
        'title': 'STARZAR — Smart Exclusive Home IoT & AI',
        'sub': 'Skripsi S.Tr.T. TRKJ PNL • 2024–2026',
        'desc': 'Smart Home berbasis ESP32, 7 OSI Layer, MQTT HiveMQ & Rule-Based AI. Latensi 180ms, 0% Packet Loss.',
        'tags': ['Flutter', 'ESP32', 'MQTT', 'AI'],
      },
      {
        'no': '2', 'color': _accent,
        'title': 'Sistem Informasi & Pendaftaran Kuliah Umum',
        'sub': 'Jurusan TIK PNL • 2025–2026',
        'desc': 'Portal web pendaftaran, absensi QR Code, dan agenda kuliah bagi 1.000+ mahasiswa TIK PNL.',
        'tags': ['Laravel', 'MySQL', 'QR Absensi'],
      },
      {
        'no': '3', 'color': _purple,
        'title': 'Sistem Informasi Sertifikat Dosen PNL',
        'sub': 'Politeknik Negeri Lhokseumawe • 2025–2026',
        'desc': 'Repositori digital pengarsipan & verifikasi sertifikat kompetensi dosen — mendukung BKD & akreditasi.',
        'tags': ['Web System', 'Repository', 'Auth'],
      },
      {
        'no': '4', 'color': _green,
        'title': 'Sistem Informasi Sertifikat Mahasiswa/i TIK',
        'sub': 'Jurusan TIK PNL • 2025–2026',
        'desc': 'Platform penerbitan e-sertifikat digital, validasi SKPI, dan manajemen dokumen akademik terintegrasi.',
        'tags': ['E-Sertifikat', 'SKPI', 'Web'],
      },
    ];

    return pw.Column(
      children: data.asMap().entries.map((e) {
        final d = e.value;
        final c = d['color'] as PdfColor;
        final tags = d['tags'] as List<String>;
        return pw.Padding(
          padding: pw.EdgeInsets.only(bottom: e.key < data.length - 1 ? 6 : 0),
          child: pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              color: _white,
              borderRadius: pw.BorderRadius.circular(6),
              border: pw.Border(left: pw.BorderSide(color: c, width: 2.5)),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      width: 16, height: 16,
                      decoration: pw.BoxDecoration(
                        color: c.shade(0.15), shape: pw.BoxShape.circle),
                      alignment: pw.Alignment.center,
                      child: pw.Text(d['no'] as String,
                          style: pw.TextStyle(font: b, fontSize: 7.5, color: c)),
                    ),
                    pw.SizedBox(width: 6),
                    pw.Expanded(child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(d['title'] as String,
                            style: pw.TextStyle(font: b, fontSize: 8.5, color: _dark)),
                        pw.Text(d['sub'] as String,
                            style: pw.TextStyle(font: m, fontSize: 7.5, color: c)),
                      ],
                    )),
                  ],
                ),
                pw.SizedBox(height: 4),
                pw.Text(d['desc'] as String,
                    style: pw.TextStyle(font: r, fontSize: 7.5,
                        color: _textSec, lineSpacing: 1.2)),
                pw.SizedBox(height: 4),
                pw.Wrap(
                  spacing: 3,
                  runSpacing: 2,
                  children: tags.map((tag) => pw.Container(
                    padding: const pw.EdgeInsets.symmetric(
                        horizontal: 5, vertical: 1.5),
                    decoration: pw.BoxDecoration(
                      color: c.shade(0.1),
                      borderRadius: pw.BorderRadius.circular(8),
                      border: pw.Border.all(color: c.shade(0.4), width: 0.5),
                    ),
                    child: pw.Text(tag,
                        style: pw.TextStyle(font: m, fontSize: 7, color: c)),
                  )).toList(),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // ── SKILLS ──────────────────────────────────────────────────
  static pw.Widget _skills(pw.Font m, pw.Font r) {
    final bars = [
      ('Mobile Dev — Flutter & Dart', 0.95, _primary),
      ('IoT & Networking — 7 OSI Layer', 0.92, _accent),
      ('AI & Decision Systems', 0.90, _purple),
      ('Web Development', 0.85, _green),
      ('Tools & Admin (Office, Figma, Git)', 0.88, _orange),
    ];
    return pw.Column(
      children: bars.asMap().entries.map((e) {
        final (name, pct, color) = e.value;
        return pw.Padding(
          padding: pw.EdgeInsets.only(bottom: e.key < bars.length - 1 ? 7 : 0),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(name,
                      style: pw.TextStyle(font: m, fontSize: 8, color: _textPri)),
                  pw.Text('${(pct * 100).toInt()}%',
                      style: pw.TextStyle(font: m, fontSize: 8, color: color)),
                ],
              ),
              pw.SizedBox(height: 3),
              pw.Stack(children: [
                pw.Container(
                  height: 5,
                  decoration: pw.BoxDecoration(
                    color: _divider,
                    borderRadius: pw.BorderRadius.circular(3),
                  ),
                ),
                pw.Container(
                  height: 5,
                  width: 170 * pct,
                  decoration: pw.BoxDecoration(
                    gradient: pw.LinearGradient(
                        colors: [color, color.shade(0.7)]),
                    borderRadius: pw.BorderRadius.circular(3),
                  ),
                ),
              ]),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ── SPECIALIZATIONS ─────────────────────────────────────────
  static pw.Widget _specializations(pw.Font b, pw.Font r) {
    final specs = [
      ('Flutter & Dart', 'Cross-Platform Mobile & Web', _primary),
      ('BLoC Pattern', 'Reactive State Management', _accent),
      ('IoT CPS', 'ESP32, ESP8266, MQTT/TLS, VLAN', _green),
      ('AI/ML', 'Rule-Based Decision System, AI Studio', _purple),
      ('Web Dev', 'Laravel, MySQL, HTML/CSS, PHP', _orange),
      ('Tools', 'Figma, VS Code, Git, MS Office', _textSec),
    ];
    return pw.Column(
      children: specs.map((s) {
        final (title, desc, color) = s;
        return pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 5),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 4, height: 4,
                margin: const pw.EdgeInsets.only(top: 2.5, right: 5),
                decoration: pw.BoxDecoration(
                    color: color, shape: pw.BoxShape.circle),
              ),
              pw.Expanded(child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(title,
                      style: pw.TextStyle(font: b, fontSize: 8, color: _textPri)),
                  pw.Text(desc,
                      style: pw.TextStyle(font: r, fontSize: 7.5, color: _textSec)),
                ],
              )),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ── ACHIEVEMENTS ────────────────────────────────────────────
  static pw.Widget _achievements(pw.Font b, pw.Font r) {
    final list = [
      ('Finalis Inovasi Perangkat Lunak',
          'KMIPN VI 2025 — Politeknik Nasional'),
      ('Medali Nasional NSO 5',
          'National Science Olympiad — Bahasa Inggris'),
      ('Medali Nasional OSPN',
          'Olimpiade Sains — Akuntansi & Logika Kuantitatif'),
      ('Medali Nasional OSH 2025',
          'Olimpiade Sains — Bahasa Indonesia'),
    ];
    return pw.Column(
      children: list.asMap().entries.map((e) {
        final (title, sub) = e.value;
        return pw.Padding(
          padding: pw.EdgeInsets.only(bottom: e.key < list.length - 1 ? 5 : 0),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 16, height: 16,
                decoration: pw.BoxDecoration(
                  color: _orange.shade(0.15),
                  shape: pw.BoxShape.circle,
                ),
                alignment: pw.Alignment.center,
                child: pw.Text('${e.key + 1}',
                    style: pw.TextStyle(font: b, fontSize: 8, color: _orange)),
              ),
              pw.SizedBox(width: 6),
              pw.Expanded(child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(title,
                      style: pw.TextStyle(font: b, fontSize: 8, color: _textPri)),
                  pw.Text(sub,
                      style: pw.TextStyle(font: r, fontSize: 7.5, color: _textSec)),
                ],
              )),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ── CERTIFICATION ───────────────────────────────────────────
  static pw.Widget _certification(pw.Font b, pw.Font r) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(9),
      decoration: pw.BoxDecoration(
        color: _bgLight,
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border.all(color: _green.shade(0.3), width: 0.8),
      ),
      child: pw.Row(children: [
        pw.Container(
          width: 32, height: 32,
          decoration: pw.BoxDecoration(
            color: _green.shade(0.15), shape: pw.BoxShape.circle),
          alignment: pw.Alignment.center,
          child: pw.Text('11',
              style: pw.TextStyle(font: b, fontSize: 13, color: _green)),
        ),
        pw.SizedBox(width: 8),
        pw.Expanded(child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Sertifikasi Resmi Terverifikasi',
                style: pw.TextStyle(font: b, fontSize: 8.5, color: _textPri)),
            pw.Text(
              'Kementerian Komunikasi & Informatika RI\nDigital Talent Scholarship 2024–2025',
              style: pw.TextStyle(font: r, fontSize: 7.5,
                  color: _textSec, lineSpacing: 1.3),
            ),
          ],
        )),
      ]),
    );
  }

  // ── FOOTER ──────────────────────────────────────────────────
  static pw.Widget _footer(pw.Font r) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_dark, _primaryDark],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            '© 2026 Nazarul Qudri, S.Tr.T.  •  Terlindungi UU ITE',
            style: pw.TextStyle(font: r, fontSize: 7.5,
                color: PdfColor.fromInt(0xFF93C5FD)),
          ),
          pw.Text(
            'nazarulqudritrkj.github.io/portofolionazarulqudri',
            style: pw.TextStyle(font: r, fontSize: 7.5,
                color: PdfColor.fromInt(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}
