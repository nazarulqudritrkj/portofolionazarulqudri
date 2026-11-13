// ignore_for_file: depend_on_referenced_packages
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

/// Professional Engineering Portfolio Dossier PDF Generator — Nazarul Qudri, S.Tr.T.
/// Bilingual support: Indonesian (default) & English
/// Clickable Portfolio Link embedded in Cover and all 5 Page Footers
class PortfolioPdfGenerator {
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
  static const PdfColor _teal    = PdfColor.fromInt(0xFF0D9488);
  static const PdfColor _white   = PdfColor.fromInt(0xFFFFFFFF);
  static const PdfColor _gray100 = PdfColor.fromInt(0xFFF1F5F9);
  static const PdfColor _gray200 = PdfColor.fromInt(0xFFE2E8F0);
  static const PdfColor _gray500 = PdfColor.fromInt(0xFF64748B);
  static const PdfColor _gray800 = PdfColor.fromInt(0xFF1E293B);
  static const PdfColor _purpleL = PdfColor.fromInt(0xFFF5F3FF);

  static Future<Uint8List> generate({bool isEnglish = false}) async {
    final pdf = pw.Document(
      title: isEnglish
          ? 'Engineering Portfolio Dossier — Nazarul Qudri, S.Tr.T.'
          : 'Berkas Portofolio Rekayasa Lengkap — Nazarul Qudri, S.Tr.T.',
      author: 'Nazarul Qudri, S.Tr.T.',
      subject: isEnglish
          ? 'Official Engineering Portfolio Dossier — Bachelor of Applied Engineering'
          : 'Dokumen Portofolio Rekayasa Resmi — Sarjana Terapan Teknik',
      creator: 'Politeknik Negeri Lhokseumawe — Jurusan TIK',
    );

    final fontR  = await PdfGoogleFonts.interRegular();
    final fontM  = await PdfGoogleFonts.interMedium();
    final fontB  = await PdfGoogleFonts.interBold();
    final fontEB = await PdfGoogleFonts.interExtraBold();

    pw.ImageProvider? profileImage;
    try {
      final bytes = await rootBundle.load('lib/images/fotoprofil/fotoNazarulQudri_profile.jpg');
      profileImage = pw.MemoryImage(bytes.buffer.asUint8List());
    } catch (_) {
      try {
        final bytes = await rootBundle.load('assets/lib/images/fotoprofil/fotoNazarulQudri_profile.jpg');
        profileImage = pw.MemoryImage(bytes.buffer.asUint8List());
      } catch (_) {}
    }

    // ═══════════════════════════════════════════════════════════
    // HALAMAN 1: EXECUTIVE COVER & PROFIL REKAYASA
    // ═══════════════════════════════════════════════════════════
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      theme: pw.ThemeData.withFont(base: fontR, bold: fontB),
      build: (ctx) => pw.Column(
        children: [
          _buildCoverHeader(fontEB, fontB, fontM, fontR, isEnglish, profileImage),
          pw.Expanded(
            child: pw.Container(
              color: _gray100,
              padding: const pw.EdgeInsets.fromLTRB(28, 14, 28, 14),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _sectionHeader(
                    isEnglish ? 'ENGINEERING EXECUTIVE SUMMARY' : 'RINGKASAN EKSEKUTIF REKAYASA',
                    _blue, fontB,
                  ),
                  pw.SizedBox(height: 7),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(12),
                    decoration: pw.BoxDecoration(
                      color: _white,
                      borderRadius: pw.BorderRadius.circular(8),
                      border: pw.Border(left: pw.BorderSide(color: _blue, width: 4)),
                    ),
                    child: pw.Text(
                      isEnglish
                          ? 'Bachelor of Applied Engineering (S.Tr.T.) graduate in Computer Network Engineering Technology (D4 TRKJ), Department of Information and Computer Technology (TIK), Politeknik Negeri Lhokseumawe (Cum Laude). Proven expertise in cross-platform mobile engineering with Flutter (Reactive BLoC architecture), cyber-physical systems (IoT CPS) with complete 7-Layer OSI network model & MQTT HiveMQ Cloud, applied artificial intelligence (Rule-Based Decision Systems & Google AI Studio), and integrated enterprise-grade academic web information platforms.'
                          : 'Sarjana Terapan Teknik (S.Tr.T.) lulusan Program Studi D4 Teknologi Rekayasa Komputer Jaringan (TRKJ), Jurusan Teknologi Informasi dan Komputer (TIK) Politeknik Negeri Lhokseumawe dengan predikat kelulusan Cum Laude. Memiliki keahlian teruji dalam rekayasa aplikasi mobile cross-platform Flutter (BLoC Reactive Architecture), arsitektur sistem siber-fisik (Cyber-Physical Systems / IoT CPS) berbasis 7 Lapisan Model OSI dan MQTT HiveMQ Cloud, sistem kecerdasan buatan terapan (Rule-Based Decision Systems & Google AI Studio), serta rekayasa sistem informasi web institusi berskala enterprise.',
                      style: pw.TextStyle(font: fontR, fontSize: 9.3, color: _gray800, lineSpacing: 1.55),
                    ),
                  ),
                  pw.SizedBox(height: 12),

                  _sectionHeader(
                    isEnglish ? 'CORE ENGINEERING PILLARS' : 'PILAR KOMPETENSI UTAMA',
                    _purple, fontB,
                  ),
                  pw.SizedBox(height: 7),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: _pillarCard(
                          title: 'Mobile Architecture',
                          sub: 'Flutter, Dart, Reactive BLoC',
                          desc: isEnglish
                              ? 'High-performance 60 FPS mobile apps, reactive state management, local Hive DB persistence, and biometric security.'
                              : 'Pengembangan aplikasi performa tinggi 60 FPS, manajemen state reaktif, enkapsulasi data lokal Hive DB, dan integrasi hardware biometrik.',
                          color: _blue, fontB: fontB, fontM: fontM, fontR: fontR,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                        child: _pillarCard(
                          title: 'IoT & 7 OSI Layer',
                          sub: 'ESP32, MQTT/TLS, Telemetry',
                          desc: isEnglish
                              ? 'Multi-zone microcontroller firmware, full 7 OSI layer implementation, responsive 180 ms latency, and zero packet loss.'
                              : 'Desain firmware mikrokontroler multi-zona, implementasi penuh Layer 1–7 OSI, latensi responsif 180 ms, dan QoS 0% Packet Loss.',
                          color: _cyan, fontB: fontB, fontM: fontM, fontR: fontR,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: _pillarCard(
                          title: 'Applied AI & Decision',
                          sub: 'Rule-Based & AI Studio',
                          desc: isEnglish
                              ? 'Forward Chaining inference engine with 100% emergency accuracy, Gemini prompt engineering, and deterministic logic.'
                              : 'Inference engine berbasis Forward Chaining dengan akurasi 100% pada skenario darurat, prompt engineering Gemini, dan evaluasi logika.',
                          color: _purple, fontB: fontB, fontM: fontM, fontR: fontR,
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                        child: _pillarCard(
                          title: 'Enterprise Web Systems',
                          sub: 'Laravel, MySQL, REST API',
                          desc: isEnglish
                              ? 'Institutional academic portals, encrypted QR attendance, faculty credential archives, and SKPI student validation.'
                              : 'Pembangunan portal akademik institusi, sistem absensi QR digital, repositori sertifikat dosen PNL, dan validasi SKPI mahasiswa.',
                          color: _green, fontB: fontB, fontM: fontM, fontR: fontR,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 12),

                  _sectionHeader(
                    isEnglish ? 'DOSSIER BENCHMARK SUMMARY' : 'IKHTISAR DOKUMEN PORTOFOLIO',
                    _orange, fontB,
                  ),
                  pw.SizedBox(height: 7),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    decoration: pw.BoxDecoration(
                      color: _white,
                      borderRadius: pw.BorderRadius.circular(8),
                      border: pw.Border(left: pw.BorderSide(color: _orange, width: 4)),
                    ),
                    child: pw.Row(
                      children: [
                        _summaryMetric('4+', isEnglish ? 'Featured Systems' : 'Proyek Unggulan', _blue, fontEB, fontM),
                        _metricDivider(),
                        _summaryMetric('180ms', isEnglish ? 'IoT CPS Latency' : 'Latensi IoT CPS', _cyan, fontEB, fontM),
                        _metricDivider(),
                        _summaryMetric('11x', isEnglish ? 'DTS Credentials' : 'Sertifikasi Kominfo', _green, fontEB, fontM),
                        _metricDivider(),
                        _summaryMetric('4x', isEnglish ? 'National Honors' : 'Juara/Medali Nas.', _orange, fontEB, fontM),
                        _metricDivider(),
                        _summaryMetric('Cum Laude', isEnglish ? 'Academic Honors' : 'Predikat Kelulusan', _purple, fontEB, fontM),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _pageFooter(fontR, 1, 5, isEnglish),
        ],
      ),
    ));

    // ═══════════════════════════════════════════════════════════
    // HALAMAN 2: STUDI KASUS STARZAR (IoT CPS & 7 OSI LAYER)
    // ═══════════════════════════════════════════════════════════
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      theme: pw.ThemeData.withFont(base: fontR, bold: fontB),
      build: (ctx) => pw.Column(
        children: [
          _buildMiniHeader(
            isEnglish
                ? 'CASE STUDY I: STARZAR — SMART HOME IOT & AI (BACHELOR THESIS TRKJ PNL)'
                : 'STUDI KASUS I: STARZAR — SMART HOME IOT & AI (SKRIPSI TRKJ PNL)',
            fontB, fontR, isEnglish,
          ),
          pw.Expanded(
            child: pw.Container(
              color: _gray100,
              padding: const pw.EdgeInsets.fromLTRB(28, 14, 28, 14),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    padding: const pw.EdgeInsets.all(11),
                    decoration: pw.BoxDecoration(
                      color: _white,
                      borderRadius: pw.BorderRadius.circular(8),
                      border: pw.Border(left: pw.BorderSide(color: _blue, width: 4)),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('STARZAR: Smart Exclusive Home Cyber-Physical System',
                                style: pw.TextStyle(font: fontB, fontSize: 10.5, color: _navy)),
                            _chip(isEnglish ? 'Thesis S.Tr.T. TRKJ PNL' : 'Skripsi S.Tr.T. TRKJ PNL', _blue, fontB),
                          ],
                        ),
                        pw.SizedBox(height: 3),
                        pw.Text(
                          isEnglish
                              ? 'Integrated Cyber-Physical Smart Home System powered by multi-zone ESP32 microcontrollers, HiveMQ Cloud MQTT broker, and STARZAR Flutter Android application with complete scientific proof of the 7-Layer OSI Model and Rule-Based AI Decision System.'
                              : 'Sistem Siber-Fisik Smart Home terpadu berbasis mikrokontroler ESP32 multi-zona, broker HiveMQ Cloud, dan aplikasi Android Flutter STARZAR dengan pembuktian ilmiah arsitektur 7 Lapisan Model OSI dan sistem pakar kecerdasan buatan Rule-Based Decision System.',
                          style: pw.TextStyle(font: fontR, fontSize: 8.5, color: _gray800, lineSpacing: 1.45),
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 10),

                  _sectionHeader(
                    isEnglish ? 'FULL 7-LAYER OSI MODEL ARCHITECTURAL IMPLEMENTATION' : 'IMPLEMENTASI LENGKAP 7 LAPISAN MODEL OSI',
                    _blueD, fontB,
                  ),
                  pw.SizedBox(height: 7),
                  _osiLayerRow('Layer 7: Application', isEnglish ? 'STARZAR Flutter Android app, MQTT protocol, manual override, biometric authentication, live graphs, and XLSX export.' : 'Aplikasi Android Flutter STARZAR, protokol MQTT, kontrol manual override, autentikasi biometrik sidik jari, monitoring grafik real-time, dan ekspor data XLSX.', _blue, fontB, fontR),
                  _osiLayerRow('Layer 6: Presentation', isEnglish ? 'Lightweight JSON String telemetry encapsulation, object serialization, and local Hive database storage.' : 'Enkapsulasi data telemetri berformat JSON String berbobot ringan, serialisasi objek, dan struktur basis data lokal Hive DB.', _cyan, fontB, fontR),
                  _osiLayerRow('Layer 5: Session', isEnglish ? 'Wireless Publish/Subscribe session management between ESP32 publishers and Flutter subscribers via encrypted HiveMQ Cloud.' : 'Manajemen sesi komunikasi nirkabel Publish/Subscribe antara publisher ESP32 dan subscriber Flutter via broker HiveMQ Cloud terenkripsi.', _purple, fontB, fontR),
                  _osiLayerRow('Layer 4: Transport', isEnglish ? 'Transmission Control Protocol (TCP) guaranteeing packet delivery integrity with zero packet loss (0% Packet Loss).' : 'Protokol Transmission Control Protocol (TCP) dengan garansi integritas transmisi data telemetri (Packet Loss 0%).', _green, fontB, fontR),
                  _osiLayerRow('Layer 3: Network', isEnglish ? 'Internet Protocol (IP) for discrete node addressing and subnet routing from local gateways to cloud broker.' : 'Pengalamatan Internet Protocol (IP Address) untuk perutean paket data sensor dari node lokal ke gateway cloud.', _orange, fontB, fontR),
                  _osiLayerRow('Layer 2: Data Link', isEnglish ? 'IEEE 802.11 Wi-Fi standard for wireless frame handling and hardware MAC address verification.' : 'Standar IEEE 802.11 (Wi-Fi Protocol) untuk manajemen frame data nirkabel dan verifikasi fisik MAC Address hardware.', _teal, fontB, fontR),
                  _osiLayerRow('Layer 1: Physical', isEnglish ? 'ESP32 SoC modules, 2.4 GHz RF antennas, DHT22, MQ-2, MQ-135, Flame IR, HC-SR04 sensors, and multi-channel relay modules.' : 'Modul ESP32 SoC, antena pemancar gelombang radio 2.4 GHz, sensor DHT22, MQ-2, MQ-135, Flame IR, HC-SR04, dan relay multi-channel.', _gray500, fontB, fontR),
                  pw.SizedBox(height: 10),

                  _sectionHeader(
                    isEnglish ? 'SCIENTIFIC BENCHMARKS & QOS PARAMETERS (ITU-T Y.1010)' : 'HASIL PENGUJIAN ILMIAH & PARAMETER QOS (ITU-T Y.1010)',
                    _green, fontB,
                  ),
                  pw.SizedBox(height: 7),
                  pw.Row(
                    children: [
                      pw.Expanded(child: _metricCard(isEnglish ? 'Rule-Based AI Accuracy' : 'Akurasi Rule-Based AI', '100%', isEnglish ? '10 Emergency Scenarios Tested' : '10 Skenario Darurat Teruji', _purple, fontEB, fontB, fontR)),
                      pw.SizedBox(width: 8),
                      pw.Expanded(child: _metricCard(isEnglish ? 'System Response Time' : 'System Response Time', '180 ms', isEnglish ? 'ITU-T Y.1010 Spec (<2000ms)' : 'Standar ITU-T Y.1010 (<2000ms)', _blue, fontEB, fontB, fontR)),
                      pw.SizedBox(width: 8),
                      pw.Expanded(child: _metricCard(isEnglish ? 'Packet Loss Rate' : 'Packet Loss Rate', '0%', isEnglish ? 'TCP Transport Reliability' : 'Keandalan Transport TCP', _green, fontEB, fontB, fontR)),
                      pw.SizedBox(width: 8),
                      pw.Expanded(child: _metricCard(isEnglish ? 'Sensor Accuracy' : 'Akurasi Sensor Telemetri', '96.4%', 'DHT22, MQ-2, MQ-135, Flame', _orange, fontEB, fontB, fontR)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _pageFooter(fontR, 2, 5, isEnglish),
        ],
      ),
    ));

    // ═══════════════════════════════════════════════════════════
    // HALAMAN 3: SISTEM INFORMASI WEB INSTITUSI TIK PNL
    // ═══════════════════════════════════════════════════════════
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      theme: pw.ThemeData.withFont(base: fontR, bold: fontB),
      build: (ctx) => pw.Column(
        children: [
          _buildMiniHeader(
            isEnglish
                ? 'CASE STUDIES II, III, & IV: PNL INSTITUTIONAL ACADEMIC WEB SYSTEMS'
                : 'STUDI KASUS II, III, & IV: SISTEM INFORMASI WEB AKADEMIK INSTITUSI PNL',
            fontB, fontR, isEnglish,
          ),
          pw.Expanded(
            child: pw.Container(
              color: _gray100,
              padding: const pw.EdgeInsets.fromLTRB(28, 14, 28, 14),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _projectDossierCard(
                    no: '02',
                    title: isEnglish
                        ? 'TIK PNL Public Lecture & Event Registration Information System'
                        : 'Website Sistem Informasi & Pendaftaran Kuliah Umum Jurusan TIK PNL',
                    period: '2025 – 2026  •  Department of Information & Computer Technology PNL',
                    role: isEnglish ? 'Full-Stack Developer & Database Architect' : 'Full-Stack Developer & Database Architect',
                    desc: isEnglish
                        ? 'Comprehensive web platform automating registration workflows, automated Student ID (NIM) & major validation, encrypted QR code attendance tracking, participant capacity enforcement, and instant e-certificate distribution for 1,000+ students across departments.'
                        : 'Platform web komprehensif untuk mengotomasi alur registrasi, validasi NIM/Prodi otomatis, absensi kehadiran digital berbasis QR Code terenkripsi, kuota peserta seminar, dan distribusi e-sertifikat kegiatan bagi lebih dari 1.000 mahasiswa lintas program studi (TRKJ, Teknik Informatika, dll.).',
                    tags: ['Web Portal', 'Laravel', 'MySQL', 'REST API', 'QR Absensi', 'TIK PNL'],
                    impact: isEnglish
                        ? 'Impact: 100% elimination of paper attendance queues, reducing seminar attendance reconciliation from days to instantaneous real-time reporting.'
                        : 'Dampak: Mengeliminasi antrean fisik dan presensi manual kertas hingga 100%, mempercepat rekapitulasi kehadiran seminar dari hitungan hari menjadi real-time.',
                    color: _blueD, fontB: fontB, fontM: fontM, fontR: fontR,
                  ),
                  pw.SizedBox(height: 10),

                  _projectDossierCard(
                    no: '03',
                    title: isEnglish
                        ? 'PNL Faculty Certificate & Credential Repository Web System'
                        : 'Website Sistem Informasi Sertifikat Dosen Politeknik Negeri Lhokseumawe',
                    period: '2025 – 2026  •  Politeknik Negeri Lhokseumawe',
                    role: isEnglish ? 'Backend Developer & Security Specialist' : 'Backend Developer & Security Specialist',
                    desc: isEnglish
                        ? 'Centralized encrypted digital vault for indexing, archiving, and validating faculty competency certifications, research credentials, and community service decrees to streamline Academic Workload (BKD) and department accreditation.'
                        : 'Repositori digital terpusat dan terenkripsi untuk mengarsipkan, mengkategorisasikan, dan memverifikasi keabsahan sertifikat kompetensi, keahlian, riset, serta pengabdian masyarakat seluruh dosen PNL guna mendukung pelaporan Beban Kerja Dosen (BKD) dan akreditasi jurusan.',
                    tags: ['Document Repository', 'Security Auth', 'RBAC Multi-Level', 'Audit Trail', 'PNL'],
                    impact: isEnglish
                        ? 'Impact: Enables campus leaders and audit assessors to instantly verify faculty credentials via unique serial numbers without physical paper handling.'
                        : 'Dampak: Mempermudah pimpinan dan tim akreditasi menelusuri portofolio dosen dengan nomor seri verifikasi unik tanpa risiko kehilangan dokumen fisik.',
                    color: _teal, fontB: fontB, fontM: fontM, fontR: fontR,
                  ),
                  pw.SizedBox(height: 10),

                  _projectDossierCard(
                    no: '04',
                    title: isEnglish
                        ? 'TIK PNL Student E-Certificate & SKPI Validation Web Platform'
                        : 'Website Sistem Informasi Sertifikat Mahasiswa/i Jurusan TIK PNL',
                    period: '2025 – 2026  •  Department of Information & Computer Technology PNL',
                    role: isEnglish ? 'Full-Stack Web & Integration Engineer' : 'Full-Stack Web & Integration Engineer',
                    desc: isEnglish
                        ? 'Unified e-certificate management portal facilitating dynamic credential generation, co-curricular achievement tracking, and anti-counterfeit QR code validation supporting the official Diploma Supplement (SKPI).'
                        : 'Sistem manajemen e-sertifikat digital terpadu yang memfasilitasi penerbitan, penyimpanan riwayat prestasi, dan verifikasi dokumen kegiatan akademik, workshop, kepanitiaan, dan perlombaan mahasiswa untuk mendukung penerbitan Surat Keterangan Pendamping Ijazah (SKPI).',
                    tags: ['E-Certificate Generator', 'QR Anti-Fraud', 'SKPI Integration', 'Web App', 'TIK PNL'],
                    impact: isEnglish
                        ? 'Impact: Students can independently view, verify, and download their achievement credentials on demand with tamper-proof cryptographic QR verification.'
                        : 'Dampak: Mahasiswa dapat mengakses dan memvalidasi portofolio sertifikat mereka secara mandiri kapan pun dengan jaminan keaslian QR anti-pemalsuan.',
                    color: _purple, fontB: fontB, fontM: fontM, fontR: fontR,
                  ),
                ],
              ),
            ),
          ),
          _pageFooter(fontR, 3, 5, isEnglish),
        ],
      ),
    ));

    // ═══════════════════════════════════════════════════════════
    // HALAMAN 4: KREDENSIAL AKADEMIK, SKRIPSI & PRESTASI NASIONAL
    // ═══════════════════════════════════════════════════════════
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      theme: pw.ThemeData.withFont(base: fontR, bold: fontB),
      build: (ctx) => pw.Column(
        children: [
          _buildMiniHeader(
            isEnglish
                ? 'ACADEMIC CREDENTIALS, BACHELOR THESIS & NATIONAL HONORS'
                : 'KREDENSIAL AKADEMIK FORMAL, SKRIPSI & PRESTASI TINGKAT NASIONAL',
            fontB, fontR, isEnglish,
          ),
          pw.Expanded(
            child: pw.Container(
              color: _gray100,
              padding: const pw.EdgeInsets.fromLTRB(28, 14, 28, 14),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _sectionHeader(
                    isEnglish ? 'HIGHER EDUCATION & ENGINEERING QUALIFICATION' : 'PENDIDIKAN TINGGI & REKAYASA TEKNIK FORMAL',
                    _purple, fontB,
                  ),
                  pw.SizedBox(height: 7),
                  _buildFormalEducationCard(fontB, fontM, fontR, isEnglish),
                  pw.SizedBox(height: 12),

                  _sectionHeader(
                    isEnglish ? 'NATIONAL HONORS, MEDALS & COMPETITIVE AWARDS' : 'PRESTASI, MEDALI & KOMPETISI TINGKAT NASIONAL',
                    _orange, fontB,
                  ),
                  pw.SizedBox(height: 7),
                  _awardRow(
                    no: '1',
                    title: isEnglish ? 'Software Innovation Finalist — KMIPN VI 2025' : 'Finalis Inovasi Perangkat Lunak — KMIPN VI 2025',
                    issuer: isEnglish
                        ? 'National Polytechnic Informatics Student Competition (Ministry Directorate of Vocational Education)'
                        : 'Kompetisi Mahasiswa Informatika Politeknik Nasional (Direktorat Jenderal Pendidikan Vokasi)',
                    desc: isEnglish
                        ? 'National finalist representing Politeknik Negeri Lhokseumawe in the premier nationwide polytechnic software innovation championship.'
                        : 'Berhasil lolos sebagai finalis nasional mewakili Politeknik Negeri Lhokseumawe dalam ajang inovasi perangkat lunak berskala politeknik se-Indonesia.',
                    color: _orange, fontB: fontB, fontM: fontM, fontR: fontR,
                  ),
                  pw.SizedBox(height: 7),
                  _awardRow(
                    no: '2',
                    title: isEnglish ? 'National Medal Winner — NSO 5 (National Science Olympiad V)' : 'Medali Nasional NSO 5 (National Science Olympiad V)',
                    issuer: isEnglish ? 'English Language Category — Nationwide Academic Competition' : 'Bidang Bahasa Inggris — Kompetisi Akademik Tingkat Nasional',
                    desc: isEnglish
                        ? 'Awarded national medal for technical English proficiency, scientific reading comprehension, and professional communication.'
                        : 'Meraih medali nasional dalam uji kompetensi pemahaman bahasa Inggris teknik, literasi ilmiah, dan komunikasi global profesional.',
                    color: _blueD, fontB: fontB, fontM: fontM, fontR: fontR,
                  ),
                  pw.SizedBox(height: 7),
                  _awardRow(
                    no: '3',
                    title: isEnglish ? 'National Medal Winner — OSPN (National Youth Science Olympiad)' : 'Medali Nasional OSPN (Olimpiade Sains Pemuda Nasional)',
                    issuer: isEnglish ? 'Accounting & Quantitative Logic Category — National Competition' : 'Bidang Akuntansi & Logika Kuantitatif — Kompetisi Nasional',
                    desc: isEnglish
                        ? 'Demonstrated superior analytical logic, quantitative problem-solving, and systematic algorithmic thinking at the national collegiate level.'
                        : 'Membuktikan penguasaan logika analitis, struktur data kuantitatif, dan penalaran sistematis tingkat mahasiswa nasional.',
                    color: _teal, fontB: fontB, fontM: fontM, fontR: fontR,
                  ),
                  pw.SizedBox(height: 7),
                  _awardRow(
                    no: '4',
                    title: isEnglish ? 'National Medal Winner — OSH 2025 (Hardiknas Science Olympiad)' : 'Medali Nasional OSH 2025 (Olimpiade Sains Hardiknas)',
                    issuer: isEnglish ? 'Indonesian Language Category — National Science Competition' : 'Bidang Bahasa Indonesia — Kompetisi Sains Tingkat Nasional',
                    desc: isEnglish
                        ? 'Awarded national medal for formal grammar, scholarly paper composition, and academic Indonesian syntax mastery.'
                        : 'Meraih medali nasional dalam ketatabahasaan formal, penulisan karya ilmiah akademik, dan literasi sintaksis bahasa Indonesia.',
                    color: _green, fontB: fontB, fontM: fontM, fontR: fontR,
                  ),
                ],
              ),
            ),
          ),
          _pageFooter(fontR, 4, 5, isEnglish),
        ],
      ),
    ));

    // ═══════════════════════════════════════════════════════════
    // HALAMAN 5: 11 SERTIFIKASI KOMINFO DTS & VALIDASI HUKUM
    // ═══════════════════════════════════════════════════════════
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.zero,
      theme: pw.ThemeData.withFont(base: fontR, bold: fontB),
      build: (ctx) => pw.Column(
        children: [
          _buildMiniHeader(
            isEnglish
                ? '11x KOMINFO DTS PROFESSIONAL CERTIFICATIONS & TECHNICAL MATRIX'
                : '11x SERTIFIKASI KOMPETENSI KOMINFO DTS & VALIDASI RESMI',
            fontB, fontR, isEnglish,
          ),
          pw.Expanded(
            child: pw.Container(
              color: _gray100,
              padding: const pw.EdgeInsets.fromLTRB(28, 14, 28, 14),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _sectionHeader(
                    isEnglish ? 'DIGITAL TALENT SCHOLARSHIP CERTIFICATIONS (KOMINFO RI)' : 'SERTIFIKASI DIGITAL TALENT SCHOLARSHIP (KEMENKOMINFO RI)',
                    _green, fontB,
                  ),
                  pw.SizedBox(height: 7),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(11),
                    decoration: pw.BoxDecoration(
                      color: _white,
                      borderRadius: pw.BorderRadius.circular(8),
                      border: pw.Border(left: pw.BorderSide(color: _green, width: 4)),
                    ),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          children: [
                            pw.Container(
                              width: 34, height: 34,
                              decoration: const pw.BoxDecoration(
                                gradient: pw.LinearGradient(colors: [_green, PdfColor.fromInt(0xFF34D399)]),
                                shape: pw.BoxShape.circle,
                              ),
                              alignment: pw.Alignment.center,
                              child: pw.Text('11', style: pw.TextStyle(font: fontEB, fontSize: 13, color: _white)),
                            ),
                            pw.SizedBox(width: 10),
                            pw.Expanded(
                              child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    isEnglish ? '11 Nationally Verified Professional Competency Credentials' : '11 Sertifikat Kompetensi Profesional Terakreditasi Nasional',
                                    style: pw.TextStyle(font: fontB, fontSize: 9.5, color: _gray800),
                                  ),
                                  pw.Text(
                                    isEnglish ? 'HRD Research and Development Agency — Ministry of ICT Indonesia (2024–2025)' : 'Badan Pengembangan SDM Komunikasi dan Informatika — Kemenkominfo RI (2024–2025)',
                                    style: pw.TextStyle(font: fontM, fontSize: 8, color: _green),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 7),
                        pw.Container(height: 0.8, color: _gray200),
                        pw.SizedBox(height: 7),
                        pw.Wrap(
                          spacing: 5, runSpacing: 4,
                          children: [
                            _certTag('1. Artificial Intelligence Engineer', _purple, fontM),
                            _certTag('2. Computational Thinking & Algorithm', _blue, fontM),
                            _certTag('3. Ethical Hacker & Cybersecurity', _green, fontM),
                            _certTag('4. Social Media Campaign Strategy', _orange, fontM),
                            _certTag('5. AI Productivity & Google Tools', _purple, fontM),
                            _certTag('6. Cloud Computing & Digital Tech', _cyan, fontM),
                            _certTag('7. Introduction to Coding & Web', _blueD, fontM),
                            _certTag('8. Digital Media & Creative Asset', _teal, fontM),
                            _certTag('9. Digital Transformation Future', _orange, fontM),
                            _certTag('10. UI/UX Principles & Prototyping', _blue, fontM),
                            _certTag('11. Digital Product & Brand Strategy', _green, fontM),
                          ],
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(height: 12),

                  _sectionHeader(
                    isEnglish ? 'ENGINEERING COMPETENCY & STACK MATRIX' : 'MATRIKS KEAHLIAN REKAYASA & STACK TEKNOLOGI',
                    _blue, fontB,
                  ),
                  pw.SizedBox(height: 7),
                  pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(11),
                          decoration: pw.BoxDecoration(
                            color: _white,
                            borderRadius: pw.BorderRadius.circular(8),
                            border: pw.Border(left: pw.BorderSide(color: _blue, width: 4)),
                          ),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(isEnglish ? 'Software & Network Engineering' : 'Keahlian Software & Jaringan', style: pw.TextStyle(font: fontB, fontSize: 9, color: _navy)),
                              pw.SizedBox(height: 5),
                              _skillItem('Mobile Flutter & Dart (Cross-Platform)', 0.95, _blue, fontM, fontR),
                              _skillItem('IoT CPS, ESP32, 7 OSI Layer Telemetry', 0.92, _cyan, fontM, fontR),
                              _skillItem('Rule-Based AI & Decision Systems', 0.90, _purple, fontM, fontR),
                              _skillItem('Web Development (Laravel, MySQL, PHP)', 0.85, _green, fontM, fontR),
                            ],
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(11),
                          decoration: pw.BoxDecoration(
                            color: _white,
                            borderRadius: pw.BorderRadius.circular(8),
                            border: pw.Border(left: pw.BorderSide(color: _teal, width: 4)),
                          ),
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(isEnglish ? 'Development Tools & Productivity' : 'Alat Pengembangan & Produktivitas', style: pw.TextStyle(font: fontB, fontSize: 9, color: _navy)),
                              pw.SizedBox(height: 5),
                              _skillItem('Tools (Figma UI/UX, VS Code, Git)', 0.90, _teal, fontM, fontR),
                              _skillItem('Administration & MS Office Suite', 0.88, _orange, fontM, fontR),
                              _skillItem('Database Architecture (MySQL, Hive DB)', 0.86, _blueD, fontM, fontR),
                              _skillItem('Security, TLS Encryption & Networking', 0.85, _gray500, fontM, fontR),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 12),

                  _sectionHeader(
                    isEnglish ? 'LEGALITY STATEMENT & LEGAL PROTECTION' : 'PERNYATAAN KEABSAHAN & PERLINDUNGAN HUKUM',
                    _navy, fontB,
                  ),
                  pw.SizedBox(height: 7),
                  pw.Container(
                    padding: const pw.EdgeInsets.all(11),
                    decoration: pw.BoxDecoration(
                      color: _white,
                      borderRadius: pw.BorderRadius.circular(8),
                      border: pw.Border.all(color: _gray200, width: 0.8),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                isEnglish ? 'OFFICIAL INSTITUTIONAL DIGITAL VERIFICATION' : 'VERIFIKASI DIGITAL INSTITUSIONAL RESMI',
                                style: pw.TextStyle(font: fontB, fontSize: 8.5, color: _navy),
                              ),
                              pw.SizedBox(height: 2),
                              pw.Text(
                                isEnglish
                                    ? 'The contents of this engineering dossier represent the original academic research, software artifacts, competitive milestones, and professional certifications of Nazarul Qudri, S.Tr.T. Protected by law under the Electronic Information and Transactions Law (UU ITE) of the Republic of Indonesia.'
                                    : 'Seluruh isi berkas portofolio ini mencerminkan hasil karya rekayasa, penelitian ilmiah, pencapaian kompetisi, dan sertifikasi keahlian orisinal dari Nazarul Qudri, S.Tr.T. Dilindungi secara hukum berdasarkan Undang-Undang Informasi dan Transaksi Elektronik (UU ITE) Republik Indonesia.',
                                style: pw.TextStyle(font: fontR, fontSize: 7.5, color: _gray500, lineSpacing: 1.35),
                              ),
                            ],
                          ),
                        ),
                        pw.SizedBox(width: 14),
                        pw.Container(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                          decoration: pw.BoxDecoration(
                            color: _purpleL,
                            borderRadius: pw.BorderRadius.circular(6),
                            border: pw.Border.all(color: PdfColor.fromInt(0xFFDDD6FE), width: 0.8),
                          ),
                          child: pw.Column(
                            children: [
                              pw.Text(isEnglish ? 'VERIFIED' : 'TERVERIFIKASI', style: pw.TextStyle(font: fontB, fontSize: 7.5, color: _purple)),
                              pw.Text('UU ITE • PNL TIK', style: pw.TextStyle(font: fontM, fontSize: 6.5, color: _gray500)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _pageFooter(fontR, 5, 5, isEnglish),
        ],
      ),
    ));

    return pdf.save();
  }

  // ════════════════════════════════════════════════════════════
  // HEADER KOMPONEN COVER (HALAMAN 1)
  // ════════════════════════════════════════════════════════════
  static pw.Widget _buildCoverHeader(
      pw.Font eb, pw.Font b, pw.Font m, pw.Font r, bool isEnglish, pw.ImageProvider? profileImage) {
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
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Expanded(
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    if (profileImage != null) ...[
                      pw.Container(
                        width: 54,
                        height: 54,
                        decoration: pw.BoxDecoration(
                          shape: pw.BoxShape.circle,
                          border: pw.Border.all(color: _white, width: 2),
                        ),
                        child: pw.ClipOval(
                          child: pw.Image(
                            profileImage,
                            width: 54,
                            height: 54,
                            fit: pw.BoxFit.cover,
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 12),
                    ],
                    pw.Expanded(
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Container(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: pw.BoxDecoration(
                              color: PdfColor.fromInt(0x33FFFFFF),
                              borderRadius: pw.BorderRadius.circular(4),
                            ),
                            child: pw.Text(
                              isEnglish
                                  ? 'OFFICIAL ENGINEERING PORTFOLIO DOSSIER (A4 PRINT / DIGITAL)'
                                  : 'DOKUMEN PORTOFOLIO REKAYASA RESMI (ENGINEERING DOSSIER)',
                              style: pw.TextStyle(font: b, fontSize: 7, color: PdfColor.fromInt(0xFFBAE6FD), letterSpacing: 0.8),
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text('NAZARUL QUDRI, S.Tr.T.',
                              style: pw.TextStyle(font: eb, fontSize: 18.5, color: _white, letterSpacing: 1.1)),
                          pw.SizedBox(height: 2.5),
                          pw.Text(
                            'Software Engineer  •  IoT CPS Specialist  •  AI Solutions Architect',
                            style: pw.TextStyle(font: m, fontSize: 8.8, color: PdfColor.fromInt(0xFFBAE6FD)),
                          ),
                          pw.SizedBox(height: 1.5),
                          pw.Text(
                            isEnglish
                                ? 'D4 Computer Network Engineering Technology — Politeknik Negeri Lhokseumawe'
                                : 'D4 Teknologi Rekayasa Komputer Jaringan — Politeknik Negeri Lhokseumawe',
                            style: pw.TextStyle(font: r, fontSize: 8, color: PdfColor.fromInt(0xFF93C5FD)),
                          ),
                        ],
                      ),
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
          pw.Container(height: 0.8, color: PdfColor.fromInt(0x44FFFFFF), margin: const pw.EdgeInsets.only(bottom: 7)),
          pw.Wrap(
            spacing: 6, runSpacing: 4,
            children: [
              _chip('Cum Laude Graduate', _green, b),
              _chip('Sarjana Terapan Teknik (S.Tr.T.)', _blueD, b),
              _chip('7 OSI Layer IoT Specialist', _cyan, b),
              _chip(isEnglish ? '11x Kominfo DTS Certifications' : '11x Sertifikasi Kominfo DTS', _orange, b),
              _chip(isEnglish ? 'Protected by UU ITE Law' : 'Terlindungi UU ITE', _purple, b),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildMiniHeader(String title, pw.Font b, pw.Font r, bool isEnglish) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_navy, _blueD],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.fromLTRB(28, 11, 28, 11),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('NAZARUL QUDRI, S.Tr.T.  •  $title',
              style: pw.TextStyle(font: b, fontSize: 8.5, color: _white, letterSpacing: 0.5)),
          pw.UrlLink(
            destination: portfolioUrl,
            child: pw.Text(
              portfolioDisplay,
              style: pw.TextStyle(
                font: r,
                fontSize: 8,
                color: PdfColor.fromInt(0xFF7DD3FC),
                decoration: pw.TextDecoration.underline,
              ),
            ),
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
          child: pw.Text(label, style: pw.TextStyle(font: m, fontSize: 7.5, color: PdfColor.fromInt(0xFF7DD3FC))),
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
          child: pw.Text(label, style: pw.TextStyle(font: m, fontSize: 7.5, color: PdfColor.fromInt(0xFF7DD3FC))),
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
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: pw.BoxDecoration(
          color: c,
          borderRadius: pw.BorderRadius.circular(4),
          border: pw.Border.all(color: PdfColor.fromInt(0x55FFFFFF), width: 0.8),
        ),
        child: pw.Text(t, style: pw.TextStyle(font: b, fontSize: 7.5, color: _white, letterSpacing: 0.2)),
      );

  static pw.Widget _sectionHeader(String title, PdfColor color, pw.Font fontB) {
    return pw.Row(children: [
      pw.Container(width: 4, height: 14, color: color,
          decoration: pw.BoxDecoration(borderRadius: pw.BorderRadius.circular(2))),
      pw.SizedBox(width: 7),
      pw.Text(title, style: pw.TextStyle(font: fontB, fontSize: 9, color: _gray800, letterSpacing: 0.5)),
      pw.SizedBox(width: 8),
      pw.Expanded(child: pw.Container(height: 0.8, color: _gray200)),
    ]);
  }

  static pw.Widget _pillarCard({
    required String title,
    required String sub,
    required String desc,
    required PdfColor color,
    required pw.Font fontB,
    required pw.Font fontM,
    required pw.Font fontR,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: _white,
        borderRadius: pw.BorderRadius.circular(7),
        border: pw.Border(left: pw.BorderSide(color: color, width: 3.5)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title, style: pw.TextStyle(font: fontB, fontSize: 9.5, color: _gray800)),
          pw.Text(sub, style: pw.TextStyle(font: fontM, fontSize: 8, color: color)),
          pw.SizedBox(height: 3),
          pw.Text(desc, style: pw.TextStyle(font: fontR, fontSize: 7.5, color: _gray500, lineSpacing: 1.3)),
        ],
      ),
    );
  }

  static pw.Widget _summaryMetric(String val, String label, PdfColor color, pw.Font eb, pw.Font m) {
    return pw.Expanded(
      child: pw.Column(
        children: [
          pw.Text(val, style: pw.TextStyle(font: eb, fontSize: 13, color: color)),
          pw.SizedBox(height: 2),
          pw.Text(label, style: pw.TextStyle(font: m, fontSize: 7, color: _gray500), textAlign: pw.TextAlign.center),
        ],
      ),
    );
  }

  static pw.Widget _metricDivider() {
    return pw.Container(width: 0.8, height: 24, color: _gray200, margin: const pw.EdgeInsets.symmetric(horizontal: 4));
  }

  static pw.Widget _osiLayerRow(String layer, String desc, PdfColor color, pw.Font b, pw.Font r) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 5),
      child: pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: pw.BoxDecoration(
          color: _white,
          borderRadius: pw.BorderRadius.circular(6),
          border: pw.Border(left: pw.BorderSide(color: color, width: 3.5)),
        ),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(
              width: 140,
              child: pw.Text(layer, style: pw.TextStyle(font: b, fontSize: 8, color: color)),
            ),
            pw.SizedBox(width: 8),
            pw.Expanded(
              child: pw.Text(desc, style: pw.TextStyle(font: r, fontSize: 7.5, color: _gray800, lineSpacing: 1.25)),
            ),
          ],
        ),
      ),
    );
  }

  static pw.Widget _metricCard(String label, String value, String sub, PdfColor color, pw.Font eb, pw.Font b, pw.Font r) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(9),
      decoration: pw.BoxDecoration(
        color: _white,
        borderRadius: pw.BorderRadius.circular(7),
        border: pw.Border(top: pw.BorderSide(color: color, width: 3)),
      ),
      child: pw.Column(
        children: [
          pw.Text(value, style: pw.TextStyle(font: eb, fontSize: 13, color: color)),
          pw.SizedBox(height: 2),
          pw.Text(label, style: pw.TextStyle(font: b, fontSize: 7.5, color: _gray800), textAlign: pw.TextAlign.center),
          pw.SizedBox(height: 2),
          pw.Text(sub, style: pw.TextStyle(font: r, fontSize: 6.5, color: _gray500), textAlign: pw.TextAlign.center),
        ],
      ),
    );
  }

  static pw.Widget _projectDossierCard({
    required String no,
    required String title,
    required String period,
    required String role,
    required String desc,
    required List<String> tags,
    required String impact,
    required PdfColor color,
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
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                width: 22, height: 22,
                decoration: pw.BoxDecoration(color: color, shape: pw.BoxShape.circle),
                alignment: pw.Alignment.center,
                child: pw.Text(no, style: pw.TextStyle(font: fontB, fontSize: 9.5, color: _white)),
              ),
              pw.SizedBox(width: 8),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(title, style: pw.TextStyle(font: fontB, fontSize: 9.5, color: _gray800)),
                    pw.Row(children: [
                      pw.Text(role, style: pw.TextStyle(font: fontM, fontSize: 7.5, color: color)),
                      pw.Text('  •  ', style: pw.TextStyle(font: fontR, fontSize: 7.5, color: _gray500)),
                      pw.Text(period, style: pw.TextStyle(font: fontR, fontSize: 7.5, color: _gray500)),
                    ]),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 5),
          pw.Text(desc, style: pw.TextStyle(font: fontR, fontSize: 8, color: _gray800, lineSpacing: 1.35)),
          pw.SizedBox(height: 5),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
            decoration: pw.BoxDecoration(
              color: _purpleL,
              borderRadius: pw.BorderRadius.circular(4),
              border: pw.Border.all(color: PdfColor.fromInt(0xFFDDD6FE), width: 0.6),
            ),
            child: pw.Text(impact, style: pw.TextStyle(font: fontM, fontSize: 7.5, color: _purple)),
          ),
          pw.SizedBox(height: 5),
          pw.Wrap(
            spacing: 4, runSpacing: 3,
            children: tags.map((t) => pw.Container(
              padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: pw.BoxDecoration(color: color, borderRadius: pw.BorderRadius.circular(3)),
              child: pw.Text(t, style: pw.TextStyle(font: fontB, fontSize: 6.5, color: _white)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  static pw.Widget _buildFormalEducationCard(pw.Font b, pw.Font m, pw.Font r, bool isEnglish) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: _white,
        borderRadius: pw.BorderRadius.circular(7),
        border: pw.Border(left: pw.BorderSide(color: _purple, width: 3.5)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      isEnglish
                          ? 'D4 Computer Network Engineering Technology (TRKJ)'
                          : 'D4 Teknologi Rekayasa Komputer Jaringan (TRKJ)',
                      style: pw.TextStyle(font: b, fontSize: 10, color: _gray800),
                    ),
                    pw.Text(
                      isEnglish
                          ? 'Politeknik Negeri Lhokseumawe  •  Department of ICT (2022–2026)'
                          : 'Politeknik Negeri Lhokseumawe  •  Jurusan TIK (2022–2026)',
                      style: pw.TextStyle(font: m, fontSize: 8.5, color: _purple),
                    ),
                  ],
                ),
              ),
              _chip('Cum Laude', _green, b),
            ],
          ),
          pw.SizedBox(height: 7),
          pw.Container(height: 0.8, color: _gray200),
          pw.SizedBox(height: 7),
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _infoLine(isEnglish ? 'Academic Degree' : 'Gelar Akademik', 'Sarjana Terapan Teknik (S.Tr.T.)', b, r),
                    pw.SizedBox(height: 3),
                    _infoLine(isEnglish ? 'Graduation Status' : 'Predikat Kelulusan', 'Cum Laude', b, r, valueColor: _green),
                  ],
                ),
              ),
              pw.SizedBox(width: 12),
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    _infoLine(isEnglish ? 'Defense Date' : 'Lulus Sidang', '29 Juli 2026', b, r),
                    pw.SizedBox(height: 3),
                    _infoLine(isEnglish ? 'Principal Advisor' : 'Pembimbing I', 'Husaini, S.Si., M.IT.', b, r),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 7),
          pw.Container(
            padding: const pw.EdgeInsets.all(8),
            decoration: pw.BoxDecoration(
              color: _purpleL,
              borderRadius: pw.BorderRadius.circular(4),
              border: pw.Border.all(color: PdfColor.fromInt(0xFFDDD6FE), width: 0.8),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  isEnglish ? 'BACHELOR THESIS / SCIENTIFIC RESEARCH:' : 'JUDUL TUGAS AKHIR / SKRIPSI ILMIAH:',
                  style: pw.TextStyle(font: b, fontSize: 7.5, color: _purple),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  isEnglish
                      ? '"Design and Construction of IoT Prototype Smart Home with Rule-Based Decision System as Artificial Intelligence" (STARZAR Application — Complete 7-Layer OSI Model Implementation & HiveMQ Cloud MQTT)'
                      : '"Rancang Bangun IoT pada Prototype Smart Home dengan Penerapan Rule-Based Decision System sebagai Artificial Intelligence" (Aplikasi STARZAR — Implementasi Lengkap 7 OSI Layer & MQTT HiveMQ Cloud)',
                  style: pw.TextStyle(font: r, fontSize: 8, color: _gray800, lineSpacing: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _infoLine(String k, String v, pw.Font b, pw.Font r, {PdfColor? valueColor}) {
    return pw.Row(children: [
      pw.SizedBox(width: 82, child: pw.Text(k, style: pw.TextStyle(font: b, fontSize: 7.5, color: _gray500))),
      pw.Text(': ', style: pw.TextStyle(font: b, fontSize: 7.5, color: _gray500)),
      pw.Expanded(child: pw.Text(v, style: pw.TextStyle(font: b, fontSize: 7.5, color: valueColor ?? _gray800))),
    ]);
  }

  static pw.Widget _awardRow({
    required String no,
    required String title,
    required String issuer,
    required String desc,
    required PdfColor color,
    required pw.Font fontB,
    required pw.Font fontM,
    required pw.Font fontR,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(9),
      decoration: pw.BoxDecoration(
        color: _white,
        borderRadius: pw.BorderRadius.circular(6),
        border: pw.Border(left: pw.BorderSide(color: color, width: 3.5)),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Container(
            width: 19, height: 19,
            decoration: pw.BoxDecoration(color: color, shape: pw.BoxShape.circle),
            alignment: pw.Alignment.center,
            child: pw.Text(no, style: pw.TextStyle(font: fontB, fontSize: 8.5, color: _white)),
          ),
          pw.SizedBox(width: 8),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(title, style: pw.TextStyle(font: fontB, fontSize: 8.5, color: _gray800)),
                pw.Text(issuer, style: pw.TextStyle(font: fontM, fontSize: 7.5, color: color)),
                pw.SizedBox(height: 2),
                pw.Text(desc, style: pw.TextStyle(font: fontR, fontSize: 7.5, color: _gray500, lineSpacing: 1.25)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static pw.Widget _certTag(String title, PdfColor color, pw.Font fontM) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 2.5),
      decoration: pw.BoxDecoration(
        color: color.shade(0.12),
        borderRadius: pw.BorderRadius.circular(3),
        border: pw.Border.all(color: color.shade(0.3), width: 0.6),
      ),
      child: pw.Text(title, style: pw.TextStyle(font: fontM, fontSize: 6.8, color: color)),
    );
  }

  static pw.Widget _skillItem(String name, double pct, PdfColor color, pw.Font fontM, pw.Font fontR) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4.5),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(name, style: pw.TextStyle(font: fontM, fontSize: 7.5, color: _gray800)),
              pw.Text('${(pct * 100).toInt()}%', style: pw.TextStyle(font: fontM, fontSize: 7.5, color: color)),
            ],
          ),
          pw.SizedBox(height: 1.5),
          pw.Stack(
            children: [
              pw.Container(height: 4.5, decoration: pw.BoxDecoration(color: _gray200, borderRadius: pw.BorderRadius.circular(2.5))),
              pw.Container(height: 4.5, width: 220 * pct, decoration: pw.BoxDecoration(color: color, borderRadius: pw.BorderRadius.circular(2.5))),
            ],
          ),
        ],
      ),
    );
  }

  static pw.Widget _pageFooter(pw.Font r, int page, int total, bool isEnglish) {
    return pw.Container(
      decoration: const pw.BoxDecoration(
        gradient: pw.LinearGradient(
          colors: [_navy, _blueD],
          begin: pw.Alignment.centerLeft,
          end: pw.Alignment.centerRight,
        ),
      ),
      padding: const pw.EdgeInsets.symmetric(horizontal: 28, vertical: 8),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(
            isEnglish
                ? '© 2026 Nazarul Qudri, S.Tr.T.  •  Official Engineering Dossier  •  Protected by UU ITE'
                : '© 2026 Nazarul Qudri, S.Tr.T.  •  Portofolio Rekayasa Resmi  •  Terlindungi UU ITE',
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
