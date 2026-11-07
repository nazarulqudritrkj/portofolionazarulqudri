import 'package:flutter/material.dart';

enum AppLanguage { id, en }

class LocaleController extends ChangeNotifier {
  static final LocaleController instance = LocaleController._();
  LocaleController._();

  AppLanguage _currentLanguage = AppLanguage.id; // Default to Indonesian
  AppLanguage get currentLanguage => _currentLanguage;

  bool get isIndonesian => _currentLanguage == AppLanguage.id;
  bool get isEnglish => _currentLanguage == AppLanguage.en;

  void toggleLanguage() {
    _currentLanguage = isIndonesian ? AppLanguage.en : AppLanguage.id;
    notifyListeners();
  }

  void setLanguage(AppLanguage language) {
    if (_currentLanguage != language) {
      _currentLanguage = language;
      notifyListeners();
    }
  }
}

class AppStrings {
  final AppLanguage lang;
  AppStrings(this.lang);

  bool get isId => lang == AppLanguage.id;

  // Navigation
  String get navHome => isId ? 'Beranda' : 'Home';
  String get navAbout => isId ? 'Tentang' : 'About';
  String get navProjects => isId ? 'Proyek' : 'Projects';
  String get navCertificates => isId ? 'Sertifikasi' : 'Certifications';
  String get navSkills => isId ? 'Keahlian' : 'Skills';
  String get navContact => isId ? 'Kontak' : 'Contact';
  String get letsTalk => isId ? 'Hubungi Saya' : "Let's Talk";
  String get portfolioTitle => isId ? 'Portofolio Profesional' : 'Professional Portfolio';

  // Hero Section
  String get statusAvailable =>
      isId ? 'Terbuka untuk Peluang Baru & Proyek' : 'Available for New Opportunities';
  String get heroGreeting => isId ? 'Halo, Saya ' : "Hi, I'm ";
  String get heroRole => isId
      ? 'Flutter Developer & IoT Solutions Specialist'
      : 'Flutter Specialist & IoT Solutions Engineer';
  String get heroTagline => isId
      ? 'Membangun Pengalaman Digital Berkinerja Tinggi & Solusi Modern Bersih'
      : 'Crafting High-Performance Digital Experiences & Clean Modern Solutions';
  String get heroBio => isId
      ? 'Software Engineer & Spesialis Flutter dengan keahlian mendalam dalam arsitektur aplikasi mobile, web, integrasi perangkat IoT real-time, serta antarmuka modern Clean Island.'
      : 'Passionate Software Engineer & Flutter Specialist with extensive experience in architecting cross-platform mobile, web, and IoT-integrated solutions.';
  String get viewWorks => isId ? 'Lihat Portofolio' : 'View My Works';
  String get downloadCv => isId ? 'Unduh CV / Resume' : 'Download CV';
  String get specializedIn => isId ? 'KEAHLIAN UTAMA:' : 'SPECIALIZED IN:';
  String get expYearsLabel => isId ? 'Pengalaman' : 'Experience';
  String get projectsDoneLabel => isId ? 'Proyek Selesai' : 'Projects Done';
  String get certsLabel => isId ? 'Sertifikasi Resmi' : 'Certifications';
  String get codeQualityLabel => isId ? 'Kualitas Kode' : 'Code Quality';

