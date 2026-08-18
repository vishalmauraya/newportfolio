import 'package:flutter/material.dart';

class ProjectModel {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final List<String> bulletPoints;
  final List<String> techStack;
  final String timeframe;
  final IconData icon;
  final Color themeColor;
  final String githubUrl;
  final String liveUrl;
  final bool hasLiveSimulator;
  final Map<String, dynamic> metrics;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.bulletPoints,
    required this.techStack,
    required this.timeframe,
    required this.icon,
    required this.themeColor,
    this.githubUrl = 'https://github.com/vishalmauraya',
    this.liveUrl = 'https://github.com/vishalmauraya',
    this.hasLiveSimulator = true,
    this.metrics = const {},
  });
}

class SkillItem {
  final String name;
  final double proficiency; // 0.0 to 1.0
  final IconData icon;
  final String category;
  final Color color;
  final String description;

  const SkillItem({
    required this.name,
    required this.proficiency,
    required this.icon,
    required this.category,
    required this.color,
    required this.description,
  });
}

class ExperienceModel {
  final String role;
  final String company;
  final String period;
  final String location;
  final bool isCurrent;
  final List<String> highlights;
  final List<String> skills;
  final Color badgeColor;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.period,
    required this.location,
    required this.isCurrent,
    required this.highlights,
    required this.skills,
    required this.badgeColor,
  });
}

class EducationModel {
  final String degree;
  final String institution;
  final String score;
  final String period;
  final String location;
  final String details;

  const EducationModel({
    required this.degree,
    required this.institution,
    required this.score,
    required this.period,
    required this.location,
    required this.details,
  });
}

class PortfolioData {
  // Personal Details
  static const String name = 'Vishal Kumar';
  static const String title = 'Flutter & Mobile Frontend Engineer';
  static const String tagline =
      'Building ultra-smooth 60 FPS cross-platform apps with reactive architectures, pixel-perfect UI, and robust real-time cloud integrations.';
  static const String bio =
      'Passionate Flutter Developer with 1+ years of commercial experience specializing in crafting pixel-perfect, highly performant applications across Mobile, Web, and Desktop. Expert in Riverpod, Bloc, Firebase real-time pipelines, and telematics/sensor telemetry handling.';
  
  static const String email = 'maurayavishal47@gmail.com';
  static const String phone = '+91 92649 24169';
  static const String location = 'Lucknow, Uttar Pradesh, India';
  static const String github = 'https://github.com/vishalmauraya';
  static const String linkedin = 'https://linkedin.com/in/vishal-kumar-600438257';
  static const String whatsapp = 'https://wa.me/919264924169?text=Hi%20Vishal,%20I%20saw%20your%20portfolio%20and%20would%20like%20to%20connect!';

  // Key Stats
  static const List<Map<String, dynamic>> stats = [
    {
      'value': '1+',
      'label': 'Years Commercial Exp',
      'icon': Icons.work_history,
      'color': Color(0xFF00F2FE),
    },
    {
      'value': '3+',
      'label': 'Production Apps',
      'icon': Icons.phone_android,
      'color': Color(0xFF7F00FF),
    },
    {
      'value': '60 FPS',
      'label': 'Fluid Frame Rate',
      'icon': Icons.bolt,
      'color': Color(0xFF00F5A0),
    },
    {
      'value': '100%',
      'label': 'Pixel-Perfect Fidelity',
      'icon': Icons.auto_awesome,
      'color': Color(0xFFFF4B72),
    },
  ];

