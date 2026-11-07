import 'package:flutter/material.dart';

enum SkillCategory {
  frontend('Frontend & Mobile', Icons.phone_android_rounded),
  backend('Backend & Cloud', Icons.cloud_done_rounded),
  iot('IoT Integration', Icons.memory_rounded),
  tools('Tools & UI/UX', Icons.auto_awesome_rounded);

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
    // Frontend & Mobile
    const SkillModel(
      name: 'Flutter SDK',
      level: 'Advanced Specialist',
      proficiency: 0.95,
      category: SkillCategory.frontend,
      icon: Icons.flutter_dash,
      accentColor: Color(0xFF0284C7),
      experienceYears: '4+ Years',
      description: 'Custom render objects, fluid animations, platform channels, Web/Desktop/Mobile optimization.',
    ),
    const SkillModel(
      name: 'Dart Language',
      level: 'Advanced',
      proficiency: 0.94,
      category: SkillCategory.frontend,
      icon: Icons.code_rounded,
      accentColor: Color(0xFF2563EB),
      experienceYears: '4+ Years',
      description: 'Async streams, isolate concurrency, sound null-safety, functional paradigms & patterns.',
    ),
    const SkillModel(
      name: 'Clean Architecture & State',
      level: 'Expert',
      proficiency: 0.92,
      category: SkillCategory.frontend,
      icon: Icons.layers_rounded,
      accentColor: Color(0xFF0EA5E9),
      experienceYears: '3+ Years',
      description: 'BLoC, Riverpod, Provider, repository pattern, domain-driven clean modular organization.',
    ),
    const SkillModel(
      name: 'Responsive & Glass UI',
      level: 'Master',
      proficiency: 0.96,
      category: SkillCategory.frontend,
      icon: Icons.palette_rounded,
      accentColor: Color(0xFF06B6D4),
      experienceYears: '4+ Years',
      description: 'Micro-interactions, 3D transforms, custom painters, light glassmorphism, responsive viewports.',
    ),

    // Backend & Cloud
    const SkillModel(
      name: 'Firebase & Supabase',
      level: 'Proficient',
      proficiency: 0.88,
      category: SkillCategory.backend,
      icon: Icons.local_fire_department_rounded,
      accentColor: Color(0xFFF59E0B),
      experienceYears: '3+ Years',
      description: 'Firestore rules, Auth, Cloud Functions, real-time sync, Postgres edge functions.',
    ),
    const SkillModel(
      name: 'RESTful API & GraphQL',
      level: 'Advanced',
      proficiency: 0.90,
      category: SkillCategory.backend,
      icon: Icons.hub_rounded,
      accentColor: Color(0xFF0284C7),
      experienceYears: '4+ Years',
      description: 'Dio, caching interceptors, retry policies, WebSocket streams, GraphQL schemas.',
    ),
    const SkillModel(
      name: 'Node.js & Express',
      level: 'Intermediate',
      proficiency: 0.80,
      category: SkillCategory.backend,
      icon: Icons.terminal_rounded,
      accentColor: Color(0xFF10B981),
      experienceYears: '2+ Years',
      description: 'Microservices, JWT authentication, rate limiting, ORM integration with PostgreSQL.',
    ),

    // IoT Integration
    const SkillModel(
      name: 'MQTT Protocol',
      level: 'Specialist',
      proficiency: 0.90,
      category: SkillCategory.iot,
      icon: Icons.wifi_tethering_rounded,
      accentColor: Color(0xFF0284C7),
      experienceYears: '3+ Years',
      description: 'Broker setups, QoS guarantees, keep-alive telemetry, low-bandwidth edge payload packaging.',
    ),
    const SkillModel(
      name: 'ESP32 & Microcontrollers',
      level: 'Advanced',
      proficiency: 0.86,
      category: SkillCategory.iot,
      icon: Icons.memory_rounded,
      accentColor: Color(0xFF2563EB),
      experienceYears: '3+ Years',
      description: 'C++/Arduino firmware, sensor sampling, Bluetooth Low Energy (BLE), Wi-Fi provisioning.',
    ),
    const SkillModel(
      name: 'Sensor Telematics',
      level: 'Proficient',
      proficiency: 0.85,
      category: SkillCategory.iot,
      icon: Icons.speed_rounded,
      accentColor: Color(0xFF06B6D4),
      experienceYears: '2+ Years',
      description: 'Real-time telemetry buffering, edge threshold alerts, time-series plotting.',
    ),

    // Tools & UI/UX
    const SkillModel(
      name: 'Figma to Code',
      level: 'Advanced',
      proficiency: 0.92,
      category: SkillCategory.tools,
      icon: Icons.design_services_rounded,
      accentColor: Color(0xFF8B5CF6),
      experienceYears: '4+ Years',
      description: 'Design system translation, design tokens, responsive auto-layout into Flutter widgets.',
    ),
    const SkillModel(
      name: 'Git & GitHub CI/CD',
      level: 'Proficient',
      proficiency: 0.88,
      category: SkillCategory.tools,
      icon: Icons.merge_type_rounded,
      accentColor: Color(0xFF0F172A),
      experienceYears: '4+ Years',
      description: 'Semantic commits, branch protections, automated Flutter test/build action workflows.',
    ),
    const SkillModel(
      name: 'Performance Profiling',
      level: 'Specialist',
      proficiency: 0.89,
      category: SkillCategory.tools,
      icon: Icons.insights_rounded,
      accentColor: Color(0xFF0284C7),
      experienceYears: '3+ Years',
      description: 'Flutter DevTools, memory leak hunting, widget rebuild optimization, 60/120 FPS rendering.',
    ),
  ];
}

