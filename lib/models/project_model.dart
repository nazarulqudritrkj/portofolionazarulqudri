import 'package:flutter/material.dart';

enum ProjectCategory { all, mobile, fullstack, iot, ai }

class ProjectModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String fullDescription;
  final ProjectCategory category;
  final List<String> tags;
  final List<String> keyFeatures;
  final String? githubUrl;
  final String? liveUrl;
  final IconData icon;
  final Color primaryColor;
  final Color accentColor;
  final String metric;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.fullDescription,
    required this.category,
    required this.tags,
    required this.keyFeatures,
    this.githubUrl,
    this.liveUrl,
    required this.icon,
    required this.primaryColor,
    required this.accentColor,
    required this.metric,
  });

  static List<ProjectModel> get sampleProjects => [
    const ProjectModel(
      id: 'iot-smart-agriculture',
      title: 'AgroSense IoT & Mobile Platform',
      subtitle: 'Real-time telemetry & automated crop health monitoring',
      description:
          'Comprehensive IoT-driven precision agriculture app with MQTT protocols, sensor dashboards, and predictive yield analytics.',
      fullDescription:
          'AgroSense connects thousands of ESP32 sensor nodes deployed in agricultural fields. Built with Flutter Clean Architecture and Bloc state management, the application provides micro-climate tracking, automated drip irrigation triggering, and real-time alerts. It includes interactive charting, offline SQLite syncing, and WebSocket-driven sensor telemetry.',
      category: ProjectCategory.iot,
      tags: ['Flutter', 'Dart', 'MQTT', 'ESP32', 'Firebase', 'Clean Arch'],
      keyFeatures: [
        'Real-time WebSocket & MQTT telemetry streams with 50ms latency',
        'Interactive dynamic charts powered by custom painters',
        'Automated edge-trigger rules for climate control and valve actuators',
        'Offline-first synchronization with conflict resolution',
      ],
      githubUrl: 'https://github.com/nazarulqudri/agrosense-iot-mobile',
      liveUrl: 'https://agrosense.demo.app',
      icon: Icons.sensors_rounded,
      primaryColor: Color(0xFF0284C7),
      accentColor: Color(0xFF38BDF8),
      metric: '500+ Active Nodes',
    ),
    const ProjectModel(
      id: 'fintech-payflow',
      title: 'PayFlow - Digital Wealth & Banking',
      subtitle: 'Enterprise-grade financial dashboard & payment app',
      description:
          'Ultra-secure mobile banking application featuring biometric security, multi-currency wallets, and instant QRIS payments.',
      fullDescription:
          'PayFlow is a high-volume financial management suite engineered for modern digital banking. Implemented with strict domain-driven modular architecture, End-to-End encrypted local storage, custom virtual cards with 3D tilt effects, and real-time transaction categorizations with budget forecasting.',
      category: ProjectCategory.mobile,
      tags: ['Flutter', 'Clean Arch', 'Bloc', 'REST API', 'Biometrics', 'Figma'],
      keyFeatures: [
        'High-security biometric auth with encrypted keychain token storage',
        'Custom interactive virtual card with gyroscope/pointer tilt visual',
        'Instant multi-bank transfer and QRIS payment scanner',
        'Automated monthly budgeting with predictive expense insights',
      ],
      githubUrl: 'https://github.com/nazarulqudri/payflow-mobile-app',
      liveUrl: 'https://payflow.demo.app',
      icon: Icons.account_balance_wallet_rounded,
      primaryColor: Color(0xFF2563EB),
      accentColor: Color(0xFF60A5FA),
      metric: '50K+ Monthly Txns',
    ),
    const ProjectModel(
      id: 'fleet-telematics',
      title: 'PulseFleet - Logistics Tracker',
      subtitle: 'Live fleet dispatching & route optimization system',
      description:
          'High-performance logistics mobile platform with background geolocation, driver telematics, and digital proof-of-delivery.',
      fullDescription:
          'PulseFleet was built to empower enterprise freight fleets. Features smooth 60fps vector map rendering, turn-by-turn route optimization, fuel consumption telemetry, and instant barcode/signature capture for seamless cargo handovers in low-connectivity areas.',
      category: ProjectCategory.fullstack,
      tags: ['Flutter', 'Google Maps', 'WebSockets', 'Node.js', 'PostgreSQL'],
      keyFeatures: [
        'Smooth background GPS tracking with battery optimization algorithm',
        'Interactive map overlays with custom vehicle heading markers',
        'Digital signature pad and barcode scanner for instant proof of delivery',
        'Driver behavior scoring (harsh braking, rapid acceleration detection)',
      ],
      githubUrl: 'https://github.com/nazarulqudri/pulsefleet-driver',
      liveUrl: 'https://pulsefleet.demo.app',
      icon: Icons.local_shipping_rounded,
      primaryColor: Color(0xFF0EA5E9),
      accentColor: Color(0xFF7DD3FC),
      metric: '99.9% Uptime',
    ),
    const ProjectModel(
      id: 'ai-skin-diagnostics',
      title: 'DermaScan AI Assistant',
      subtitle: 'On-device computer vision skin lesion analyzer',
      description:
          'Healthcare mobile app integrating TensorFlow Lite for offline skin screening, doctor consultation booking, and recovery journals.',
      fullDescription:
          'DermaScan bridges clinical dermatology and mobile AI. Utilizing an optimized on-device TensorFlow Lite neural network, users can capture high-resolution photos of skin anomalies and receive preliminary risk stratifications within seconds, complete with doctor chat and clinical history logs.',
      category: ProjectCategory.ai,
      tags: ['Flutter', 'TensorFlow Lite', 'Camera API', 'Python', 'FastAPI'],
      keyFeatures: [
        'On-device machine learning inference with zero latency and privacy',
        'Custom camera viewfinder with guide overlays and lighting detection',
        'Interactive medical history timeline and lesion healing progression',
        'Telemedicine consultation scheduling and PDF report generation',
      ],
      githubUrl: 'https://github.com/nazarulqudri/dermascan-ai-flutter',
      liveUrl: 'https://dermascan.demo.app',
      icon: Icons.medical_services_rounded,
      primaryColor: Color(0xFF8B5CF6),
      accentColor: Color(0xFFA78BFA),
      metric: '94.2% AI Accuracy',
    ),
    const ProjectModel(
      id: 'nexus-smart-home',
      title: 'Nexus Home OS',
      subtitle: 'Modern glassmorphic smart home controller',
      description:
          'Sleek unified dashboard for controlling smart appliances, lighting scenes, energy metrics, and voice-activated automation.',
      fullDescription:
          'Nexus Home OS is an ambient computing interface designed for tablets, foldables, and smart wall panels. Built using custom glassmorphic canvas rendering, dynamic lighting gradient shifts based on room ambiance, and low-latency MQTT/Zigbee bridging.',
      category: ProjectCategory.iot,
      tags: ['Flutter Web/Tablet', 'MQTT', 'Glassmorphism', 'Custom Painter'],
      keyFeatures: [
        'Fluid ambient lighting controls with real-time RGB color wheel',
        'Room-by-room energy consumption breakdown and cost projections',
        'Automation routine builder with drag-and-drop triggers and actions',
        'Adaptive responsive layout scaling from phone to 24-inch smart screens',
      ],
      githubUrl: 'https://github.com/nazarulqudri/nexus-smart-home',
      liveUrl: 'https://nexus.demo.app',
      icon: Icons.home_max_rounded,
      primaryColor: Color(0xFF0284C7),
      accentColor: Color(0xFF06B6D4),
      metric: '30+ Connected Devices',
    ),
    const ProjectModel(
      id: 'zenith-task-manager',
      title: 'Zenith Collaborative Workspace',
      subtitle: 'Productivity suite with real-time markdown docs & kanban',
      description:
          'Minimalist cross-platform workspace blending task boards, markdown knowledge bases, and real-time team collaboration.',
      fullDescription:
          'Zenith combines the speed of desktop applications with the flexibility of mobile. Built completely in Flutter with riverpod state management, CRDT-based offline collaborative documents, smooth drag-and-drop kanban columns, and keyboard shortcut navigation.',
      category: ProjectCategory.mobile,
      tags: ['Flutter Desktop/Web', 'Riverpod', 'SQLite', 'Clean Arch'],
      keyFeatures: [
        'Rich text and Markdown live editor with syntax highlighting',
        'Smooth drag-and-drop Kanban board with custom velocity physics',
        'Instant multi-device synchronization via conflict-free data types',
        'Desktop-optimized shortcuts and command palette (Cmd+K)',
      ],
      githubUrl: 'https://github.com/nazarulqudri/zenith-workspace',
      liveUrl: 'https://zenith.demo.app',
      icon: Icons.dashboard_customize_rounded,
      primaryColor: Color(0xFF2563EB),
      accentColor: Color(0xFF38BDF8),
      metric: '4.9/5 User Rating',
    ),
  ];
}