  // Projects
  static final List<ProjectModel> projects = [
    ProjectModel(
      id: 'driver_quest',
      title: 'Driver Quest',
      subtitle: 'Realtime Telematics & Driving Safety App',
      description:
          'Advanced mobile telematics application for monitoring real-time driving behavior, calculating live safety scores via sensor telemetry streams, Google Maps route polylines, and Stripe billing.',
      bulletPoints: [
        'Realtime monitoring of driving skills using Google Maps API and device gyroscope & accelerometer data streams.',
        'High-frequency sensor stream processing for smooth polyline tracking, aggressive turn detection, and live driver score calculation.',
        'Seamless in-app Stripe payment checkout for premium driver reports and safety tier subscriptions.',
        'Robust Riverpod reactive state management with offline trip caching and background syncing.',
      ],
      techStack: [
        'Flutter',
        'Riverpod',
        'Stripe Payment',
        'Google Maps API',
        'Sensor Telemetry Streams',
        'Dart',
      ],
      timeframe: 'Oct 2025 – June 2026',
      icon: Icons.drive_eta,
      themeColor: const Color(0xFF00F2FE),
      metrics: {
        'Safety Score': '96/100',
        'Latency': '< 45ms',
        'Sensor Rate': '50 Hz',
      },
    ),
    ProjectModel(
      id: 'yatri_cabs',
      title: 'Yatri Cabs App',
      subtitle: 'Full-Stack Ride-Sharing Dual-App Ecosystem',
      description:
          'Comprehensive ride-hailing platform consisting of separate rider and driver partner mobile apps with custom glassmorphic dark-mode UI, live socket updates, and push notifications.',
      bulletPoints: [
        'Built full-featured dual applications for riders and drivers with custom styling and ultra-sleek dark mode.',
        'Integrated socket-based live vehicle tracking and dynamic route recalculation for real-time driver arrival updates.',
        'Configured Firebase Cloud Messaging (FCM) for instant ride booking notifications, OTP verification, and receipts.',
        'Engineered scalable REST APIs integration with MongoDB for ride history, wallet transactions, and driver payouts.',
      ],
      techStack: [
        'Flutter',
        'Riverpod',
        'REST APIs',
        'MongoDB',
        'WebSockets',
        'FCM Push Notifications',
        'Dark Mode UI',
      ],
      timeframe: 'Dec 2024 – Oct 2024',
      icon: Icons.local_taxi,
      themeColor: const Color(0xFFFFB300),
      metrics: {
        'Active Rides': 'Live Sync',
        'Dark Theme': '100% OLED',
        'Push Latency': '< 200ms',
      },
    ),
    ProjectModel(
      id: 'weather_app',
      title: 'Aether Weather App',
      subtitle: 'Dynamic Atmospheric Visualizer & Live Forecast',
      description:
          'High-polish weather visualizer built with Flutter and Bloc state management, featuring real-time meteorological API data, dynamic animated particle sky backgrounds, and sunrise/sunset arc tracking.',
      bulletPoints: [
        'Real-time atmospheric telemetry including temperature, humidity, wind velocity, precipitation index, and UV levels.',
        'Rich custom animated canvas weather icons and location-aware adaptive lighting themes.',
        'Precision golden hour, sunrise, and sunset orbital arc visualization for accurate solar timing.',
        'Clean Bloc architecture with event-driven data caching and instant network fallback.',
      ],
      techStack: [
        'Flutter',
        'Bloc Pattern',
        'OpenWeather REST API',
        'Animated Canvas',
        'Geolocator',
        'Dart',
      ],
      timeframe: '2025',
      icon: Icons.wb_sunny,
      themeColor: const Color(0xFF00F5A0),
      metrics: {
        'Forecast Accuracy': 'Hour-by-Hour',
        'Animations': '60 FPS Canvas',
        'Cities Supported': 'Worldwide',
      },
    ),
  ];

  // Skills
  static final List<SkillItem> skills = [
    // Languages
    SkillItem(
      name: 'Dart',
      proficiency: 0.95,
      icon: Icons.code,
      category: 'Languages',
      color: const Color(0xFF00F2FE),
      description: 'Asynchronous streams, isolates, mixins, extension methods & null-safety.',
    ),
    SkillItem(
      name: 'JavaScript / ES6+',
      proficiency: 0.88,
      icon: Icons.javascript,
      category: 'Languages',
      color: const Color(0xFFF7DF1E),
      description: 'Modern JavaScript, promises, DOM manipulation & responsive web logic.',
    ),
    SkillItem(
      name: 'Java',
      proficiency: 0.85,
      icon: Icons.data_object,
      category: 'Languages',
      color: const Color(0xFFE76F51),
      description: 'Object-oriented programming, data structures & Android platform channels.',
    ),
    SkillItem(
      name: 'C++',
      proficiency: 0.80,
      icon: Icons.integration_instructions,
      category: 'Languages',
      color: const Color(0xFF00599C),
      description: 'Algorithms, memory optimization & algorithmic problem solving.',
    ),
    SkillItem(
      name: 'Python',
      proficiency: 0.78,
      icon: Icons.terminal,
      category: 'Languages',
      color: const Color(0xFF3776AB),
      description: 'Automation scripts, backend prototyping & data parsing.',
    ),

    // Frameworks & State Management
    SkillItem(
      name: 'Flutter (Mobile & Web)',
      proficiency: 0.95,
      icon: Icons.flutter_dash,
      category: 'Frameworks & State',
      color: const Color(0xFF4FACFE),
      description: 'Custom render widgets, animations, responsive layout & performance profiling.',
    ),
    SkillItem(
      name: 'Riverpod',
      proficiency: 0.92,
      icon: Icons.account_tree,
      category: 'Frameworks & State',
      color: const Color(0xFF00F5A0),
      description: 'Compile-safe reactive state, auto-dispose providers & family modifier caches.',
    ),
    SkillItem(
      name: 'Bloc Pattern',
      proficiency: 0.88,
      icon: Icons.dynamic_form,
      category: 'Frameworks & State',
      color: const Color(0xFF7F00FF),
      description: 'Predictable unidirectional data flow, event-state mapping & unit testing.',
    ),
    SkillItem(
      name: 'Provider & GetX',
      proficiency: 0.86,
      icon: Icons.layers,
      category: 'Frameworks & State',
      color: const Color(0xFFFF4B72),
      description: 'Lightweight dependency injection, route management & state scoping.',
    ),
    SkillItem(
      name: 'Bootstrap & Modern CSS',
      proficiency: 0.84,
      icon: Icons.style,
      category: 'Frameworks & State',
      color: const Color(0xFF7952B3),
      description: 'Flexbox, CSS grid, glassmorphism, responsive media queries & styling.',
    ),

    // Databases & Cloud
    SkillItem(
      name: 'Firebase (Auth, Firestore, FCM)',
      proficiency: 0.92,
      icon: Icons.local_fire_department,
      category: 'Cloud & Databases',
      color: const Color(0xFFFFCA28),
      description: 'Real-time database streams, push notifications & secure token auth.',
    ),
    SkillItem(
      name: 'MongoDB',
      proficiency: 0.82,
      icon: Icons.storage,
      category: 'Cloud & Databases',
      color: const Color(0xFF47A248),
      description: 'Document database schema modeling, aggregation pipelines & indexing.',
    ),
    SkillItem(
      name: 'MySQL',
      proficiency: 0.80,
      icon: Icons.dns,
      category: 'Cloud & Databases',
      color: const Color(0xFF4479A1),
      description: 'Relational data modeling, SQL queries, joins & transactions.',
    ),
    SkillItem(
      name: 'REST APIs & WebSockets',
      proficiency: 0.90,
      icon: Icons.cloud_sync,
      category: 'Cloud & Databases',
      color: const Color(0xFF00F2FE),
      description: 'JSON serialization, socket connection lifecycle & error interceptors.',
    ),

    // Tools & Ecosystem
    SkillItem(
      name: 'Git & GitHub',
      proficiency: 0.92,
      icon: Icons.source,
      category: 'Tools & IDEs',
      color: const Color(0xFFF05032),
      description: 'Version control, feature branching, merge conflict resolution & PR reviews.',
    ),
    SkillItem(
      name: 'Android Studio & VS Code',
      proficiency: 0.94,
      icon: Icons.laptop_chromebook,
      category: 'Tools & IDEs',
      color: const Color(0xFF3DDC84),
      description: 'Flutter DevTools, CPU/Memory profiler, Dart analyzer & debugging.',
    ),
    SkillItem(
      name: 'Linux & Terminal',
      proficiency: 0.85,
      icon: Icons.terminal,
      category: 'Tools & IDEs',
      color: const Color(0xFFFCC624),
      description: 'Bash scripting, file manipulation, environment variables & build automation.',
    ),
    SkillItem(
      name: 'Xcode & iOS Toolchain',
      proficiency: 0.80,
      icon: Icons.phone_iphone,
      category: 'Tools & IDEs',
      color: const Color(0xFF007AFF),
      description: 'iOS build configurations, CocoaPods, provisioning & simulator debugging.',
    ),
  ];

