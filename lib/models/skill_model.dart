import 'package:flutter/material.dart';

enum SkillCategory {
  mobile('Mobile Development (Flutter)', Icons.phone_android_rounded),
  ai('Artificial Intelligence (AI)', Icons.psychology_rounded),
  iot('IoT & Networking (CPS)', Icons.memory_rounded),
  tools('Technical & Admin Tools', Icons.auto_awesome_rounded);

  final String label;
  final IconData icon;
  const SkillCategory(this.label, this.icon);
}

class SkillModel {
  final String name;
  final String level;
  final double proficiency; // 0.0 - 1.0
  final SkillCategory category;
  final IconData icon;
  final Color accentColor;
  final String experienceYears;
  final String description;

  const SkillModel({
    required this.name,
    required this.level,
    required this.proficiency,
    required this.category,
    required this.icon,
    required this.accentColor,
    required this.experienceYears,
    required this.description,
  });

  static List<SkillModel> get sampleSkills => [
    // 1. Mobile Development
    const SkillModel(
      name: 'Flutter Cross-Platform',
      level: 'Advanced Specialist',
      proficiency: 0.96,
      category: SkillCategory.mobile,
      icon: Icons.flutter_dash,
      accentColor: Color(0xFF0284C7),
      experienceYears: '4+ Years',
      description: 'Pengembangan aplikasi multi-platform (Android, Web, Desktop) berkinerja tinggi, responsif, dan kaya animasi 60/120 FPS.',
    ),
    const SkillModel(
      name: 'Dart Programming',
      level: 'Advanced',
      proficiency: 0.94,
      category: SkillCategory.mobile,
      icon: Icons.code_rounded,
      accentColor: Color(0xFF2563EB),
      experienceYears: '4+ Years',
      description: 'Asynchronous programming (Streams, Futures), Isolate multi-threading, Sound Null Safety, dan object-oriented architecture.',
    ),
    const SkillModel(
      name: 'Mobile Architecture & BLoC',
      level: 'Expert',
      proficiency: 0.93,
      category: SkillCategory.mobile,
      icon: Icons.layers_rounded,
      accentColor: Color(0xFF0EA5E9),
      experienceYears: '3+ Years',
      description: 'Pemisahan layer yang kokoh (Domain, Data, Presentation), Reactive BLoC & Riverpod, repository pattern, dan high-maintainability code.',
    ),
    const SkillModel(
      name: 'Responsive & Modern UI',
      level: 'Master',
      proficiency: 0.95,
      category: SkillCategory.mobile,
      icon: Icons.palette_rounded,
      accentColor: Color(0xFF06B6D4),
      experienceYears: '4+ Years',
      description: 'Desain antarmuka modern & responsif, custom painters, micro-interactions, adaptabilitas tablet/desktop/mobile.',
    ),

    // 2. Artificial Intelligence (AI)
    const SkillModel(
      name: 'Rule-Based Decision Systems',
      level: 'Specialist / Skripsi',
      proficiency: 0.96,
      category: SkillCategory.ai,
      icon: Icons.alt_route_rounded,
      accentColor: Color(0xFF7C3AED),
      experienceYears: '2+ Years',
      description: 'Forward Chaining inference engine untuk pengambilan keputusan otonom mitigasi bahaya & otomasi smart home dengan akurasi 100%.',
    ),
    const SkillModel(
      name: 'Generative AI Integration',
      level: 'Advanced',
      proficiency: 0.90,
      category: SkillCategory.ai,
      icon: Icons.auto_awesome_rounded,
      accentColor: Color(0xFF8B5CF6),
      experienceYears: '2+ Years',
      description: 'Integrasi Google AI Studio, Gemini API, intelligent prompt engineering, context embedding, dan virtual assistant pada aplikasi.',
    ),
    const SkillModel(
      name: 'Smart Embedded Logic',
      level: 'Advanced',
      proficiency: 0.91,
      category: SkillCategory.ai,
      icon: Icons.psychology_rounded,
      accentColor: Color(0xFFA855F7),
      experienceYears: '3+ Years',
      description: 'Logika cerdas komputasi tepi (Edge Computing) pada mikrokontroler untuk deteksi anomali sensorik dan aksi preventif instan.',
    ),

    // 3. IoT & Networking
    const SkillModel(
      name: 'Cyber-Physical Systems (CPS)',
      level: 'Specialist (TRKJ)',
      proficiency: 0.94,
      category: SkillCategory.iot,
      icon: Icons.hub_rounded,
      accentColor: Color(0xFF0D9488),
      experienceYears: '4+ Years',
      description: 'Integrasi menyeluruh 7 Lapisan Model OSI menghubungkan sensor fisik, aktuator relay, jaringan nirkabel, dan antarmuka cloud mobile.',
    ),
    const SkillModel(
      name: 'Telemetri Real-time & MQTT/TLS',
      level: 'Expert',
      proficiency: 0.95,
      category: SkillCategory.iot,
      icon: Icons.wifi_tethering_rounded,
      accentColor: Color(0xFF0284C7),
      experienceYears: '3+ Years',
      description: 'Protokol MQTT HiveMQ Cloud aman (TLS/SSL), packet loss 0%, latensi rendah 180 ms, memenuhi standar ITU-T Y.1010/G.1010.',
    ),
    const SkillModel(
      name: 'ESP32 & ESP8266 Microcontrollers',
      level: 'Advanced',
      proficiency: 0.92,
      category: SkillCategory.iot,
      icon: Icons.memory_rounded,
      accentColor: Color(0xFF06B6D4),
      experienceYears: '4+ Years',
      description: 'Pemrograman C++/Arduino, sampling multi-sensor (MQ-2, MQ-135, DHT22, Flame, HC-SR04), Wi-Fi IEEE 802.11, dan kontrol relay.',
    ),
    const SkillModel(
      name: 'Computer Network Engineering',
      level: 'Advanced (TRKJ)',
      proficiency: 0.90,
      category: SkillCategory.iot,
      icon: Icons.lan_rounded,
      accentColor: Color(0xFF2563EB),
      experienceYears: '4+ Years',
      description: 'Topologi jaringan, TCP/IP, pengalamatan IP, routing, subnetting, manajemen frame data link, dan keamanan jaringan komputer.',
    ),

    // 4. Technical & Admin Tools
    const SkillModel(
      name: 'Microsoft Office Suite',
      level: 'Professional',
      proficiency: 0.95,
      category: SkillCategory.tools,
      icon: Icons.description_rounded,
      accentColor: Color(0xFFD97706),
      experienceYears: '4+ Years',
      description: 'MS Word, Excel, PowerPoint untuk dokumentasi teknis, laporan ilmiah akademis, pengolahan data telemetri, dan presentasi profesional.',
    ),
    const SkillModel(
      name: 'Figma Design System',
      level: 'Proficient',
      proficiency: 0.88,
      category: SkillCategory.tools,
      icon: Icons.design_services_rounded,
      accentColor: Color(0xFFEA580C),
      experienceYears: '3+ Years',
      description: 'UI/UX design, interactive prototyping, design tokens, dan translasi desain pixel-perfect menjadi widget Flutter responsif.',
    ),
    const SkillModel(
      name: 'VS Code & Flutter DevTools',
      level: 'Expert',
      proficiency: 0.94,
      category: SkillCategory.tools,
      icon: Icons.terminal_rounded,
      accentColor: Color(0xFF0284C7),
      experienceYears: '4+ Years',
      description: 'Debugging tingkat lanjut, memory profiling, widget rebuild tracking, static analysis, dan optimasi performa kompilasi.',
    ),
    const SkillModel(
      name: 'Git & GitHub CI/CD',
      level: 'Advanced',
      proficiency: 0.92,
      category: SkillCategory.tools,
      icon: Icons.merge_type_rounded,
      accentColor: Color(0xFF0F172A),
      experienceYears: '4+ Years',
      description: 'Version control modern, branching, GitHub Actions workflow, deployment otomatis GitHub Pages, dan kolaborasi repositori.',
    ),
  ];
}
