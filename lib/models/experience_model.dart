import 'package:flutter/material.dart';

class ExperienceModel {
  final String period;
  final String role;
  final String? roleEn;
  final String company;
  final String? companyEn;
  final String location;
  final String? locationEn;
  final String description;
  final String? descriptionEn;
  final List<String> highlights;
  final List<String>? highlightsEn;
  final bool isEducation;
  final IconData icon;

  const ExperienceModel({
    required this.period,
    required this.role,
    this.roleEn,
    required this.company,
    this.companyEn,
    required this.location,
    this.locationEn,
    required this.description,
    this.descriptionEn,
    required this.highlights,
    this.highlightsEn,
    this.isEducation = false,
    required this.icon,
  });

  String getRole(bool isEn) => (isEn && roleEn != null) ? roleEn! : role;
  String getCompany(bool isEn) => (isEn && companyEn != null) ? companyEn! : company;
  String getLocation(bool isEn) => (isEn && locationEn != null) ? locationEn! : location;
  String getDescription(bool isEn) => (isEn && descriptionEn != null) ? descriptionEn! : description;
  List<String> getHighlights(bool isEn) => (isEn && highlightsEn != null) ? highlightsEn! : highlights;

  static List<ExperienceModel> get timelineList => [
    const ExperienceModel(
      period: '2022 - 2026',
      role: 'Sarjana Terapan Teknik (S.Tr.T.) • Teknologi Rekayasa Komputer Jaringan',
      roleEn: 'Bachelor of Applied Engineering (S.Tr.T.) • Computer Network Engineering Technology',
      company: 'Politeknik Negeri Lhokseumawe (PNL)',
      companyEn: 'Politeknik Negeri Lhokseumawe (PNL)',
      location: 'Lhokseumawe, Aceh, Indonesia',
      locationEn: 'Lhokseumawe, Aceh, Indonesia',
      description:
          'Menempuh dan menyelesaikan pendidikan Sarjana Terapan Teknik di Program Studi D4 Teknologi Rekayasa Komputer Jaringan (TRKJ), Jurusan Teknologi Informasi dan Komputer (TIK) dengan konsentrasi pada rekayasa siber-fisik (CPS), arsitektur 7 OSI Layer, dan sistem kecerdasan buatan (Rule-Based Decision Systems).',
      descriptionEn:
          'Pursued and completed the Bachelor of Applied Engineering degree in Computer Network Engineering Technology (D4 TRKJ), Department of Information and Computer Technology (TIK), specializing in cyber-physical systems (CPS), 7-Layer OSI network architecture, and applied artificial intelligence (Rule-Based Decision Systems).',
      highlights: [
        'Skripsi: "Rancang Bangun IoT pada Prototype Smart Home dengan Penerapan Rule-Based Decision System sebagai Artificial Intelligence" (Lulus Sidang 29 Juli 2026)',
        'Membangun Aplikasi Android Flutter "STARZAR" berbasis model 7 Lapisan OSI Layer, protokol MQTT HiveMQ Cloud, dan Hive DB dengan respon 180 ms',
        'Dibimbing oleh: Husaini, S.Si., M.IT. & Atthariq, S.S.T., M.T. (Ketua Jurusan: Salahuddin, S.T., M.Cs., Kaprodi: Nanda Saputri, S.S.T., M.T.)',
      ],
      highlightsEn: [
        'Thesis: "Design and Construction of IoT Prototype Smart Home with Rule-Based Decision System as Artificial Intelligence" (Defended July 29, 2026)',
        'Engineered Flutter Android app "STARZAR" implementing all 7 OSI Layers, MQTT HiveMQ Cloud, and local Hive DB with 180 ms latency',
        'Supervised by: Husaini, S.Si., M.IT. & Atthariq, S.S.T., M.T. (Head of Dept: Salahuddin, S.T., M.Cs., Head of Study Program: Nanda Saputri, S.S.T., M.T.)',
      ],
      isEducation: true,
      icon: Icons.school_rounded,
    ),
    const ExperienceModel(
      period: '2025 - 2026',
      role: 'Full-Stack Web & Academic Information Systems Developer',
      roleEn: 'Full-Stack Web & Academic Information Systems Developer',
      company: 'Jurusan Teknologi Informasi dan Komputer (TIK) PNL',
      companyEn: 'Department of Information & Computer Technology (TIK) PNL',
      location: 'Lhokseumawe, Aceh',
      locationEn: 'Lhokseumawe, Aceh',
      description:
          'Merancang, membangun, dan mengelola ekosistem sistem informasi berbasis web untuk tata kelola akademik, pendaftaran seminar, dan verifikasi sertifikat institusi kampus.',
      descriptionEn:
          'Designed, engineered, and maintained web-based institutional information systems for academic governance, guest lecture registrations, and verifiable campus certificate repositories.',
      highlights: [
        'Website Sistem Informasi & Pendaftaran Kuliah Umum Jurusan TIK PNL (2025 - 2026)',
        'Website Sistem Informasi Sertifikat Dosen Politeknik Negeri Lhokseumawe (2025 - 2026)',
        'Website Sistem Informasi Sertifikat Mahasiswa/i Jurusan TIK Politeknik Negeri Lhokseumawe',
      ],
      highlightsEn: [
        'TIK PNL Guest Lecture & Event Registration Information System (2025 - 2026)',
        'PNL Faculty Certificate & Credential Repository Web System (2025 - 2026)',
        'TIK PNL Student Certificate & SKPI Validation Web Platform (2025 - 2026)',
      ],
      isEducation: false,
      icon: Icons.web_rounded,
    ),
    const ExperienceModel(
      period: '2024 - 2025',
      role: 'IoT Researcher & National Competition Delegate',
      roleEn: 'IoT Researcher & National Competition Delegate',
      company: 'Laboratorium Jaringan & Sistem Cerdas TIK PNL',
      companyEn: 'Networking & Intelligent Systems Laboratory TIK PNL',
      location: 'Aceh / Nasional',
      locationEn: 'Aceh / National',
      description:
          'Melakukan riset terapan sensor cerdas, komunikasi data nirkabel hemat daya, serta mewakili kampus dalam ajang kompetisi informatika dan olimpiade keilmuan nasional.',
      descriptionEn:
          'Conducted applied research on smart sensing, low-power telemetry protocols, and represented the institution in prestigious national informatics championships and academic olympiads.',
      highlights: [
        'Delegasi KMIPN VI 2025 (Kompetisi Mahasiswa Bidang Informatika Politeknik Nasional) bidang Inovasi Perangkat Lunak',
        'Meraih Penghargaan Nasional: NSO 5 (Bahasa Inggris), OSPN (Akuntansi & Logika Kuantitatif), dan OSH 2025 (Bahasa Indonesia)',
        'Menyelesaikan 11 Pelatihan Kompetensi Profesional Digital Talent Scholarship Kementerian Kominfo RI',
      ],
      highlightsEn: [
        'KMIPN VI 2025 Finalist Delegate (National Polytechnic Informatics Competition) in Software Innovation category',
        'National Academic Honors: NSO 5 (English), OSPN (Accounting & Quantitative Reasoning), and OSH 2025 (Indonesian Language)',
        'Completed 11 Professional Competency Training Programs under Kominfo Digital Talent Scholarship (DTS)',
      ],
      isEducation: false,
      icon: Icons.emoji_events_rounded,
    ),
  ];
}