  // Work Experience
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'The MetroMax Group',
      period: 'Oct 2025 – Jun 2026',
      location: 'Remote',
      isCurrent: true,
      badgeColor: Color(0xFF00F2FE),
      highlights: [
        'Developed and architected core business logic for the Drive Safe enterprise telematics application.',
        'Collaborated with cross-functional teams for weekly feature rollouts and real-time screen updates using reactive Dart streams.',
        'Built low-latency background sensor monitoring pipelines capturing accelerometer and gyroscope telemetry.',
        'Optimized widget rebuild trees, resulting in buttery-smooth 60 FPS transitions on varied hardware configurations.',
      ],
      skills: ['Flutter', 'Dart Streams', 'Background Sensors', 'Riverpod', 'Telemetry APIs', 'Git'],
    ),
    ExperienceModel(
      role: 'Flutter Developer',
      company: 'Aarsaar Technologies Pvt. Ltd.',
      period: 'Dec 2024 – Sept 2025',
      location: 'Remote',
      isCurrent: false,
      badgeColor: Color(0xFF7F00FF),
      highlights: [
        'Developed dynamic, responsive UI screens following pixel-perfect Figma design guidelines.',
        'Integrated backend REST APIs with resilient retry logic, token caching, and error handling.',
        'Collaborated in agile sprint teams to deliver customer-facing app updates ahead of deadlines.',
        'Conducted code reviews, debugged edge-case UI rendering bugs, and refined multi-resolution responsiveness.',
      ],
      skills: ['Flutter', 'REST APIs', 'Provider', 'UI/UX Design', 'Firebase Auth', 'JSON Parsing'],
    ),
  ];

  // Education
  static const List<EducationModel> education = [
    EducationModel(
      degree: 'Bachelor of Technology - Computer Science & Engineering',
      institution: 'Central University of Haryana',
      score: '74.4%',
      period: '2021 – 2025',
      location: 'Mahendragarh, India',
      details:
          'Focused on Software Engineering, Object-Oriented Design, Operating Systems, Data Structures & Algorithms, and Distributed Computing.',
    ),
    EducationModel(
      degree: 'Class XII (Senior Secondary)',
      institution: 'Lucknow Public College',
      score: '89.6% (U.P. Board)',
      period: '2020 – 2021',
      location: 'Lucknow, India',
      details:
          'Physics, Chemistry, and Mathematics (PCM) with Distinction honors.',
    ),
  ];
}
