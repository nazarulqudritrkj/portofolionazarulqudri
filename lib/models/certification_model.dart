import 'package:flutter/material.dart';

enum CertificationCategory {
  all('Semua', 'All'),
  academic('Ijazah & Transkrip', 'Degree & Transcript'),
  competitions('Prestasi & Lomba', 'Competitions & Awards'),
  aiTech('AI & Komputasi', 'AI & Computing'),
  cloudSecurity('Cloud & Security', 'Cloud & Security'),
  digitalProduct('Produk & Desain', 'Product & Design'),
  strategy('Strategi & Konten', 'Strategy & Media');

  final String labelId;
  final String labelEn;
  const CertificationCategory(this.labelId, this.labelEn);
}

class CertificationModel {
  final String id;
  final String titleId;
  final String titleEn;
  final String issuer;
  final String year;
  final CertificationCategory category;
  final String frontImage;
  final String backImage;
  final List<String> skills;
  final String descriptionId;
  final String descriptionEn;
  final IconData icon;
  final Color accentColor;

  const CertificationModel({
    required this.id,
    required this.titleId,
    required this.titleEn,
    required this.issuer,
    required this.year,
    required this.category,
    required this.frontImage,
    required this.backImage,
    required this.skills,
    required this.descriptionId,
    required this.descriptionEn,
    required this.icon,
    required this.accentColor,
  });

