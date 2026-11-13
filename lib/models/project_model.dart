import 'package:flutter/material.dart';

enum ProjectCategory {
  all('Semua Proyek (4)', 'All Projects (4)'),
  iot('IoT & Skripsi STARZAR', 'IoT & STARZAR Thesis'),
  academicSystem('Sistem Informasi Kampus PNL', 'PNL Academic Systems');

  final String labelId;
  final String labelEn;
  const ProjectCategory(this.labelId, this.labelEn);

  String getLabel(bool isEn) => isEn ? labelEn : labelId;
}

class ProjectModel {
  final String id;
  final String title;
  final String? titleEn;
  final String subtitle;
  final String? subtitleEn;
  final String description;
  final String? descriptionEn;
  final String fullDescription;
  final String? fullDescriptionEn;
  final ProjectCategory category;
  final List<String> tags;
  final List<String> keyFeatures;
  final List<String>? keyFeaturesEn;
  final String? githubUrl;
  final String? liveUrl;
  final IconData icon;
  final Color primaryColor;
  final Color accentColor;
  final String metric;
  final String? metricEn;

  const ProjectModel({
    required this.id,
    required this.title,
    this.titleEn,
    required this.subtitle,
    this.subtitleEn,
    required this.description,
    this.descriptionEn,
    required this.fullDescription,
    this.fullDescriptionEn,
    required this.category,
    required this.tags,
    required this.keyFeatures,
    this.keyFeaturesEn,
    this.githubUrl,
    this.liveUrl,
    required this.icon,
    required this.primaryColor,
    required this.accentColor,
    required this.metric,
    this.metricEn,
  });

  String getTitle(bool isEn) => (isEn && titleEn != null) ? titleEn! : title;
  String getSubtitle(bool isEn) => (isEn && subtitleEn != null) ? subtitleEn! : subtitle;
  String getDescription(bool isEn) => (isEn && descriptionEn != null) ? descriptionEn! : description;
  String getFullDescription(bool isEn) => (isEn && fullDescriptionEn != null) ? fullDescriptionEn! : fullDescription;
  List<String> getKeyFeatures(bool isEn) => (isEn && keyFeaturesEn != null) ? keyFeaturesEn! : keyFeatures;
  String getMetric(bool isEn) => (isEn && metricEn != null) ? metricEn! : metric;

