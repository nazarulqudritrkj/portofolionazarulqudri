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
      period: '2023 - Present',
      role: 'Senior Flutter & Mobile Solutions Engineer',
      company: 'Tech Innovations Studio',
      location: 'Remote / Banda Aceh',
      description:
          'Leading cross-platform client architectures, mentoring engineers, and implementing high-reliability IoT & fintech products.',
      highlights: [
        'Architected clean modular state systems reducing regression bugs by 40%',
        'Integrated real-time IoT telemetry pipelines for enterprise clients',
        'Spearheaded Flutter Web & Mobile performance optimization achieving 60fps across low-end devices',
      ],
      isEducation: false,
      icon: Icons.rocket_launch_rounded,
    ),
    const ExperienceModel(
      period: '2021 - 2023',
      role: 'Mobile Application Developer (Flutter & IoT)',
      company: 'Digital Nexus Labs',
      location: 'Indonesia',
      description:
          'Engineered commercial mobile apps integrated with hardware sensor networks, RESTful backends, and cloud microservices.',
      highlights: [
        'Developed 12+ production applications deployed to Google Play & App Store',
        'Implemented MQTT communication layer for sensor monitoring systems',
        'Crafted custom fluid animations and modern design-system UI components',
      ],
      isEducation: false,
      icon: Icons.devices_other_rounded,
    ),
    const ExperienceModel(
      period: 'Graduate • TRKJ',
      role: 'Teknologi Rekayasa Komputer Jaringan (TRKJ)',
      company: 'Pendidikan Tinggi / Politeknik',
      location: 'Banda Aceh / Lhokseumawe, Indonesia',
      description:
          'Lulusan program studi Teknologi Rekayasa Komputer Jaringan (TRKJ) dengan capaian akademik unggul. Memiliki kompetensi mendalam dalam arsitektur perangkat lunak modern, jaringan komputer, dan sistem terdistribusi.',
      highlights: [
        'Ijazah Resmi & Transkrip Nilai Akademik Lengkap (Versi Indonesia & Inggris)',
        'Fokus Keahlian: Mobile Computing, Cloud Infrastructure & IoT Sensor Telemetry',
      ],
      isEducation: true,
      icon: Icons.school_rounded,
    ),
  ];
}