  // About Section
  String get aboutTag => isId ? 'Tentang & Rekam Jejak' : 'About & Journey';
  String get aboutTitle => isId
      ? 'Membangun dengan Tujuan & Ketelitian Tinggi'
      : 'Engineering With Purpose & Precision';
  String get aboutSubtitle => isId
      ? 'Menerjemahkan logika bisnis yang kompleks dan protokol perangkat keras menjadi antarmuka digital yang intuitif, elegan, dan berkinerja tinggi.'
      : 'Transforming complex business logic and hardware protocols into intuitive, elegant, and high-performance digital solutions.';
  String get aboutBioP1 => isId
      ? 'Halo! Saya Nazarul Qudri, Sarjana Terapan Teknologi Rekayasa Komputer Jaringan (TRKJ) Jurusan Teknologi Informasi dan Komputer Politeknik Negeri Lhokseumawe. Saya berfokus pada rekayasa sistem siber-fisik (IoT CPS), arsitektur 7 OSI Layer, pengembangan web akademik, dan aplikasi Flutter berkinerja tinggi.'
      : 'Hello! I am Nazarul Qudri, a Computer Network Engineering Technology graduate from Politeknik Negeri Lhokseumawe. I specialize in Cyber-Physical Systems (IoT CPS), 7 OSI Layer architecture, academic web systems, and high-performance cross-platform Flutter applications.';
  String get aboutBioP2 => isId
      ? 'Dalam skripsi dan karya rekayasa saya, saya mengimplementasikan sistem otomasi cerdas seperti Rule-Based Decision System (RBDS), protokol komunikasi MQTT HiveMQ Cloud, arsitektur database terdistribusi, serta standar komunikasi data internasional ITU-T Y.1010/G.1010.'
      : 'Across my thesis and engineering endeavors, I implement intelligent automation including Rule-Based Decision Systems (RBDS), MQTT HiveMQ Cloud protocols, distributed local databases, and ITU-T Y.1010/G.1010 international data quality standards.';
  String get downloadFullResume => isId ? 'Unduh Resume Lengkap' : 'Download Complete Resume';
  String get pillar1Title => isId ? 'Clean Architecture Utama' : 'Clean Architecture First';
  String get pillar1Desc => isId
      ? 'Pemisahan domain layer, BLoC / Riverpod state management yang kokoh, dan pola repository untuk keterawatan maksimal.'
      : 'Decoupled domain layers, robust BLoC / Riverpod state handlers, and repository patterns that guarantee high maintainability.';
  String get pillar2Title => isId ? 'Integrasi Hardware & IoT' : 'Hardware & IoT Symphony';
  String get pillar2Desc => isId
      ? 'Menghubungkan mikrokontroler (ESP32, Arduino) dengan pipa data telemetri MQTT dan WebSocket berkecepatan tinggi.'
      : 'Bridging physical sensor devices (ESP32, Arduino) with real-time MQTT and WebSocket telemetry pipelines.';
  String get pillar3Title => isId ? 'Antarmuka Halus 60/120 FPS' : 'Fluid 60 / 120 FPS Experience';
  String get pillar3Desc => isId
      ? 'Optimasi siklus render widget, efek glassmorphism, dan mikro-interaksi untuk kelancaran visual tingkat tinggi.'
      : 'Tuned widget rebuild cycles, custom painter shaders, and micro-interactions delivering native desktop and mobile fluidity.';
  String get timelineTitle => isId ? 'TIMELINE PENGALAMAN & PENDIDIKAN' : 'EXPERIENCE & EDUCATION TIMELINE';

  // Academic Credentials Section (Ijazah & Transkrip)
  String get academicTag => isId ? 'Kredensial Akademik Resmi' : 'Official Academic Credentials';
  String get academicTitle => isId
      ? 'Ijazah Pendidikan Tinggi & Transkrip Nilai'
      : 'Higher Education Degree & Academic Transcripts';
  String get academicSubtitle => isId
      ? 'Kualifikasi formal sarjana terapan program studi Teknologi Rekayasa Komputer Jaringan (TRKJ) dengan predikat unggul dan terakreditasi.'
      : 'Official qualifications in Computer Network Engineering Technology, fully accredited with strong academic performance.';
  String get viewDegree => isId ? 'Buka Salinan Ijazah Resmi' : 'View Official Degree Certificate';
  String get viewTranscript => isId ? 'Buka Transkrip Nilai Lengkap' : 'View Full Academic Transcript';

  // Competitions & Honors Section
  String get competitionsTag => isId ? 'Prestasi & Kejuaraan Nasional' : 'Honors & National Competitions';
  String get competitionsTitle => isId
      ? 'Kejuaraan, Kompetisi & Olimpiade Sains'
      : 'Championships, Olympiads & Awards';
  String get competitionsSubtitle => isId
      ? 'Pencapaian kompetitif di ajang bergengsi nasional seperti KMIPN (Informatika Politeknik Nasional), NSO Bahasa Inggris, OSPN Akuntansi, dan OSH Bahasa Indonesia.'
      : 'Distinguished competitive milestones in national polytechnic informatics championships (KMIPN), science olympiads, and humanities honors.';
  String get viewAward => isId ? 'Lihat Piagam Penghargaan' : 'View Award Certificate';

  // Certifications Section (11 Pelatihan Keahlian)
  String get certsTag => isId ? 'Kredensial & Pelatihan Resmi' : 'Official Certifications & Training';
  String get certsTitle => isId
      ? '11 Sertifikasi Pelatihan Profesional'
      : '11 Professional Training Certifications';
  String get certsSubtitle => isId
      ? 'Bukti kompetensi terverifikasi dari Kementerian Kominfo (Digital Talent Scholarship) dan lembaga terakreditasi di bidang AI, Keamanan Siber, Cloud, Desain Produk, dan Komputasi.'
      : 'Verified credentials in AI Engineering, Cybersecurity, Cloud Computing, Product Design, and Computational Thinking from authorized academies & ministries.';
  String get viewCertificateDetail => isId ? 'Lihat Sertifikat Lengkap' : 'View Full Certificate';
  String get page1Front => isId ? 'Halaman 1 (Sertifikat)' : 'Page 1 (Certificate)';
  String get page2Back => isId ? 'Halaman 2 (Materi / Jam)' : 'Page 2 (Curriculum / Hours)';
  String get tapToZoom => isId ? 'Ketuk atau geser untuk melihat kedua halaman' : 'Tap or pinch to inspect both pages';
  String get close => isId ? 'Tutup' : 'Close';