  static List<ProjectModel> get sampleProjects => [
    // 1. STARZAR (Smart Exclusive Home) IoT & AI - Skripsi TRKJ PNL
    const ProjectModel(
      id: 'starzar-smart-home-iot-skripsi',
      title: 'STARZAR - Smart Exclusive Home IoT & AI',
      titleEn: 'STARZAR - Smart Exclusive Home IoT & AI',
      subtitle: 'Proyek Skripsi: Penerapan 7 Lapisan Model OSI & AI Rule-Based System',
      subtitleEn: 'Bachelor Thesis: Full 7-Layer OSI Model Implementation & AI Rule-Based System',
      description:
          'Sistem siber-fisik (Cyber-Physical System) smart home terpadu berbasis mikrokontroler ESP32, broker HiveMQ Cloud, dan aplikasi Android Flutter STARZAR dengan penerapan lengkap 7 Lapisan OSI Layer.',
      descriptionEn:
          'Integrated cyber-physical smart home system powered by ESP32 microcontrollers, HiveMQ Cloud MQTT broker, and STARZAR Flutter Android application implementing all 7 OSI Layers.',
      fullDescription:
          'Proyek Skripsi Sarjana Terapan Teknik (S.Tr.T.) Program Studi D4 Teknologi Rekayasa Komputer Jaringan (TRKJ), Jurusan Teknologi Informasi dan Komputer (TIK) Politeknik Negeri Lhokseumawe (2026) oleh Nazarul Qudri, S.Tr.T.\n\n'
          'Sistem ini mengintegrasikan mikrokontroler ESP32 multi-zona (Dapur, Ruang Tamu, dan Kamar Mandi) dengan sensor DHT22, MQ-2, MQ-135, Flame IR, dan HC-SR04 untuk mitigasi kebakaran, stabilitas suhu, dan manajemen air otomatis.\n\n'
          '■ IMPLEMENTASI LENGKAP 7 LAPISAN MODEL OSI:\n'
          '• Layer 7 (Application Layer): Aplikasi Android Flutter STARZAR & protokol MQTT dengan kontrol manual (manual override), autentikasi biometrik sidik jari, monitoring grafik real-time, notifikasi pop-up mode senyap, dan ekspor data XLSX.\n'
          '• Layer 6 (Presentation Layer): Enkapsulasi data telemetri berformat JSON String dan serialisasi basis data lokal Hive.\n'
          '• Layer 5 (Session Layer): Manajemen sesi komunikasi nirkabel Publish/Subscribe antara publisher ESP32 dan subscriber Flutter via HiveMQ Cloud.\n'
          '• Layer 4 (Transport Layer): Protokol Transmission Control Protocol (TCP) yang menjamin keandalan pengiriman dengan Packet Loss 0%.\n'
          '• Layer 3 (Network Layer): Internet Protocol (IP) untuk pengalamatan perangkat dan routing jaringan antar-node.\n'
          '• Layer 2 (Data Link Layer): Standar IEEE 802.11 (Wi-Fi Protocol) untuk manajemen frame dan verifikasi MAC address.\n'
          '• Layer 1 (Physical Layer): Modul radio Wi-Fi ESP32, antena pemancar, modul sensor lingkungan, dan modul relay 4-channel & 2-channel.\n\n'
          '■ HASIL PENGUJIAN ILMIAH:\n'
          '• Tingkat Keberhasilan Keputusan AI (Rule-Based): 100% pada 10 skenario pengujian darurat.\n'
          '• Rata-rata System Response Time: 180 ms (Jauh di bawah batas toleransi ITU-T Y.1010 < 2000 ms).\n'
          '• Kinerja QoS (ITU-T Y.1010/G.1010): Throughput 4.8 kbps, Delay 180 ms, Packet Loss 0%, Jitter 12 ms.\n'
          '• Akurasi pembacaan sensor rata-rata: Di atas 96%.',
      fullDescriptionEn:
          'Bachelor of Applied Engineering (S.Tr.T.) Thesis Project at D4 Computer Network Engineering Technology (TRKJ), Department of Information and Computer Technology (TIK), Politeknik Negeri Lhokseumawe (2026) by Nazarul Qudri, S.Tr.T.\n\n'
          'This system coordinates multi-zone ESP32 microcontrollers (Kitchen, Living Room, and Bathroom) integrated with DHT22, MQ-2, MQ-135, Flame IR, and HC-SR04 sensors for proactive fire mitigation, environmental temperature stability, and automatic water management.\n\n'
          '■ FULL 7-LAYER OSI MODEL ARCHITECTURAL IMPLEMENTATION:\n'
          '• Layer 7 (Application Layer): Flutter STARZAR Android app & MQTT protocol with manual override controls, biometric fingerprint authentication, live telemetric graphs, silent pop-up alarms, and tabular XLSX exports.\n'
          '• Layer 6 (Presentation Layer): JSON String telemetry encapsulation and serialization for local Hive database persistence.\n'
          '• Layer 5 (Session Layer): Wireless Publish/Subscribe session management between ESP32 publishers and Flutter subscribers through HiveMQ Cloud.\n'
          '• Layer 4 (Transport Layer): Transmission Control Protocol (TCP) ensuring zero packet loss (0% Packet Loss).\n'
          '• Layer 3 (Network Layer): Internet Protocol (IP) for discrete node addressing and subnet routing.\n'
          '• Layer 2 (Data Link Layer): IEEE 802.11 Wi-Fi standard for wireless frame handling and hardware MAC validation.\n'
          '• Layer 1 (Physical Layer): ESP32 Wi-Fi radio transceiver, antenna, environmental sensing modules, and multi-channel relay modules.\n\n'
          '■ SCIENTIFIC BENCHMARK RESULTS:\n'
          '• AI Decision Engine Success Rate: 100% across 10 distinct emergency scenarios.\n'
          '• Average System Response Time: 180 ms (well within ITU-T Y.1010 tolerance < 2000 ms).\n'
          '• QoS Performance (ITU-T Y.1010/G.1010): Throughput 4.8 kbps, Latency 180 ms, Packet Loss 0%, Jitter 12 ms.\n'
          '• Sensor calibration accuracy: Above 96% across all nodes.',
      category: ProjectCategory.iot,
      tags: ['Flutter', 'ESP32', '7 OSI Layer', 'MQTT HiveMQ', 'AI Rule-Based', 'Hive DB', 'Smart Home'],
      keyFeatures: [
        'Penerapan Arsitektur 7 Lapisan Model OSI secara penuh (Layer 1 s/d Layer 7)',
        'Inference Engine AI Rule-Based Decision System (Forward Chaining) dengan 100% akurasi',
        'Response Time sangat cepat 180 ms & QoS standar ITU-T Y.1010/G.1010 (Packet Loss 0%)',
        'Fitur aplikasi STARZAR: Biometrik Sidik Jari, Notifikasi Pop-up Mode Senyap, & Ekspor Excel (.xlsx)',
      ],
      keyFeaturesEn: [
        'Complete 7-Layer OSI Model architectural design (Layer 1 to Layer 7)',
        'AI Rule-Based Decision System (Forward Chaining) with 100% decision accuracy',
        'Ultra-fast 180 ms response time & ITU-T Y.1010/G.1010 QoS benchmark (0% Packet Loss)',
        'STARZAR app features: Biometric Auth, Silent Pop-up Alerts, & Excel (.xlsx) Export',
      ],
      icon: Icons.home_repair_service_rounded,
      primaryColor: Color(0xFF0284C7),
      accentColor: Color(0xFF38BDF8),
      metric: '100% AI • 180ms Latency',
      metricEn: '100% AI • 180ms Latency',
    ),

    // 2. Website Sistem Informasi dan Pendaftaran Kuliah Umum Jurusan TIK PNL (2025 - 2026)
    const ProjectModel(
      id: 'si-kuliah-umum-tik-pnl',
      title: 'Sistem Informasi & Pendaftaran Kuliah Umum TIK PNL',
      titleEn: 'TIK PNL Public Lecture & Registration Web System',
      subtitle: 'Website Pendaftaran & Manajemen Kuliah Umum Jurusan TIK 2025 - 2026',
      subtitleEn: 'Web Platform for Guest Lecture Registration & Management 2025 - 2026',
      description:
          'Portal web pendaftaran, registrasi peserta, absensi kehadiran digital, dan pengelolaan agenda kuliah tamu / seminar akademik Jurusan Teknologi Informasi dan Komputer Politeknik Negeri Lhokseumawe.',
      descriptionEn:
          'Web portal for participant registration, digital attendance logging, and event agenda management for guest lectures and seminars at TIK PNL.',
      fullDescription:
          'Platform web terpadu yang dirancang untuk mengotomasi alur pendaftaran dan pelaksanaan kuliah umum tahun akademik 2025 - 2026 di Jurusan TIK Politeknik Negeri Lhokseumawe.\n\n'
          'Sistem ini menghubungkan mahasiswa dari berbagai program studi (termasuk TRKJ, Teknik Informatika, dan lainnya) untuk melakukan pendaftaran online, verifikasi kuota otomatis, sistem absensi digital dengan QR Code, serta distribusi sertifikat kehadiran dan materi kuliah tamu secara terpusat.',
      fullDescriptionEn:
          'An integrated web platform engineered to automate participant registration and operational workflows for the 2025 - 2026 academic guest lecture series at the Department of Information and Computer Technology (TIK), Politeknik Negeri Lhokseumawe.\n\n'
          'Connects students across departments (including TRKJ and Informatics Engineering) for self-service online registration, automated quota verification, QR Code digital attendance tracking, and centralized dissemination of speaker modules and verified e-certificates.',
      category: ProjectCategory.academicSystem,
      tags: ['Web Portal', 'Laravel', 'MySQL', 'REST API', 'QR Absensi', 'TIK PNL'],
      keyFeatures: [
        'Form pendaftaran online mandiri dengan validasi NIM dan Prodi mahasiswa PNL',
        'Sistem verifikasi kuota peserta dan pencatatan presensi kehadiran digital',
        'Distribusi modul narasumber dan integrasi penerbitan e-sertifikat kegiatan',
        'Dashboard administrasi Jurusan TIK untuk rekapitulasi data pendaftar & laporan kegiatan',
      ],
      keyFeaturesEn: [
        'Self-service student registration with automated Student ID (NIM) & major validation',
        'Real-time seat quota verification and digital QR Code attendance logging',
        'Centralized speaker module repository and instant e-certificate generation',
        'Department administrative dashboard for participant analytics and activity reporting',
      ],
      icon: Icons.school_rounded,
      primaryColor: Color(0xFF2563EB),
      accentColor: Color(0xFF60A5FA),
      metric: '1.000+ Mahasiswa TIK',
      metricEn: '1,000+ TIK Students',
    ),

    // 3. Website Sistem Informasi Sertifikat Dosen PNL (2025 - 2026)
    const ProjectModel(
      id: 'si-sertifikat-dosen-pnl',
      title: 'Sistem Informasi Sertifikat Dosen PNL',
      titleEn: 'PNL Faculty Certificate Repository System',
      subtitle: 'Repositori & Manajemen Kredensial Sertifikasi Dosen Politeknik Negeri Lhokseumawe',
      subtitleEn: 'Institutional Credential Archive & Management for Politeknik Negeri Lhokseumawe Faculty',
      description:
          'Sistem informasi repositori digital terpusat untuk pengarsipan, pencarian, dan verifikasi sertifikat kompetensi, keahlian, penelitian, dan pengabdian dosen Politeknik Negeri Lhokseumawe.',
      descriptionEn:
          'Centralized digital archive system for indexing, searching, and validating faculty competency certifications, research credentials, and community service certificates.',
      fullDescription:
          'Sistem informasi berbasis web yang memfasilitasi pengelolaan berkas sertifikat dosen di lingkungan Politeknik Negeri Lhokseumawe periode 2025 - 2026.\n\n'
          'Sistem ini menyediakan repositori digital aman untuk mengarsipkan SK dan sertifikasi kompetensi dosen, verifikasi keabsahan dokumen melalui nomor seri unik, serta mempermudah penyusunan portofolio akreditasi jurusan dan laporan Beban Kerja Dosen (BKD).',
      fullDescriptionEn:
          'Enterprise web-based document repository facilitating the governance and archiving of faculty certification credentials across Politeknik Negeri Lhokseumawe for the 2025 - 2026 term.\n\n'
          'Provides a secure digital vault for storing official decrees and competency licenses, verifiable authenticity via unique document serials and QR codes, streamlining accreditation submissions and academic workload (BKD) reporting.',
      category: ProjectCategory.academicSystem,
      tags: ['Web System', 'Document Repository', 'Security Auth', 'RBAC', 'Audit Trail', 'PNL'],
      keyFeatures: [
        'Repositori digital terenkripsi untuk pengarsipan SK dan sertifikat kompetensi dosen PNL',
        'Fitur verifikasi keaslian dokumen sertifikat dengan nomor identifikasi unik & QR verification',
        'Pelaporan otomatis untuk kebutuhan akreditasi jurusan dan evaluasi institusi',
        'Hak akses bertingkat (Role-Based Access Control) untuk Dosen, Jurusan, dan Pimpinan Kampus',
      ],
      keyFeaturesEn: [
        'Encrypted digital repository for storing faculty decrees and competency certificates',
        'Instant document authenticity verification with unique serial numbers and QR verification',
        'Automated reporting workflows for institutional accreditation and performance audits',
        'Role-Based Access Control (RBAC) for Faculty Members, Departments, and Campus Leadership',
      ],
      icon: Icons.workspace_premium_rounded,
      primaryColor: Color(0xFF0D9488),
      accentColor: Color(0xFF2DD4BF),
      metric: 'Seluruh Dosen PNL',
      metricEn: 'All PNL Faculty',
    ),

    // 4. Website Sistem Informasi Sertifikat Mahasiswa/i Jurusan TIK PNL (2025 - 2026)
    const ProjectModel(
      id: 'si-sertifikat-mahasiswa-tik-pnl',
      title: 'Sistem Informasi Sertifikat Mahasiswa/i TIK PNL',
      titleEn: 'TIK PNL Student Certificate & SKPI Validation System',
      subtitle: 'Portal Penerbitan & Validasi E-Sertifikat Digital Mahasiswa TIK PNL',
      subtitleEn: 'Digital E-Certificate Issuance & Verification Portal for TIK Students',
      description:
          'Sistem manajemen sertifikat digital terpadu untuk menerbitkan, menyimpan, dan memvalidasi keaslian e-sertifikat kegiatan akademik, workshop, kepanitiaan, dan perlombaan mahasiswa Jurusan TIK PNL.',
      descriptionEn:
          'Integrated digital certificate platform to generate, archive, and validate e-certificates for academic workshops, committee honors, and student competitions.',
      fullDescription:
          'Portal web resmi yang memfasilitasi penerbitan e-sertifikat digital bagi seluruh mahasiswa/i Jurusan Teknologi Informasi dan Komputer Politeknik Negeri Lhokseumawe.\n\n'
          'Platform ini mengintegrasikan database mahasiswa dengan generator e-sertifikat otomatis, validasi keabsahan dokumen menggunakan QR Code anti-pemalsuan, serta pencatatan riwayat prestasi untuk mendukung Surat Keterangan Pendamping Ijazah (SKPI).',
      fullDescriptionEn:
          'Official institutional portal facilitating the issuance and verification of tamper-proof e-certificates for students of the Department of Information and Computer Technology (TIK), Politeknik Negeri Lhokseumawe.\n\n'
          'Integrates student records with dynamic PDF generation, anti-counterfeit QR Code verification, and comprehensive extracurricular achievement tracking to support the Diploma Supplement (SKPI).',
      category: ProjectCategory.academicSystem,
      tags: ['E-Certificate', 'QR Validation', 'SKPI Integration', 'Web Platform', 'TIK PNL'],
      keyFeatures: [
        'Generator e-sertifikat dinamis otomatis dengan nomor registrasi unik kampus',
        'Fitur verifikasi keabsahan dokumen instan via scan QR code anti-pemalsuan',
        'Akses mandiri bagi mahasiswa untuk mengunduh riwayat portofolio sertifikat kegiatan',
        'Dashboard monitoring rekapitulasi capaian prestasi mahasiswa bagi pengelola program studi',
      ],
      keyFeaturesEn: [
        'Dynamic automated e-certificate generator with unique institutional registration numbers',
        'Instant document verification via cryptographic QR code scanning to eliminate falsification',
        'Self-service student portal to view and download historical achievement credentials',
        'Department leadership analytics dashboard for monitoring student co-curricular milestones',
      ],
      icon: Icons.card_membership_rounded,
      primaryColor: Color(0xFF7C3AED),
      accentColor: Color(0xFFA78BFA),
      metric: 'Mahasiswa/i TIK PNL',
      metricEn: 'TIK PNL Students',
    ),
  ];
}
