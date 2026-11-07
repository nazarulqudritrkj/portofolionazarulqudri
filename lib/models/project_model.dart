import 'package:flutter/material.dart';

enum ProjectCategory {
  all('Semua Proyek (25)', 'All Projects (25)'),
  iot('IoT & Skripsi STARZAR', 'IoT & STARZAR Thesis'),
  academicSystem('Sistem Informasi PNL', 'PNL Academic Systems'),
  mobile('Mobile & Flutter', 'Mobile & Flutter'),
  ai('Artificial Intelligence (AI)', 'Artificial Intelligence (AI)'),
  networking('Networking & Tools', 'Networking & Tools');

  final String labelId;
  final String labelEn;
  const ProjectCategory(this.labelId, this.labelEn);
}

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
    // 1. STARZAR Core 7 OSI Layer (Skripsi S.Tr.T. TRKJ PNL)
    const ProjectModel(
      id: 'starzar-smart-home-iot-skripsi',
      title: 'STARZAR - Smart Exclusive Home IoT & AI',
      subtitle: 'Proyek Skripsi: Penerapan 7 Lapisan Model OSI & AI Rule-Based System',
      description:
          'Sistem siber-fisik (Cyber-Physical System) smart home terpadu berbasis mikrokontroler ESP32, broker HiveMQ Cloud, dan aplikasi Android Flutter STARZAR dengan penerapan lengkap 7 Lapisan OSI Layer.',
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
      category: ProjectCategory.iot,
      tags: ['Flutter', 'ESP32', '7 OSI Layer', 'MQTT HiveMQ', 'AI Rule-Based', 'Hive DB', 'Smart Home'],
      keyFeatures: [
        'Penerapan Arsitektur 7 Lapisan Model OSI secara penuh (Layer 1 s/d Layer 7)',
        'Inference Engine AI Rule-Based Decision System (Forward Chaining) dengan 100% akurasi',
        'Response Time sangat cepat 180 ms & QoS standar ITU-T Y.1010/G.1010 (Packet Loss 0%)',
        'Fitur aplikasi STARZAR: Biometrik Sidik Jari, Notifikasi Pop-up Mode Senyap, & Ekspor Excel (.xlsx)',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.home_repair_service_rounded,
      primaryColor: Color(0xFF0284C7),
      accentColor: Color(0xFF38BDF8),
      metric: '100% AI • 180ms Latency',
    ),

    // 2. Sistem Informasi & Pendaftaran Kuliah Umum TIK PNL (2025 - 2026)
    const ProjectModel(
      id: 'si-kuliah-umum-tik-pnl',
      title: 'Sistem Informasi & Pendaftaran Kuliah Umum TIK PNL',
      subtitle: 'Website Pendaftaran & Manajemen Kuliah Umum Jurusan TIK 2025 - 2026',
      description:
          'Portal web pendaftaran, registrasi peserta, absensi kehadiran digital, dan pengelolaan agenda kuliah tamu / seminar akademik Jurusan Teknologi Informasi dan Komputer Politeknik Negeri Lhokseumawe.',
      fullDescription:
          'Platform web terpadu yang dirancang untuk mengotomasi alur pendaftaran dan pelaksanaan kuliah umum tahun akademik 2025 - 2026 di Jurusan TIK Politeknik Negeri Lhokseumawe.\n\n'
          'Sistem ini menghubungkan mahasiswa dari berbagai program studi (termasuk TRKJ, Teknik Informatika, dan lainnya) untuk melakukan pendaftaran online, verifikasi kuota otomatis, sistem absensi digital dengan QR Code, serta distribusi sertifikat kehadiran dan materi kuliah tamu secara terpusat.',
      category: ProjectCategory.academicSystem,
      tags: ['Web Portal', 'Laravel', 'MySQL', 'REST API', 'QR Absensi', 'TIK PNL'],
      keyFeatures: [
        'Form pendaftaran online mandiri dengan validasi NIM dan Prodi mahasiswa PNL',
        'Sistem verifikasi kuota peserta dan pencatatan presensi kehadiran digital',
        'Distribusi modul narasumber dan integrasi penerbitan e-sertifikat kegiatan',
        'Dashboard administrasi Jurusan TIK untuk rekapitulasi data pendaftar & laporan kegiatan',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://pnl.ac.id',
      icon: Icons.school_rounded,
      primaryColor: Color(0xFF2563EB),
      accentColor: Color(0xFF60A5FA),
      metric: '1.000+ Mahasiswa TIK',
    ),

    // 3. Sistem Informasi Sertifikat Dosen PNL (2025 - 2026)
    const ProjectModel(
      id: 'si-sertifikat-dosen-pnl',
      title: 'Sistem Informasi Sertifikat Dosen PNL',
      subtitle: 'Repositori & Manajemen Kredensial Sertifikasi Dosen Politeknik Negeri Lhokseumawe',
      description:
          'Sistem informasi repositori digital terpusat untuk pengarsipan, pencarian, dan verifikasi sertifikat kompetensi, keahlian, penelitian, dan pengabdian dosen Politeknik Negeri Lhokseumawe.',
      fullDescription:
          'Sistem informasi berbasis web yang memfasilitasi pengelolaan berkas sertifikat dosen di lingkungan Politeknik Negeri Lhokseumawe periode 2025 - 2026.\n\n'
          'Sistem ini menyediakan repositori digital aman untuk mengarsipkan SK dan sertifikasi kompetensi dosen, verifikasi keabsahan dokumen melalui nomor seri unik, serta mempermudah penyusunan portofolio akreditasi jurusan dan laporan Beban Kerja Dosen (BKD).',
      category: ProjectCategory.academicSystem,
      tags: ['Web System', 'Document Repository', 'Security Auth', 'RBAC', 'Audit Trail', 'PNL'],
      keyFeatures: [
        'Repositori digital terenkripsi untuk pengarsipan SK dan sertifikat kompetensi dosen PNL',
        'Fitur verifikasi keaslian dokumen sertifikat dengan nomor identifikasi unik & QR verification',
        'Pelaporan otomatis untuk kebutuhan akreditasi jurusan dan evaluasi institusi',
        'Hak akses bertingkat (Role-Based Access Control) untuk Dosen, Jurusan, dan Pimpinan Kampus',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://pnl.ac.id',
      icon: Icons.workspace_premium_rounded,
      primaryColor: Color(0xFF0D9488),
      accentColor: Color(0xFF2DD4BF),
      metric: 'Seluruh Dosen PNL',
    ),

    // 4. Sistem Informasi Sertifikat Mahasiswa/i TIK PNL (2025 - 2026)
    const ProjectModel(
      id: 'si-sertifikat-mahasiswa-tik-pnl',
      title: 'Sistem Informasi Sertifikat Mahasiswa/i TIK PNL',
      subtitle: 'Portal Penerbitan & Validasi E-Sertifikat Digital Mahasiswa TIK PNL',
      description:
          'Sistem manajemen sertifikat digital terpadu untuk menerbitkan, menyimpan, dan memvalidasi keaslian e-sertifikat kegiatan akademik, workshop, kepanitiaan, dan perlombaan mahasiswa Jurusan TIK PNL.',
      fullDescription:
          'Portal web resmi yang memfasilitasi penerbitan e-sertifikat digital bagi seluruh mahasiswa/i Jurusan Teknologi Informasi dan Komputer Politeknik Negeri Lhokseumawe.\n\n'
          'Platform ini mengintegrasikan database mahasiswa dengan generator e-sertifikat otomatis, validasi keabsahan dokumen menggunakan QR Code anti-pemalsuan, serta pencatatan riwayat prestasi untuk mendukung Surat Keterangan Pendamping Ijazah (SKPI).',
      category: ProjectCategory.academicSystem,
      tags: ['E-Certificate', 'QR Validation', 'SKPI Integration', 'Web Platform', 'TIK PNL'],
      keyFeatures: [
        'Generator e-sertifikat dinamis otomatis dengan nomor registrasi unik kampus',
        'Fitur verifikasi keabsahan dokumen instan via scan QR code anti-pemalsuan',
        'Akses mandiri bagi mahasiswa untuk mengunduh riwayat portofolio sertifikat kegiatan',
        'Dashboard monitoring rekapitulasi capaian prestasi mahasiswa bagi pengelola program studi',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://pnl.ac.id',
      icon: Icons.card_membership_rounded,
      primaryColor: Color(0xFF7C3AED),
      accentColor: Color(0xFFA78BFA),
      metric: 'Mahasiswa/i TIK PNL',
    ),

    // 5. STARZAR Mobile App (Android Flutter)
    const ProjectModel(
      id: 'starzar-app-flutter',
      title: 'Aplikasi Android Flutter STARZAR',
      subtitle: 'Layer 7 (Application Layer) Antarmuka Kontrol Cerdas Smart Home',
      description:
          'Aplikasi mobile Flutter cross-platform dengan antarmuka Clean Island modern untuk monitoring telemetri sensorik, override kendali aktuator, autentikasi sidik jari, dan ekspor riwayat data XLSX.',
      fullDescription:
          'Aplikasi Android STARZAR dibangun menggunakan Flutter SDK dengan state management BLoC dan Clean Architecture. Menjadi antarmuka utama pengguna pada Layer 7 Model OSI untuk memantau status darurat kebakaran, temperatur ruangan, dan ketersediaan air secara real-time via broker HiveMQ Cloud.',
      category: ProjectCategory.mobile,
      tags: ['Flutter', 'Dart', 'BLoC Pattern', 'Clean Arch', 'Local Auth', 'HiveMQ'],
      keyFeatures: [
        'Dashboard monitoring multi-zona dengan indikator grafik real-time dinamis',
        'Manual override tombol switch aktuator (Relay Pompa, Fan, Solenoid, Buzzer)',
        'Pemberitahuan pop-up instan dan sistem peringatan darurat mode senyap',
        'Ekspor berkas riwayat sensor format Excel (.xlsx) langsung ke memori perangkat',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.phone_android_rounded,
      primaryColor: Color(0xFF0284C7),
      accentColor: Color(0xFF38BDF8),
      metric: '60 FPS • BLoC',
    ),

    // 6. STARZAR AI Rule-Based Decision System
    const ProjectModel(
      id: 'starzar-ai-engine',
      title: 'STARZAR AI Rule-Based Decision System',
      subtitle: 'Inference Engine Otonom untuk Mitigasi Kebakaran & Krisis Rumah',
      description:
          'Implementasi kecerdasan buatan berbasis Forward Chaining pada mikrokontroler untuk mengevaluasi data multi-sensor dan mengambil tindakan protektif mandiri dalam hitungan milidetik.',
      fullDescription:
          'Engine kecerdasan buatan berbasis aturan (Rule-Based Decision System) yang bertindak sebagai otak otonom STARZAR. Menganalisis masukan sensor Gas MQ-2, Asap MQ-135, Flame IR, dan Suhu DHT22 secara simultan untuk mengeksekusi mitigasi bahaya seperti memutus aliran listrik, menyalakan exhaust fan, dan memicu sirine buzzer darurat.',
      category: ProjectCategory.ai,
      tags: ['Artificial Intelligence', 'Rule-Based System', 'Forward Chaining', 'Edge AI', 'ESP32'],
      keyFeatures: [
        'Akurasi 100% pada 10 skenario pengujian darurat kebocoran gas dan api',
        'Algoritma Forward Chaining teroptimasi memori RAM ESP32',
        'Waktu pengambilan keputusan otonom di bawah 50 ms',
        'Fail-safe mechanism untuk proteksi perangkat keras relay',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.psychology_rounded,
      primaryColor: Color(0xFF9333EA),
      accentColor: Color(0xFFC084FC),
      metric: '100% Akurasi Keputusan',
    ),

    // 7. STARZAR MQTT HiveMQ Cloud Session & Telemetry Pipeline
    const ProjectModel(
      id: 'starzar-hivemq-pipeline',
      title: 'STARZAR MQTT HiveMQ Cloud Pipeline',
      subtitle: 'Layer 4 & 5 (Transport & Session Layer) Telemetri Nirkabel Handal',
      description:
          'Arsitektur komunikasi nirkabel berbasis protokol MQTT pada broker HiveMQ Cloud dengan enkripsi TLS/SSL yang menghasilkan packet loss 0% dan latensi hanya 180 ms.',
      fullDescription:
          'Pipa telemetri nirkabel yang mengimplementasikan Layer 4 (Transport TCP) dan Layer 5 (Session MQTT) pada STARZAR. Menghubungkan multi-node ESP32 sebagai publisher dengan aplikasi Flutter sebagai subscriber secara publish/subscribe dengan topik terstruktur per zona ruangan.',
      category: ProjectCategory.iot,
      tags: ['MQTT', 'HiveMQ Cloud', 'TCP/IP', 'QoS 0/1', 'TLS Encryption', 'IoT Session'],
      keyFeatures: [
        'Kinerja QoS berstandar ITU-T Y.1010/G.1010 (Packet Loss 0%, Jitter 12 ms)',
        'Latensi rata-rata pengiriman pesan telemetri hanya 180 ms',
        'Topik MQTT terenkapsulasi: smart/kitchen, smart/living, smart/bathroom',
        'Koneksi stabil auto-reconnect dengan keep-alive timeout optimal',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.wifi_tethering_rounded,
      primaryColor: Color(0xFF0284C7),
      accentColor: Color(0xFF06B6D4),
      metric: '0% Packet Loss • 180ms',
    ),

    // 8. STARZAR Presentation Layer (JSON & Hive DB)
    const ProjectModel(
      id: 'starzar-json-hive-serializer',
      title: 'STARZAR JSON & Local Hive Serializer',
      subtitle: 'Layer 6 (Presentation Layer) Enkapsulasi & Serialisasi Data Cepat',
      description:
          'Modul penataan struktur data payload telemetri dalam format JSON String serta serialisasi penyimpanan basis data lokal NoSQL Hive pada aplikasi Flutter.',
      fullDescription:
          'Mengimplementasikan Layer 6 (Presentation Layer) Model OSI pada STARZAR. Bertanggung jawab atas formatting data sensorik dari mikrokontroler ke dalam payload JSON standar, decoding data pada aplikasi, serta caching offline menggunakan Hive DB berkecepatan tinggi.',
      category: ProjectCategory.iot,
      tags: ['JSON String', 'Hive DB', 'Presentation Layer', 'Serialization', 'Data Caching'],
      keyFeatures: [
        'Serialisasi & deserialisasi data telemetri waktu nyata dalam hitungan mikrodetik',
        'Offline-first storage dengan Hive NoSQL untuk menampung riwayat sensor',
        'Kompatibilitas parser untuk konversi data historis menjadi spreadsheet Excel',
        'Sanitasi payload untuk mencegah parsing error akibat fluktuasi jaringan',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.data_object_rounded,
      primaryColor: Color(0xFF2563EB),
      accentColor: Color(0xFF93C5FD),
      metric: 'Sub-millisecond Parsing',
    ),

    // 9. STARZAR Multi-Zone Sensor & Relay Hardware
    const ProjectModel(
      id: 'starzar-multi-sensor-node',
      title: 'STARZAR Multi-Zone Sensor & Relay Nodes',
      subtitle: 'Layer 1 & 2 (Physical & Data Link) Rancang Bangun Perangkat Keras ESP32',
      description:
          'Perancangan sirkuit perangkat keras mikrokontroler ESP32 terhubung modul relay 4-channel, 2-channel, dan 5 instrumen sensor lingkungan pada prototype smart home miniatur.',
      fullDescription:
          'Implementasi Layer 1 (Physical) dan Layer 2 (Data Link Wi-Fi 802.11) pada proyek skripsi STARZAR. Mencakup perakitan sirkuit terpadu mikrokontroler ESP32, penataan modul relay kendali beban AC/DC, kalibrasi sensor analog-to-digital, dan pengujian transmisi frame Wi-Fi.',
      category: ProjectCategory.iot,
      tags: ['ESP32', 'C++ / Arduino', 'Physical Layer', 'IEEE 802.11', 'Relay Module', 'Hardware'],
      keyFeatures: [
        'Integrasi 5 sensor lingkungan (DHT22, MQ-2, MQ-135, Flame IR, HC-SR04)',
        'Isolasi sirkuit beban relay optocoupler untuk keamanan perangkat mikrokontroler',
        'Konektivitas Wi-Fi IEEE 802.11 b/g/n dengan efisiensi daya optimal',
        'Pengkabelan rapi pada prototype miniatur 3 zona ruangan (Dapur, Tamu, Toilet)',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.memory_rounded,
      primaryColor: Color(0xFF0EA5E9),
      accentColor: Color(0xFF7DD3FC),
      metric: '5 Sensor • 3 Zona',
    ),

    // 10. Sistem Deteksi Dini Kebakaran & Kebocoran Gas (MQ-2, MQ-135, Flame IR)
    const ProjectModel(
      id: 'starzar-gas-flame-mitigation',
      title: 'Sistem Deteksi Dini Kebakaran & Gas Berbahaya',
      subtitle: 'Sub-Sistem Proteksi Zona Dapur dengan Aksi Otonom Multi-Sensor',
      description:
          'Modul penginderaan gas LPG (MQ-2), konsentrasi asap & polutan (MQ-135), dan radiasi lidah api (Flame IR) dengan respon mitigasi otomatis pengaktifan exhaust fan dan buzzer.',
      fullDescription:
          'Sub-sistem vital pada zona dapur STARZAR yang bertugas mencegah kebakaran akibat kebocoran tabung gas atau korsleting listrik. Bekerja dengan threshold adaptif untuk membedakan asap masakan biasa dengan kobaran api aktif, memicu mitigasi dalam waktu kurang dari 200 ms.',
      category: ProjectCategory.iot,
      tags: ['MQ-2', 'MQ-135', 'Flame Sensor', 'Fire Safety', 'Buzzer Alarm', 'Smart Kitchen'],
      keyFeatures: [
        'Deteksi konsentrasi gas propana/butana (PPM) dan indeks kualitas udara',
        'Deteksi spektrum cahaya inframerah dari api dengan respon instan',
        'Pemicuan otomatis relay exhaust fan untuk evakuasi gas berbahaya',
        'Sirine peringatan suara buzzer frekuensi tinggi untuk penghuni rumah',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.local_fire_department_rounded,
      primaryColor: Color(0xFFEF4444),
      accentColor: Color(0xFFFCA5A5),
      metric: 'Respon < 200ms',
    ),

    // 11. Sistem Pengendalian Suhu & Kelembaban Presisi (DHT22)
    const ProjectModel(
      id: 'starzar-climate-dht22',
      title: 'Sistem Monitoring Suhu & Kelembaban Presisi',
      subtitle: 'Pengendalian Iklim Mikro Ruang Tamu dengan Sensor DHT22 Digital',
      description:
          'Instrumen pemantau temperatur (°C) dan kelembaban nisbi udara (%RH) dengan kalibrasi presisi tinggi, terhubung dengan otomasi kipas sirkulasi udara pintar.',
      fullDescription:
          'Modul kenyamanan termal pada ruang tamu STARZAR menggunakan sensor digital DHT22 yang memiliki akurasi tinggi. Data diproses secara berkelanjutan dan divisualisasikan dalam grafik suhu dinamis pada aplikasi Android STARZAR.',
      category: ProjectCategory.iot,
      tags: ['DHT22', 'Digital Sensor', 'Temperature', 'Humidity', 'Fan Actuator', 'Smart Living'],
      keyFeatures: [
        'Akurasi pembacaan suhu ±0.5°C dan kelembaban udara ±2% RH',
        'Otomasi aktivasi kipas pendingin saat suhu melampaui batas ambang nyaman',
        'Pencatatan data deret waktu (time-series) untuk analisis fluktuasi iklim harian',
        'Tampilan gauge meter interaktif pada antarmuka aplikasi Flutter',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.thermostat_rounded,
      primaryColor: Color(0xFFF59E0B),
      accentColor: Color(0xFFFDE68A),
      metric: 'Akurasi ±0.5°C',
    ),

    // 12. Sistem Otomasi Level Air & Pompa Cerdas (Ultrasonic HC-SR04)
    const ProjectModel(
      id: 'starzar-water-management',
      title: 'Sistem Manajemen Level Air & Pompa Cerdas',
      subtitle: 'Otomasi Pengisian Tandon Air Kamar Mandi Berbasis Ultrasonic HC-SR04',
      description:
          'Sistem pengukuran jarak permukaan air menggunakan gelombang ultrasonik untuk kendali relay pompa otomatis, pencegah tumpahan air, dan pemantauan volume bak.',
      fullDescription:
          'Sub-sistem otomasi air pada kamar mandi STARZAR yang memanfaatkan sensor ultrasonik HC-SR04. Menghitung persentase volume air secara kontinu; menyalakan pompa saat air berada di batas minimum dan mematikan pengisian saat mencapai batas atas penampungan.',
      category: ProjectCategory.iot,
      tags: ['HC-SR04', 'Ultrasonic', 'Water Tank', 'Relay Pompa', 'Fluid Automation'],
      keyFeatures: [
        'Pengukuran ketinggian air non-kontak berbasis waktu pantulan gelombang suara',
        'Otomasi siklus pengisian tandon tanpa perlu campur tangan manual',
        'Proteksi dry-run dan pencegahan luapan air (anti-overflow)',
        'Indikator progress bar ketinggian air real-time di smartphone pengguna',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.water_drop_rounded,
      primaryColor: Color(0xFF06B6D4),
      accentColor: Color(0xFFA5F3FC),
      metric: 'Otomasi 100% Anti-Luap',
    ),

    // 13. Modul Autentikasi Biometrik Sidik Jari (Flutter Local_Auth)
    const ProjectModel(
      id: 'starzar-biometric-auth',
      title: 'Modul Autentikasi Biometrik Sidik Jari',
      subtitle: 'Keamanan Akses Tingkat Tinggi Aplikasi Smart Home dengan Local Auth',
      description:
          'Implementasi proteksi biometrik sidik jari dan pengenalan wajah perangkat pada aplikasi Android STARZAR sebelum pengguna diizinkan melakukan override aktuator kritis.',
      fullDescription:
          'Fitur keamanan khusus pada aplikasi STARZAR yang memanfaatkan modul `local_auth` Flutter. Mencegah akses tidak sah terhadap saklar kendali manual pintu, solenoid valve, dan pompa air, dengan mengunci sesi aplikasi saat beralih ke latar belakang.',
      category: ProjectCategory.mobile,
      tags: ['Local Auth', 'Biometrics', 'Fingerprint', 'Security', 'Flutter Mobile'],
      keyFeatures: [
        'Autentikasi sidik jari perangkat native Android yang cepat dan aman',
        'Otorisasi bertingkat untuk eksekusi fungsi saklar darurat (Manual Override)',
        'Enkripsi token lokal untuk menjaga integritas kredensial pengguna',
        'Fallback opsi PIN / Password perangkat jika biometrik tidak tersedia',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.fingerprint_rounded,
      primaryColor: Color(0xFF10B981),
      accentColor: Color(0xFF6EE7B7),
      metric: 'Bank-Grade Security',
    ),

    // 14. Modul Ekspor Data Telemetri Excel (.xlsx) Berkala
    const ProjectModel(
      id: 'starzar-xlsx-export',
      title: 'Modul Data Logger & Ekspor Spreadsheet Excel',
      subtitle: 'Pengarsipan Riwayat Sensorik Otomatis Format .XLSX untuk Audit Ilmiah',
      description:
          'Generator dokumen Excel dinamis berbasis pustaka spreadsheet Flutter yang merangkum ribuan titik data pembacaan sensor lengkap dengan stempel waktu dan status AI.',
      fullDescription:
          'Modul pengolahan data telemetri STARZAR yang memungkinkan peneliti atau pemilik rumah mengekspor riwayat sensor harian, mingguan, atau bulanan ke dalam format Microsoft Excel (.xlsx). Menjadi data pendukung validasi ilmiah dalam pengujian skripsi TRKJ PNL.',
      category: ProjectCategory.mobile,
      tags: ['Excel .xlsx', 'Data Logger', 'Spreadsheet Generator', 'Telemetry Archive', 'Flutter'],
      keyFeatures: [
        'Ekspor otomatis ribuan baris data sensorik dalam format tabel terstruktur .xlsx',
        'Pemberian stempel waktu (timestamp) terperinci hingga hitungan detik',
        'Kompilasi ringkasan statistik (nilai min, max, rata-rata konsentrasi gas & suhu)',
        'Dukungan penyimpanan langsung ke folder Unduhan atau berbagi via aplikasi',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.table_chart_rounded,
      primaryColor: Color(0xFF059669),
      accentColor: Color(0xFF34D399),
      metric: 'Instant XLSX Generation',
    ),

    // 15. Sistem Notifikasi Pop-Up Cerdas & Emergency Alerting Real-time
    const ProjectModel(
      id: 'starzar-silent-popup-alerts',
      title: 'Sistem Notifikasi Pop-Up Mode Senyap Cerdas',
      subtitle: 'Alerting Prioritas Tinggi untuk Pemberitahuan Insiden Kritis Rumah',
      description:
          'Mekanisme notifikasi in-app dan pop-up darurat yang menembus mode senyap smartphone saat sensor mendeteksi ancaman kebakaran atau kebocoran gas masif.',
      fullDescription:
          'Sistem notifikasi cerdas yang memastikan pemilik rumah segera mendapatkan peringatan visual dan getar prioritas tinggi saat terjadi kondisi darurat, meskipun ponsel dalam keadaan mode senyap (silent mode).',
      category: ProjectCategory.mobile,
      tags: ['Push Notifications', 'Pop-Up Alerts', 'Emergency Alerting', 'Silent Override', 'Flutter'],
      keyFeatures: [
        'Notifikasi pop-up dialog darurat dengan warna merah penanda status bahaya',
        'Pemberitahuan real-time langsung melalui stream MQTT tanpa jeda server',
        'Log pencatatan histori insiden yang tersimpan rapi pada basis data lokal',
        'Tombol konfirmasi respon instan untuk menonaktifkan sirine secara jarak jauh',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.notification_important_rounded,
      primaryColor: Color(0xFFDC2626),
      accentColor: Color(0xFFF87171),
      metric: 'Real-time Alert < 100ms',
    ),

    // 16. Engine Benchmark QoS Standar Internasional ITU-T Y.1010/G.1010
    const ProjectModel(
      id: 'starzar-itu-qos-benchmark',
      title: 'Engine Benchmark QoS Standar ITU-T Y.1010',
      subtitle: 'Pengujian Mutu Jaringan Komunikasi Data Berstandar Telekomunikasi Global',
      description:
          'Sistem pengujian parameter Quality of Service (QoS) meliputi Throughput (4.8 kbps), Delay (180 ms), Packet Loss (0%), dan Jitter (12 ms) sesuai standar ITU-T Y.1010 dan G.1010.',
      fullDescription:
          'Alat ukur ilmiah yang dikembangkan untuk memverifikasi keandalan transmisi data protokol IoT STARZAR. Hasil uji membuktikan seluruh parameter komunikasi data jaringan TRKJ berada dalam kategori "Sangat Bagus" menurut standarisasi internasional ITU-T.',
      category: ProjectCategory.networking,
      tags: ['ITU-T Y.1010', 'QoS Benchmark', 'Packet Loss 0%', 'Delay 180ms', 'Jitter Analysis', 'TRKJ'],
      keyFeatures: [
        'Pengukuran Throughput telemetri 4.8 kbps dengan efisiensi bandwidth tinggi',
        'Hasil Packet Loss 0% yang menjamin seluruh pesan darurat sampai ke penerima',
        'Analisis Jitter transmisi nirkabel 12 ms yang stabil tanpa fluktuasi tajam',
        'Verifikasi batas toleransi delay telekomunikasi (< 2000 ms) tercapai di 180 ms',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.network_check_rounded,
      primaryColor: Color(0xFF1D4ED8),
      accentColor: Color(0xFF60A5FA),
      metric: 'Standar Global ITU-T',
    ),

    // 17. Presensi QR Code Dinamis Anti-Titip Absen Kuliah Umum PNL
    const ProjectModel(
      id: 'pnl-dynamic-qr-presensi',
      title: 'Sistem Presensi QR Code Dinamis Kuliah Tamu PNL',
      subtitle: 'Otentikasi Kehadiran Mahasiswa dengan Kode QR Berbatas Waktu',
      description:
          'Aplikasi presensi berbasis web dengan QR Code yang diperbarui secara otomatis setiap beberapa detik untuk mencegah kecurangan titip absen dalam seminar dan kuliah umum TIK PNL.',
      fullDescription:
          'Sub-sistem keamanan presensi yang melengkapi portal pendaftaran kuliah umum Jurusan TIK PNL. Mahasiswa memindai QR code di layar proyektor menggunakan kamera ponsel mereka yang langsung mencocokkan sesi token dan geolokasi peserta.',
      category: ProjectCategory.academicSystem,
      tags: ['QR Code Dinamis', 'Anti-Fraud', 'Presensi Kampus', 'Security Token', 'TIK PNL'],
      keyFeatures: [
        'QR Code dinamis beregenerasi setiap 10 detik menggunakan enkripsi token',
        'Pencegahan duplikasi tangkapan layar (screenshot) oleh peserta lain',
        'Validasi instan NIM mahasiswa dan kuota kehadiran kelas seminar',
        'Rekapitulasi otomatis data hadir dalam format CSV/Excel untuk panitia',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://pnl.ac.id',
      icon: Icons.qr_code_scanner_rounded,
      primaryColor: Color(0xFF2563EB),
      accentColor: Color(0xFF38BDF8),
      metric: 'Anti-Fraud Presensi',
    ),

    // 18. Sistem E-Verifikasi Keabsahan Dokumen SKPI Mahasiswa TIK PNL
    const ProjectModel(
      id: 'pnl-skpi-portfolio-generator',
      title: 'Portal Generator & Validasi SKPI Mahasiswa PNL',
      subtitle: 'Sistem Rekapitulasi Capaian Portofolio Surat Keterangan Pendamping Ijazah',
      description:
          'Platform digital kompilasi capaian sertifikat pelatihan, prestasi perlombaan, dan organisasi mahasiswa Jurusan TIK PNL untuk penerbitan SKPI berstandar nasional.',
      fullDescription:
          'Sistem informasi yang mengotomasi verifikasi dokumen penunjang kelulusan mahasiswa Politeknik Negeri Lhokseumawe. Menghasilkan lembar lampiran SKPI resmi dengan kode QR verifikasi publik bagi pengguna lulusan (perusahaan dan instansi).',
      category: ProjectCategory.academicSystem,
      tags: ['SKPI', 'Kredensial Kampus', 'Portofolio Mahasiswa', 'Verifikasi Digital', 'PNL'],
      keyFeatures: [
        'Pencatatan riwayat prestasi dan 11 sertifikasi kompetensi mahasiswa',
        'Sistem peninjauan (review) dan persetujuan berkas oleh dosen pembimbing',
        'Penerbitan dokumen SKPI berformat standar kementerian dengan QR Code sah',
        'Pencarian kredensial publik bagi rekruter untuk mengecek keaslian lulusan',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://pnl.ac.id',
      icon: Icons.fact_check_rounded,
      primaryColor: Color(0xFF7C3AED),
      accentColor: Color(0xFFC084FC),
      metric: 'Standar Nasional SKPI',
    ),

    // 19. Repositori Digital SK & Kredensial Beban Kerja Dosen (BKD) PNL
    const ProjectModel(
      id: 'pnl-document-archive-system',
      title: 'Sistem Arsip Digital SK & Kredensial BKD PNL',
      subtitle: 'Pengarsipan Surat Keputusan & Portofolio Dosen Terintegrasi Cloud',
      description:
          'Repositori dokumen terpusat untuk mempermudah dosen mengunggah dan mengelompokkan SK pengajaran, penelitian, pengabdian masyarakat, dan sertifikat kompetensi profesi.',
      fullDescription:
          'Modul pengarsipan digital khusus dosen Politeknik Negeri Lhokseumawe yang dirancang untuk mempercepat proses pelaporan Beban Kerja Dosen (BKD) semesteran dan audit akreditasi program studi TRKJ.',
      category: ProjectCategory.academicSystem,
      tags: ['BKD Dosen', 'Arsip Digital', 'Akreditasi Kampus', 'Cloud Storage', 'PNL'],
      keyFeatures: [
        'Kategorisasi otomatis Tri Dharma Perguruan Tinggi (Pengajaran, Riset, Pengabdian)',
        'Penyimpanan cloud terenkripsi dengan audit log pengunduhan dokumen',
        'Pencarian cerdas berdasarkan tahun akademik, nomor SK, dan nama dosen',
        'Ekspor berkas portofolio instan saat visitasi asesor akreditasi LAM-INFOKOM',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://pnl.ac.id',
      icon: Icons.folder_shared_rounded,
      primaryColor: Color(0xFF0D9488),
      accentColor: Color(0xFF5EEAD4),
      metric: 'Audit-Ready System',
    ),

    // 20. Virtual AI Assistant Chatbot (Google AI Studio & Gemini API Integration)
    const ProjectModel(
      id: 'gemini-ai-studio-assistant',
      title: 'Virtual AI Assistant dengan Google AI Studio',
      subtitle: 'Integrasi Kecerdasan Buatan Generatif untuk Layanan Informasi & FAQ',
      description:
          'Asisten percakapan cerdas yang terintegrasi dengan Google AI Studio dan Gemini API pada aplikasi Flutter, dirancang untuk menjawab pertanyaan teknis dan akademik secara kontekstual.',
      fullDescription:
          'Implementasi integrasi Generative AI modern yang menghubungkan aplikasi mobile Flutter dengan model bahasa besar melalui Gemini API. Menggunakan prompt engineering terarah dan context memory untuk memberikan panduan sistem rumah cerdas maupun informasi akademik kampus.',
      category: ProjectCategory.ai,
      tags: ['Google AI Studio', 'Gemini API', 'Generative AI', 'Chatbot', 'Flutter Integration'],
      keyFeatures: [
        'Konektivitas langsung ke Google AI Studio dengan parameter respons yang presisi',
        'Pemahaman bahasa alami Bahasa Indonesia dan Inggris secara fasih',
        'Streaming respons teks interaktif tanpa jeda (smooth typing effect)',
        'Penanganan konteks dialog berbasis sesi untuk percakapan multi-turn yang akurat',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.smart_toy_rounded,
      primaryColor: Color(0xFF8B5CF6),
      accentColor: Color(0xFFDDD6FE),
      metric: 'Gemini AI Powered',
    ),

    // 21. Prototipe Smart Campus IoT - Delegasi Inovasi Perangkat Lunak KMIPN VI
    const ProjectModel(
      id: 'kmipn-smart-campus-iot',
      title: 'Smart Campus IoT Ecosystem (KMIPN VI)',
      subtitle: 'Karya Kompetisi Mahasiswa Bidang Informatika Politeknik Nasional VI 2025',
      description:
          'Karya rekayasa sistem terdistribusi pemantau energi gedung kampus dan kualitas udara laboratorium yang dipresentasikan pada ajang bergengsi nasional KMIPN VI.',
      fullDescription:
          'Proyek inovasi teknologi yang mewakili Politeknik Negeri Lhokseumawe dalam ajang KMIPN VI tahun 2025 di Politeknik Negeri Jakarta. Mengintegrasikan jaringan sensor nirkabel berdaya hemat energi untuk efisiensi listrik gedung kuliah dan pemantauan lingkungan lab komputer.',
      category: ProjectCategory.iot,
      tags: ['KMIPN VI 2025', 'Smart Campus', 'IoT Energy', 'Wireless Sensor Network', 'Nasional'],
      keyFeatures: [
        'Monitoring konsumsi energi listrik ruangan menggunakan sensor arus non-invasif',
        'Dashboard terpusat untuk pemantauan suhu dan sirkulasi udara ruang server',
        'Notifikasi efisiensi daya saat ruangan kuliah selesai digunakan',
        'Karya delegasi resmi mahasiswa Politeknik Negeri Lhokseumawe tingkat nasional',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.emoji_events_rounded,
      primaryColor: Color(0xFFF59E0B),
      accentColor: Color(0xFFFCD34D),
      metric: 'KMIPN VI Finalist',
    ),

    // 22. Topologi Jaringan Komputer VLAN & Routing Lab TIK PNL
    const ProjectModel(
      id: 'trkj-vlan-network-topology',
      title: 'Desain Topologi VLAN & Routing Lab TIK PNL',
      subtitle: 'Arsitektur Jaringan Komputer Terdistribusi Laboratorium TRKJ PNL',
      description:
          'Perancangan arsitektur jaringan komputer lokal (LAN), segmentasi Virtual LAN (VLAN), access control list (ACL), dan routing antar-switch untuk keamanan data praktikum mahasiswa.',
      fullDescription:
          'Proyek rekayasa infrastruktur jaringan komputer di lingkungan laboratorium Jurusan TIK PNL. Menerapkan segmentasi jaringan aman antar-laboratorium, manajemen alokasi subnet IP secara dinamis (DHCP Server), dan firewall proteksi transmisi data.',
      category: ProjectCategory.networking,
      tags: ['VLAN', 'Routing & Switching', 'Network Topology', 'Cisco Packet Tracer', 'TRKJ PNL'],
      keyFeatures: [
        'Segmentasi 8 VLAN terpisah untuk isolasi lalu lintas data praktikum laboratorium',
        'Penerapan Inter-VLAN Routing dengan bandwidth throughput tinggi tanpa bottleneck',
        'Access Control List (ACL) untuk mencegah penyusupan dan akses ilegal ke server lab',
        'Dokumentasi teknis skema pengalamatan IP dan diagram topologi standar TRKJ',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://pnl.ac.id',
      icon: Icons.lan_rounded,
      primaryColor: Color(0xFF1E40AF),
      accentColor: Color(0xFF93C5FD),
      metric: 'Enterprise VLAN Design',
    ),

    // 23. Web Portofolio Clean Island Modern (Flutter 3 Web & Glassmorphism)
    const ProjectModel(
      id: 'portfolio-clean-island-flutter',
      title: 'Website Portofolio Profesional Clean Island',
      subtitle: 'Aplikasi Web & Mobile Responsif Dibangun dengan Flutter 3 & Glassmorphism',
      description:
          'Platform portofolio digital pribadi berkecepatan 60 FPS, didukung tema Clean Island, efek light glassmorphism, bilingual ID/EN, zoom modal kredensial, dan hosting GitHub Pages.',
      fullDescription:
          'Karya rekayasa antarmuka web modern yang mengimplementasikan arsitektur kode modular Flutter. Menampilkan rekam jejak akademik resmi (Ijazah & Transkrip S.Tr.T.), prestasi perlombaan, 11 sertifikat pelatihan Kominfo DTS, dan 25 proyek rekayasa asli secara interaktif.',
      category: ProjectCategory.mobile,
      tags: ['Flutter Web', 'Clean Island', 'Glassmorphism', 'Bilingual ID/EN', 'GitHub Pages'],
      keyFeatures: [
        'Desain Clean Island minimalis, segar, elegan, dan didukung mikro-interaksi responsif',
        'Modal zoomable beresolusi tinggi hingga 400% untuk verifikasi dokumen Ijazah & Transkrip',
        'Sistem dwi-bahasa (Bahasa Indonesia & Bahasa Inggris) instan tanpa reload halaman',
        'Build rilis teroptimasi dengan tree-shaking font dan deployment otomatis GitHub Pages',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj/portofolionazarulqudri',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.web_rounded,
      primaryColor: Color(0xFF0284C7),
      accentColor: Color(0xFF38BDF8),
      metric: '60 FPS • Flutter Web',
    ),

    // 24. Wireless Environmental Telemetry Node Berdaya Rendah (ESP8266)
    const ProjectModel(
      id: 'esp8266-environmental-telemetry',
      title: 'Wireless Environmental Node (ESP8266)',
      subtitle: 'Node Pemantau Lingkungan Berdaya Rendah dengan Protokol Sleep Mode',
      description:
          'Prototipe perangkat IoT nirkabel hemat energi berbasis ESP8266 dengan optimasi deep sleep cycle untuk pemantauan jangka panjang kondisi fisik ruangan tanpa pergantian baterai berkala.',
      fullDescription:
          'Pengembangan modul sensor jarak jauh untuk pemantauan lingkungan cerdas. Memanfaatkan siklus deep sleep ESP8266 untuk menekan konsumsi arus listrik hingga di bawah 20 µA, mengirimkan paket data telemetri secara berkala via Wi-Fi.',
      category: ProjectCategory.iot,
      tags: ['ESP8266', 'Low Power IoT', 'Deep Sleep Mode', 'Telemetry Node', 'Hardware Design'],
      keyFeatures: [
        'Efisiensi konsumsi daya dengan pemanfaatan deep sleep mode terprogram',
        'Penyalaan instan modul Wi-Fi dan transmisi paket data cepat (< 2 detik)',
        'Monitoring voltase baterai terintegrasi untuk peringatan penggantian daya',
        'Format casing kompak yang fleksibel ditempatkan pada sudut ruangan',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://nazarulqudritrkj.github.io/portofolionazarulqudri/',
      icon: Icons.sensors_rounded,
      primaryColor: Color(0xFF059669),
      accentColor: Color(0xFF6EE7B7),
      metric: 'Ultra Low Power <20µA',
    ),

    // 25. Sistem Backup Terdistribusi & Sinkronisasi Database Otomatis PNL
    const ProjectModel(
      id: 'automated-db-backup-disaster',
      title: 'Sistem Backup & Sinkronisasi Database Terdistribusi',
      subtitle: 'Manajemen Keandalan Data & Disaster Recovery Server Lokal PNL',
      description:
          'Skrip otomasi pencadangan basis data terdistribusi dengan kompresi data, enkripsi AES, dan sinkronisasi berkala ke server sekunder untuk pemulihan bencana sistem kampus.',
      fullDescription:
          'Sistem pemeliharaan keandalan data untuk menjamin keamanan database sistem informasi Jurusan TIK PNL. Bekerja secara otomatis di latar belakang untuk melakukan snapshot data berkala, memeriksa integritas file backup, dan melakukan failover otomatis.',
      category: ProjectCategory.networking,
      tags: ['Disaster Recovery', 'Database Backup', 'AES Encryption', 'Shell Automation', 'Server Security'],
      keyFeatures: [
        'Pencadangan database MySQL/MariaDB terjadwal otomatis tanpa downtime layanan',
        'Enkripsi berkas backup menggunakan standar keamanan AES-256 bit',
        'Sinkronisasi aman antar-server menggunakan protokol SSH/SCP',
        'Notifikasi log otomatis ke surel administrator saat backup berhasil atau gagal',
      ],
      githubUrl: 'https://github.com/nazarulqudritrkj',
      liveUrl: 'https://pnl.ac.id',
      icon: Icons.backup_rounded,
      primaryColor: Color(0xFF334155),
      accentColor: Color(0xFF94A3B8),
      metric: 'Zero Data Loss',
    ),
  ];
}