  // Projects Section
  String get projectsTag => isId ? 'Karya Unggulan' : 'Featured Work';
  String get projectsTitle => isId
      ? 'Portofolio Proyek & Solusi Rekayasa'
      : 'Selected Projects & Engineering Highlights';
  String get projectsSubtitle => isId
      ? 'Jelajahi aplikasi mobile, sistem IoT terdistribusi, dan integrasi cloud yang dirancang untuk performa dan keandalan tinggi.'
      : 'Explore high-impact mobile solutions, IoT systems, and clean cloud integrations engineered for maximum reliability and delight.';
  String get allWorks => isId ? 'Semua Karya' : 'All Works';
  String get mobileApps => isId ? 'Aplikasi Mobile' : 'Mobile Apps';
  String get iotHardware => isId ? 'IoT & Hardware' : 'IoT & Edge';
  String get fullStack => isId ? 'Full-Stack' : 'Full-Stack';
  String get aiVision => isId ? 'AI & Visi Komputer' : 'AI & Vision';
  String get viewDetails => isId ? 'Lihat Detail Proyek' : 'View Details';
  String get launchDemo => isId ? 'Buka Demo Langsung' : 'Launch Live Demo';
  String get exploreRepo => isId ? 'Buka Repositori GitHub' : 'Explore Repository';

  // Skills Section
  String get skillsTag => isId ? 'Keahlian Teknis' : 'Technical Mastery';
  String get skillsTitle => isId
      ? 'Keahlian, Framework & Protokol'
      : 'Skills, Frameworks & Hardware Protocols';
  String get skillsSubtitle => isId
      ? 'Kombinasi teknologi yang telah teruji dalam menangani aplikasi berskala tinggi, komunikasi sensor real-time, dan cloud modern.'
      : 'A battle-tested stack refined over years of building high-concurrency mobile apps, real-time IoT networks, and modern cloud interfaces.';
  String get allCapabilities => isId ? 'Semua Kemampuan' : 'All Capabilities';

  // Contact Section
  String get contactTag => isId ? 'Mari Terhubung' : "Let's Connect";
  String get contactTitle => isId
      ? 'Siap Mewujudkan Proyek Luar Biasa Bersama?'
      : 'Ready to Build Something Extraordinary Together?';
  String get contactSubtitle => isId
      ? 'Punya ide produk baru, kebutuhan arsitektur mobile/IoT, atau peluang kerja sama? Hubungi saya langsung atau kirimkan pesan.'
      : 'Have a new product idea, architecture consultation, or engineering role? Feel free to reach out directly or submit your inquiry below.';
  String get directChannels => isId ? 'Kontak Langsung' : 'Direct Channels';
  String get directChannelsDesc => isId
      ? 'Saya selalu antusias berdiskusi mengenai rekayasa perangkat lunak, sistem IoT cerdas, dan aplikasi Flutter.'
      : 'I am always excited to discuss software design, mobile applications, and IoT innovations.';
  String get yourName => isId ? 'NAMA LENGKAP' : 'YOUR FULL NAME';
  String get emailAddress => isId ? 'ALAMAT EMAIL' : 'EMAIL ADDRESS';
  String get projectTopic => isId ? 'TOPIK PROYEK / KEPERLUAN' : 'PROJECT TOPIC / INQUIRY';
  String get yourMessage => isId ? 'PESAN & DETAIL KEBUTUHAN' : 'YOUR MESSAGE & REQUIREMENTS';
  String get sendMessage => isId ? 'Kirim Pesan Sekarang' : 'Send Message Now';
  String get messageSuccess => isId
      ? 'Terima kasih! Pesan Anda telah berhasil terkirim. Saya akan segera merespons.'
      : 'Thank you! Your message has been sent successfully. I will get back to you shortly.';
  String get sendAnother => isId ? 'Kirim Pesan Lainnya' : 'Send Another Message';
  String get nameValidation => isId ? 'Silakan masukkan nama Anda' : 'Please enter your name';
  String get emailValidation => isId ? 'Silakan masukkan email yang valid' : 'Please enter a valid email address';
  String get topicValidation => isId ? 'Silakan masukkan topik' : 'Please enter the project topic';
  String get messageValidation => isId ? 'Deskripsi minimal 10 karakter' : 'Please provide at least 10 characters';

  // Footer
  String get backToTop => isId ? 'Kembali ke Atas' : 'Back to Top';
  String get copyrightNote => isId
      ? 'Dirancang dengan Arsitektur Clean Island • Flutter Web Responsif'
      : 'Architected with Flutter Web • Clean Island Design System';
}

