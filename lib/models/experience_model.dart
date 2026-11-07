import 'package:flutter/material.dart';

class ExperienceModel {
  final String period;
  final String role;
  final String company;
  final String location;
  final String description;
  final List<String> highlights;
  final bool isEducation;
  final IconData icon;

  const ExperienceModel({
    required this.period,
    required this.role,
    required this.company,
    required this.location,
    required this.description,
    required this.highlights,
    this.isEducation = false,
    required this.icon,
  });

  static List<ExperienceModel> get timelineList => [
    const ExperienceModel(
      period: '2022 - 2026',
      role: 'Sarjana Terapan Teknik (S.Tr.T.) • Teknologi Rekayasa Komputer Jaringan',
      company: 'Politeknik Negeri Lhokseumawe (PNL)',
      location: 'Lhokseumawe, Aceh, Indonesia',
      description:
          'Menempuh dan menyelesaikan pendidikan Sarjana Terapan Teknik di Program Studi D4 Teknologi Rekayasa Komputer Jaringan (TRKJ), Jurusan Teknologi Informasi dan Komputer (TIK) dengan konsentrasi pada rekayasa siber-fisik (CPS), arsitektur 7 OSI Layer, dan sistem kecerdasan buatan (Rule-Based Decision Systems).',
      highlights: [
        'Skripsi: "Rancang Bangun IoT pada Prototype Smart Home dengan Penerapan Rule-Based Decision System sebagai Artificial Intelligence" (Lulus Sidang 29 Juli 2026)',
        'Membangun Aplikasi Android Flutter "STARZAR" berbasis model 7 Lapisan OSI Layer, protokol MQTT HiveMQ Cloud, dan Hive DB dengan respon 180 ms',
        'Dibimbing oleh: Husaini, S.Si., M.T. & Atthariq, S.S.T., M.T. (Ketua Jurusan: Salahuddin, S.T., M.Cs., Kaprodi: Nanda Saputri, S.S.T., M.T.)',
      ],
      isEducation: true,
      icon: Icons.school_rounded,
    ),
    const ExperienceModel(
      period: '2025 - 2026',
      role: 'Full-Stack Web & Academic Information Systems Developer',
      company: 'Jurusan Teknologi Informasi dan Komputer (TIK) PNL',
      location: 'Lhokseumawe, Aceh',
      description:
          'Merancang, membangun, dan mengelola ekosistem sistem informasi berbasis web untuk tata kelola akademik, pendaftaran seminar, dan verifikasi sertifikat institusi kampus.',
      highlights: [
        'Website Sistem Informasi & Pendaftaran Kuliah Umum Jurusan TIK PNL (2025 - 2026)',
        'Website Sistem Informasi Sertifikat Dosen Politeknik Negeri Lhokseumawe (2025 - 2026)',
        'Website Sistem Informasi Sertifikat Mahasiswa/i Jurusan TIK Politeknik Negeri Lhokseumawe',
      ],
      isEducation: false,
      icon: Icons.web_rounded,
    ),
    const ExperienceModel(
      period: '2024 - 2025',
      role: 'IoT Researcher & National Competition Delegate',
      company: 'Laboratorium Jaringan & Sistem Cerdas TIK PNL',
      location: 'Aceh / Nasional',
      description:
          'Melakukan riset terapan sensor cerdas, komunikasi data nirkabel hemat daya, serta mewakili kampus dalam ajang kompetisi informatika dan olimpiade keilmuan nasional.',
      highlights: [
        'Delegasi KMIPN VI 2025 (Kompetisi Mahasiswa Bidang Informatika Politeknik Nasional) bidang Inovasi Perangkat Lunak',
        'Meraih Penghargaan Nasional: NSO 5 (Bahasa Inggris), OSPN (Akuntansi & Logika Kuantitatif), dan OSH 2025 (Bahasa Indonesia)',
        'Menyelesaikan 11 Pelatihan Kompetensi Profesional Digital Talent Scholarship Kementerian Kominfo RI',
      ],
      isEducation: false,
      icon: Icons.emoji_events_rounded,
    ),
  ];
}