  static List<CertificationModel> get allCertifications => [
    const CertificationModel(
      id: 'cert-ijazah-resmi',
      titleId: 'Ijazah Resmi Pendidikan Tinggi - Teknologi Rekayasa Komputer Jaringan',
      titleEn: 'Official Degree Certificate - Computer Network Engineering Technology',
      issuer: 'Kementerian Pendidikan Tinggi, Riset & Teknologi',
      year: 'Dokumen Resmi',
      category: CertificationCategory.academic,
      frontImage: 'lib/images/ijazah/ijazah_nazarul_qudri_id.png',
      backImage: 'lib/images/ijazah/ijazah_nazarul_qudri_en.png',
      skills: ['Sarjana Terapan / Diploma', 'Network Engineering', 'Software Architecture', 'Accredited'],
      descriptionId:
          'Salinan digital Ijazah resmi perguruan tinggi program studi Teknologi Rekayasa Komputer Jaringan (TRKJ). Dilengkapi versi Bahasa Indonesia dan versi Terjemahan Bahasa Inggris resmi.',
      descriptionEn:
          'Digital copy of official higher education degree certificate in Computer Network Engineering Technology. Includes both the official Indonesian and certified English translation.',
      icon: Icons.school_rounded,
      accentColor: Color(0xFF0284C7),
    ),
    const CertificationModel(
      id: 'cert-transkrip-akademik',
      titleId: 'Transkrip Nilai Akademik Lengkap & Kumulatif',
      titleEn: 'Official Cumulative Academic Transcript of Records',
      issuer: 'Bagian Akademik & Kemahasiswaan Perguruan Tinggi',
      year: 'Dokumen Resmi',
      category: CertificationCategory.academic,
      frontImage: 'lib/images/transkripnilai/transkrip_nilai_nazarul_qudri_id.png',
      backImage: 'lib/images/transkripnilai/transkrip_nilai_nazarul_qudri_en.png',
      skills: ['Cumulative GPA / IPK', 'Software Engineering', 'Network Security', 'IoT Architecture'],
      descriptionId:
          'Transkrip nilai akademik kumulatif resmi yang memuat seluruh nilai mata kuliah rekayasa komputer, algoritma, pemrograman, dan jaringan. Tersedia dalam versi Indonesia dan Inggris.',
      descriptionEn:
          'Official cumulative academic transcript of records detailing all completed coursework in computer engineering, algorithms, programming, and network systems in Indonesian and English.',
      icon: Icons.receipt_long_rounded,
      accentColor: Color(0xFF2563EB),
    ),
    const CertificationModel(
      id: 'cert-kmipn-2025',
      titleId: 'KMIPN VI - Kompetisi Mahasiswa Informatika Politeknik Nasional',
      titleEn: 'KMIPN VI - National Polytechnic Informatics Competition',
      issuer: 'Baklma Kemendikbudristek & Forum Direktur Politeknik',
      year: '2025',
      category: CertificationCategory.competitions,
      frontImage:
          'lib/images/sertifikasi_perlombaan/lombakmipn2025/sertifikat_lomba_kmipn.jpg',
      backImage:
          'lib/images/sertifikasi_perlombaan/lombakmipn2025/sertifikat_lomba_kmipn.jpg',
      skills: ['Informatics', 'Problem Solving', 'Competitive Tech', 'Software Innovation'],
      descriptionId:
          'Partisipasi dan prestasi dalam ajang bergengsi kompetisi nasional informatika antarmahasiswa politeknik se-Indonesia di bidang inovasi perangkat lunak dan teknologi terapan.',
      descriptionEn:
          'Participation and prestigious achievement in the Indonesian National Polytechnic Student Informatics Competition in applied technology and software innovation.',
      icon: Icons.emoji_events_rounded,
      accentColor: Color(0xFFF59E0B),
    ),
    const CertificationModel(
      id: 'cert-nso5-english',
      titleId: 'NSO 5 - National Science Olympiad Bidang Bahasa Inggris',
      titleEn: 'NSO 5 - National Science Olympiad in English',
      issuer: 'Pusat Prestasi Nasional / Penyelenggara NSO',
      year: '2025',
      category: CertificationCategory.competitions,
      frontImage:
          'lib/images/sertifikasi_perlombaan/lombaenglish/sertifikat_lomba_english.jpg',
      backImage:
          'lib/images/sertifikasi_perlombaan/lombaenglish/sertifikat_lomba_english.jpg',
      skills: ['English Proficiency', 'Critical Reading', 'Analytical Thinking', 'National Olympiad'],
      descriptionId:
          'Sertifikat penghargaan atas partisipasi dan keunggulan kompetitif dalam Olimpiade Sains Nasional ke-5 bidang kemampuan Bahasa Inggris.',
      descriptionEn:
          'Certificate of recognition for outstanding competitive performance and English language proficiency in the 5th National Science Olympiad.',
      icon: Icons.military_tech_rounded,
      accentColor: Color(0xFF3B82F6),
    ),
    const CertificationModel(
      id: 'cert-ospn-akuntansi',
      titleId: 'OSPN - Olimpiade Sains Pemuda Nasional Bidang Akuntansi',
      titleEn: 'OSPN - National Youth Science Olympiad in Accounting',
      issuer: 'Lembaga Prestasi Pemuda Nasional',
      year: '2025',
      category: CertificationCategory.competitions,
      frontImage:
          'lib/images/sertifikasi_perlombaan/lombaakuntansi/sertifikat_lomba_akuntansi.jpg',
      backImage:
          'lib/images/sertifikasi_perlombaan/lombaakuntansi/sertifikat_lomba_akuntansi.jpg',
      skills: ['Financial Logic', 'Quantitative Analysis', 'Accounting System', 'National Olympiad'],
      descriptionId:
          'Piagam prestasi nasional bidang akuntansi dan analisis finansial yang membuktikan ketajaman logika kuantitatif dan penalaran analitis berstandar nasional.',
      descriptionEn:
          'National achievement certificate in accounting and financial analysis, demonstrating strong quantitative reasoning and analytical logic.',
      icon: Icons.account_balance_rounded,
      accentColor: Color(0xFF10B981),
    ),
    const CertificationModel(
      id: 'cert-osh-bahasaindonesia',
      titleId: 'Piagam Penghargaan OSH 2025 - Bidang Bahasa Indonesia',
      titleEn: 'OSH 2025 Award of Honor - Indonesian Language',
      issuer: 'Panitia Olimpiade Sains & Humaniora (OSH)',
      year: '2025',
      category: CertificationCategory.competitions,
      frontImage:
          'lib/images/sertifikasi_perlombaan/lombabahasaindonesia/sertifikat_lomba_bahasaindonesia.png',
      backImage:
          'lib/images/sertifikasi_perlombaan/lombabahasaindonesia/sertifikat_lomba_bahasaindonesia.png',
      skills: ['Komunikasi Formal', 'Linguistik', 'Penulisan Kritis', 'Prestasi Akademik'],
      descriptionId:
          'Piagam penghargaan atas pencapaian dan keikutsertaan berprestasi dalam kompetisi Olimpiade Humaniora Nasional bidang Bahasa Indonesia.',
      descriptionEn:
          'Honorary award certificate for distinguished academic performance and linguistic mastery in the National Humanities Olympiad.',
      icon: Icons.auto_stories_rounded,
      accentColor: Color(0xFF8B5CF6),
    ),
    const CertificationModel(
      id: 'cert-ai-engineer',
      titleId: 'AI Engineer For Milenial',
      titleEn: 'AI Engineer For Millennials',
      issuer: 'Kementerian Kominfo • Digital Talent Scholarship',
      year: 'Terverifikasi',
      category: CertificationCategory.aiTech,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan5/NazarulQudri_E-sertifAI Engineer For Milenial_001.png',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan5/NazarulQudri_E-sertifAI Engineer For Milenial_002.png',
      skills: ['Artificial Intelligence', 'Machine Learning', 'Data Modeling', 'Python'],
      descriptionId:
          'Pelatihan komprehensif pengembangan model Artificial Intelligence, machine learning pipeline, pengenalan pola, dan implementasi algoritma kecerdasan buatan.',
      descriptionEn:
          'Comprehensive training in developing Artificial Intelligence models, machine learning pipelines, pattern recognition, and algorithm implementation.',
      icon: Icons.psychology_rounded,
      accentColor: Color(0xFF8B5CF6),
    ),
    const CertificationModel(
      id: 'cert-cloud-computing',
      titleId: 'Introduction To Cloud Computing',
      titleEn: 'Introduction To Cloud Computing',
      issuer: 'Kementerian Kominfo • Digital Talent Scholarship',
      year: 'Terverifikasi',
      category: CertificationCategory.cloudSecurity,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan7/NazarulQudri_E-SertifIntroduction To Cloud Computing_001.png',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan7/NazarulQudri_E-SertifIntroduction To Cloud Computing_002.png',
      skills: ['Cloud Architecture', 'Virtualization', 'Scalability', 'DevOps'],
      descriptionId:
          'Mendalami fundamental komputasi awan, virtualisasi server, skalabilitas beban sistem, arsitektur microservices, dan manajemen infrastruktur cloud.',
      descriptionEn:
          'In-depth study of cloud computing fundamentals, server virtualization, workload scaling, microservices architecture, and cloud infrastructure management.',
      icon: Icons.cloud_done_rounded,
      accentColor: Color(0xFF0284C7),
    ),
    const CertificationModel(
      id: 'cert-ethical-hacker',
      titleId: 'Ethical Hacker For Dummies',
      titleEn: 'Ethical Hacker For Dummies',
      issuer: 'Kementerian Kominfo • Digital Talent Scholarship',
      year: 'Terverifikasi',
      category: CertificationCategory.cloudSecurity,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan3/NazarulQudri_E-Sertif Ethical Hacker For Dummies_001.png',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan3/NazarulQudri_E-Sertif Ethical Hacker For Dummies_002.png',
      skills: ['Cybersecurity', 'Vulnerability Assessment', 'Network Defense', 'Penetration Testing'],
      descriptionId:
          'Pelatihan keamanan siber, identifikasi kerentanan sistem, prinsip penetration testing etis, dan pengamanan protokol jaringan informasi.',
      descriptionEn:
          'Hands-on cybersecurity training covering vulnerability scanning, ethical penetration testing principles, and network security hardening.',
      icon: Icons.security_rounded,
      accentColor: Color(0xFFEF4444),
    ),
    const CertificationModel(
      id: 'cert-computational-thinking',
      titleId: 'Computational Thinking: Cara Berpikir Logis Mengatasi Masalah',
      titleEn: 'Computational Thinking: Logical Problem Solving',
      issuer: 'Kementerian Kominfo • Digital Talent Scholarship',
      year: 'Terverifikasi',
      category: CertificationCategory.aiTech,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan2/NazarulQudri_E-sertif Computational ThinkingCara Berpikir Logis untuk Mengatasi Masalah _001.png',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan2/NazarulQudri_E-sertif Computational ThinkingCara Berpikir Logis untuk Mengatasi Masalah _002.png',
      skills: ['Algorithm Design', 'Problem Decomposition', 'Pattern Recognition', 'Logic'],
      descriptionId:
          'Fondasi pemecahan masalah algoritmis: dekomposisi sistem rumit, abstraksi pola data, dan perancangan alur solusi yang efisien.',
      descriptionEn:
          'Algorithmic problem-solving foundations: decomposing complex systems, data pattern abstraction, and designing efficient solution workflows.',
      icon: Icons.account_tree_rounded,
      accentColor: Color(0xFF2563EB),
    ),
    const CertificationModel(
      id: 'cert-digital-product-design',
      titleId: 'Pengenalan Produk Digital & Desain Grafis',
      titleEn: 'Introduction to Digital Products & Graphic Design',
      issuer: 'Kementerian Kominfo • Digital Talent Scholarship',
      year: 'Terverifikasi',
      category: CertificationCategory.digitalProduct,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan11/NazarulQudri_E-SertifPengenalan Produk Digital dan Desain Grafis Bagi Angkatan Kerja Muda_001.png',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan11/NazarulQudri_E-SertifPengenalan Produk Digital dan Desain Grafis Bagi Angkatan Kerja Muda_002.png',
      skills: ['Digital Product Lifecycle', 'UI/UX Design', 'Visual Hierarchy', 'Design Systems'],
      descriptionId:
          'Mempelajari siklus hidup produk digital, estetika antarmuka modern, hierarki visual, serta metodologi perancangan pengalaman pengguna yang memikat.',
      descriptionEn:
          'Mastering digital product lifecycle, modern visual hierarchy, interface aesthetics, and compelling user experience design methodologies.',
      icon: Icons.design_services_rounded,
      accentColor: Color(0xFF06B6D4),
    ),
    const CertificationModel(
      id: 'cert-social-media-management',
      titleId: 'Social Media Management untuk Brand Digital',
      titleEn: 'Social Media Management for Digital Brands',
      issuer: 'Kementerian Kominfo • Digital Talent Scholarship',
      year: 'Terverifikasi',
      category: CertificationCategory.strategy,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan4/NazarulQudri_E-Sertif Social Media Management untuk Brand Digital_001.png',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan4/NazarulQudri_E-Sertif Social Media Management untuk Brand Digital_002.png',
      skills: ['Brand Identity', 'Audience Analytics', 'Content Strategy', 'Growth Marketing'],
      descriptionId:
          'Strategi komunikasi digital, analisis metrik engagement pengguna, penyusunan narasi brand teknologi, dan kampanye digital multi-platform.',
      descriptionEn:
          'Digital communication strategy, user engagement telemetry analytics, tech brand storytelling, and multi-channel campaign execution.',
      icon: Icons.campaign_rounded,
      accentColor: Color(0xFFF59E0B),
    ),
    const CertificationModel(
      id: 'cert-branding-institusi',
      titleId: 'Branding Institusi Untuk Instansi Pemerintah',
      titleEn: 'Institutional Branding for Public Agencies',
      issuer: 'Badan Litbang SDM Kominfo • Pusdiklat',
      year: 'Terverifikasi',
      category: CertificationCategory.strategy,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan1/NazarulQudri_E-Sertif Branding Institusi Untuk Instansi Pemerintah_page-0001.jpg',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan1/NazarulQudri_E-Sertif Branding Institusi Untuk Instansi Pemerintah_page-0002.jpg',
      skills: ['Public Communications', 'Public Trust', 'Visual Governance', 'Strategy'],
      descriptionId:
          'Penguatan citra institusi publik, tata kelola komunikasi digital terpercaya, dan standarisasi visual komunikasi pelayanan masyarakat.',
      descriptionEn:
          'Institutional brand governance, trusted public digital communications, and standardizing visual service interfaces for public clarity.',
      icon: Icons.account_balance_rounded,
      accentColor: Color(0xFF10B981),
    ),
    const CertificationModel(
      id: 'cert-video-creator',
      titleId: 'Prinsip-Prinsip Video Content Creator Micro Skill',
      titleEn: 'Video Content Creator Micro Skills & Principles',
      issuer: 'Kementerian Kominfo • Digital Talent Scholarship',
      year: 'Terverifikasi',
      category: CertificationCategory.strategy,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan10/NazarulQudri_E-SertifPrinsip Prinsip Video Content Creator Micro Skill_001.png',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan10/NazarulQudri_E-SertifPrinsip Prinsip Video Content Creator Micro Skill_002.png',
      skills: ['Video Production', 'Visual Storytelling', 'Micro-learning Content', 'Editing'],
      descriptionId:
          'Penciptaan konten edukasi dan teknologi berdurasi mikro, teknik storytelling visual dinamis, serta alur pascaproduksi video berkualitas tinggi.',
      descriptionEn:
          'Short-form technical content creation, dynamic visual storytelling techniques, and high-quality video post-production workflows.',
      icon: Icons.video_camera_front_rounded,
      accentColor: Color(0xFFEC4899),
    ),
    const CertificationModel(
      id: 'cert-digital-mindset',
      titleId: 'Mengubah Masa Depan dengan Pola Pikir Digital',
      titleEn: 'Transforming Your Future with a Digital Mindset',
      issuer: 'Kementerian Kominfo • Digital Talent Scholarship',
      year: 'Terverifikasi',
      category: CertificationCategory.strategy,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan9/NazarulQudri_E-SertifMengubah Masa Depan Anda Dengan Pola Pikir Digital_001.png',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan9/NazarulQudri_E-SertifMengubah Masa Depan Anda Dengan Pola Pikir Digital_002.png',
      skills: ['Digital Transformation', 'Growth Mindset', 'Adaptive Tech', 'Innovation'],
      descriptionId:
          'Adaptasi transformasi industri digital, kesiapan menghadapi disrupsi teknologi, dan akselerasi kapabilitas rekayasa modern.',
      descriptionEn:
          'Digital transformation adaptability, navigating technological disruption, and accelerating modern engineering capabilities.',
      icon: Icons.lightbulb_rounded,
      accentColor: Color(0xFFF97316),
    ),
    const CertificationModel(
      id: 'cert-online-office',
      titleId: 'Cara Mudah Menggunakan Aplikasi Perkantoran Online',
      titleEn: 'Mastering Collaborative Online Office Applications',
      issuer: 'Kementerian Kominfo • Digital Talent Scholarship',
      year: 'Terverifikasi',
      category: CertificationCategory.digitalProduct,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan6/NazarulQudri_E-SertifCara Mudah Menggunakan Aplikasi Perkantoran Online_001.png',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan6/NazarulQudri_E-SertifCara Mudah Menggunakan Aplikasi Perkantoran Online_002.png',
      skills: ['Cloud Collaboration', 'Document Automation', 'Data Spreadsheets', 'Team Tools'],
      descriptionId:
          'Optimalisasi produktivitas daring, integrasi spreadsheet analitis, automasi dokumen digital, dan alur kerja kolaboratif terdistribusi.',
      descriptionEn:
          'Cloud productivity optimization, automated document pipelines, analytics spreadsheets, and distributed collaborative workflows.',
      icon: Icons.article_rounded,
      accentColor: Color(0xFF0284C7),
    ),
    const CertificationModel(
      id: 'cert-digital-media-education',
      titleId: 'Media Digital bagi Guru & Tenaga Kependidikan',
      titleEn: 'Digital Media for Educators & Instructors',
      issuer: 'Kementerian Kominfo • Digital Talent Scholarship',
      year: 'Terverifikasi',
      category: CertificationCategory.strategy,
      frontImage:
          'lib/images/sertifikasi_pelatihan/pelatihan8/NazarulQudri_E-SertifMedia Digital bagi GuruTenaga Kependidikan_001.png',
      backImage:
          'lib/images/sertifikasi_pelatihan/pelatihan8/NazarulQudri_E-SertifMedia Digital bagi GuruTenaga Kependidikan_002.png',
      skills: ['Instructional Tech', 'Multimedia Presentation', 'E-Learning', 'Pedagogy'],
      descriptionId:
          'Pemanfaatan media interaktif untuk pembelajaran digital, transfer pengetahuan teknologi yang efektif, serta perancangan modul multimedia.',
      descriptionEn:
          'Interactive media instructional design, effective technical knowledge transfer, and interactive multimedia course architectures.',
      icon: Icons.school_rounded,
      accentColor: Color(0xFF6366F1),
    ),
  ];
}

