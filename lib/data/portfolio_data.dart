import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/skill_model.dart';

class PortfolioData {
  // ──── EXPERIENCES ────
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      company: 'Vasundhara Infotech',
      role: 'Flutter Developer',
      duration: 'Sep 2025',
      location:
          'Vasundhara Infotech, Opp Nayara Petrol Pump, Singanpore, Road, Katargam, Surat, Gujarat 395004',
      isCurrent: true,
      emoji: '🚀',
      companyLogoPath: 'assets/images/company/vasundhara.jpg',
      highlights: [
        'Building AI Image Generator Studio – an iOS-exclusive creative app',
        'Expert-level App Caching for lightning-fast image rendering',
        'Integrated Firebase Crashlytics for real-time crash monitoring',
        'OneSignal push notifications with advanced segmentation',
        'Firebase Analytics for comprehensive user event tracking',
        'Performance optimization reducing cold start by 40%',
      ],
    ),
    ExperienceModel(
      company: 'SmartTechnica Infotech',
      role: 'Flutter Developer',
      duration: 'Mar 2024 - Aug 2025',
      location:
          'Golden Chowk, 301, Green Plaza, Golden City Rd, near Dmart, Mota Varachha, Surat, Gujarat 394105',
      isCurrent: false,
      emoji: '💡',
      companyLogoPath: 'assets/images/company/smart_technica.jpg',
      highlights: [
        'Developed Kutuma – a social commerce & live shopping app',
        'Built Munshiji – a business accounting & GST management app',
        'Implemented GetX state management across multiple modules',
        'REST API integration with complex data transformation logic',
      ],
    ),
    ExperienceModel(
      company: 'Weapp Infotech',
      role: 'Flutter Developer',
      duration: 'Sep 2023 – Feb 2024',
      location:
          'Sudama Chowk, 205, Varani Plaza, Mata Varachha Main Rd, Mota Varachha, Surat, Gujarat 394105',
      isCurrent: false,
      emoji: '📓',
      companyLogoPath: 'assets/images/company/weapp.png',
      highlights: [
        'Developed My Diary – a private personal journaling application',
        'Implemented local authentication (PIN / biometric)',
        'Used BLoC pattern for clean state management architecture',
      ],
    ),
    ExperienceModel(
      company: 'Successoft InfoTech',
      role: 'Flutter Trainee',
      duration: 'Feb 2023 – Aug 2023',
      location: '401-Elita Square, VIP Cir, Uttran, Surat, Gujarat 394105',
      isCurrent: false,
      emoji: '🎓',
      companyLogoPath: 'assets/images/company/successoft.jpg',
      highlights: [
        'Completed professional Flutter & Dart training program',
        'Built foundational apps: weather, todo, quiz applications',
        'Learned Firebase ecosystem, REST APIs, and UI/UX best practices',
      ],
    ),
  ];

  // ──── PROJECTS ────
  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'AI Image Generator Studio',
      description:
          'A cutting-edge iOS-exclusive app that transforms text prompts into stunning AI-generated artwork. Features advanced caching, real-time generation, and premium image filters.',
      company: 'Vasundhara Infotech',
      techStack: [
        'REST API',
        'Crashlytics',
        'OneSignal',
        'Analytics',
        'Microsoft Clarity',
      ],
      isIosExclusive: true,
      isFeatured: true,
      emoji: '🎨',
      gradientStart: '#54C5F8',
      gradientEnd: '#01579B',
      bannerImagePathLight:
          'assets/images/application_banners/ai_img_light.jpg',
      bannerImagePathDark: 'assets/images/application_banners/ai_img_dark.jpg',
      appStoreUrl:
          'https://apps.apple.com/in/app/ai-image-generator-studio/id6753969752',
      companyLogoPath: 'assets/images/company/vasundhara.jpg',
    ),
    ProjectModel(
      title: 'Kutuma',
      description:
          'A social-commerce platform enabling live shopping sessions, product discovery, and real-time buyer-seller interactions with integrated payment gateway.',
      company: 'SmartTechnica Infotech',
      techStack: ['GetX', 'REST APIs', 'Firebase', 'Push Notification'],
      emoji: '🛍️',
      gradientStart: '#54C5F8',
      gradientEnd: '#01579B',
      bannerImagePathLight:
          'assets/images/application_banners/kutuma_light.jpg',
      bannerImagePathDark: 'assets/images/application_banners/kutuma_dark.jpg',
      appStoreUrl: 'https://apps.apple.com/in/app/kutma/id6450180417',
      playStoreUrl: 'https://play.google.com/store/apps/details?id=com.kutuma',
      companyLogoPath: 'assets/images/company/smart_technica.jpg',
    ),
    ProjectModel(
      title: 'Munshiji',
      description:
          'A comprehensive business accounting app simplifying GST billing, invoice management, and financial reporting for small and medium businesses.',
      company: 'SmartTechnica Infotech',
      techStack: ['GetX', 'REST APIs', 'Analytics', 'Crashlytics'],
      emoji: '📊',
      gradientStart: '#54C5F8',
      gradientEnd: '#01579B',
      bannerImagePathLight:
          'assets/images/application_banners/munshiji_light.jpg',
      bannerImagePathDark:
          'assets/images/application_banners/munshiji_dark.jpg',
      appStoreUrl:
          'https://apps.apple.com/in/app/munshiji-daily-expense-tracker/id6747757014',
      companyLogoPath: 'assets/images/company/smart_technica.jpg',
    ),
    ProjectModel(
      title: 'My Diary',
      description:
          'A private, beautifully designed personal journaling app with biometric lock, mood tracking, location tagging, and rich text entries.',
      company: 'Weapp Infotech',
      techStack: ['GetX', 'Firestore', 'Realtime Database', 'SQLite'],
      emoji: '📝',
      gradientStart: '#54C5F8',
      gradientEnd: '#01579B',
      bannerImagePathLight:
          'assets/images/application_banners/my_dairy_light.jpg',
      bannerImagePathDark:
          'assets/images/application_banners/my_dairy_dark.jpg',
      companyLogoPath: 'assets/images/company/weapp.png',
    ),
  ];

  // ──── SKILLS ────
  static List<SkillModel> get skills => [
        SkillModel(
          name: 'Flutter',
          icon: FontAwesomeIcons.mobile,
          color: const Color(0xFF54C5F8), // Flutter blue
          category: 'Core',
          imagePath: 'assets/images/technologies/flutter.png',
        ),
        SkillModel(
          name: 'Dart',
          icon: FontAwesomeIcons.code,
          color: const Color(0xFF00539C), // Dart navy blue
          category: 'Core',
          imagePath: 'assets/images/technologies/dart.png',
        ),
        SkillModel(
          name: 'Firebase',
          icon: FontAwesomeIcons.fire,
          color: const Color(0xFFFF6F00), // Firebase orange
          category: 'Backend',
          imagePath: 'assets/images/technologies/firebase.png',
        ),
        SkillModel(
          name: 'Firestore',
          icon: FontAwesomeIcons.database,
          color: const Color(0xFFFFA000), // Firestore amber/yellow
          category: 'Backend',
          imagePath: 'assets/images/technologies/firestore.png',
        ),
        SkillModel(
          name: 'SQLite',
          icon: FontAwesomeIcons.database,
          color: const Color(0xFF0F80CC), // MS Clarity blue/indigo
          category: 'Integration',
          imagePath: 'assets/images/technologies/sqflight.png',
        ),
        SkillModel(
          name: 'GetX',
          icon: FontAwesomeIcons.bolt,
          color: const Color(0xFF9C27B0), // GetX purple/violet
          category: 'State',
          imagePath: 'assets/images/technologies/getx.png',
        ),
        SkillModel(
          name: 'MS Clarity',
          icon: FontAwesomeIcons.chartLine,
          color: const Color(0xFF3B49DF), // MS Clarity blue/indigo
          category: 'Integration',
          imagePath: 'assets/images/technologies/clarity.png',
        ),
        SkillModel(
          name: 'WebSocket',
          icon: FontAwesomeIcons.chartLine,
          color: const Color.fromARGB(
              255, 255, 255, 255), // MS Clarity blue/indigo
          category: 'Integration',
          imagePath: 'assets/images/technologies/websocket.svg',
        ),
        SkillModel(
          name: 'BLoC',
          icon: FontAwesomeIcons.layerGroup,
          color: const Color(0xFF00ACC1), // BLoC cyan/teal blue
          category: 'State',
          imagePath: 'assets/images/technologies/bloc.png',
        ),
        SkillModel(
          name: 'REST APIs',
          icon: FontAwesomeIcons.globe,
          color: const Color(0xFF00838F), // Teal / dark cyan
          category: 'Network',
          imagePath: 'assets/images/technologies/rest_api.webp',
        ),
        SkillModel(
          name: 'Google Maps',
          icon: FontAwesomeIcons.locationDot,
          color: const Color(0xFF34A853), // Google Maps green
          category: 'Integration',
          imagePath: 'assets/images/technologies/google_map.png',
        ),
        SkillModel(
          name: 'OneSignal',
          icon: FontAwesomeIcons.bell,
          color: const Color(0xFFE53935), // OneSignal red/crimson
          category: 'Integration',
          imagePath: 'assets/images/technologies/one_signel.png',
        ),
        SkillModel(
          name: 'Razorpay',
          icon: FontAwesomeIcons.creditCard,
          color: const Color(0xFF2563EB), // Razorpay electric blue
          category: 'Integration',
          imagePath: 'assets/images/technologies/razorpay.png',
        ),
        SkillModel(
          name: 'iOS',
          icon: FontAwesomeIcons.apple,
          color: const Color(0xFF9E9E9E), // Apple gray/silver
          category: 'Platform',
          imagePath: 'assets/images/technologies/apple.png',
        ),
        SkillModel(
          name: 'Android',
          icon: FontAwesomeIcons.android,
          color: const Color(0xFF3DDC84), // Android green
          category: 'Platform',
          imagePath: 'assets/images/technologies/android.svg',
        ),
        SkillModel(
          name: 'Git',
          icon: FontAwesomeIcons.codeBranch,
          color: const Color(0xFFF05133), // Git red/orange-red
          category: 'DevOps',
          imagePath: 'assets/images/technologies/git.svg',
        ),
        SkillModel(
          name: 'ML Kit',
          icon: FontAwesomeIcons.database,
          color: const Color(0xFF0D47A2), // MS Clarity blue/indigo
          category: 'Integration',
          imagePath: 'assets/images/technologies/ml_kit.png',
        ),
        SkillModel(
          name: 'Auth',
          icon: FontAwesomeIcons.shieldHalved,
          color: const Color(0xFF43A047), // Auth green (shield)
          category: 'Backend',
        ),
      ];

  // ──── NAV ITEMS ────
  static const List<String> navItems = [
    'Home',
    'Experience',
    'Projects',
    'Skills',
    'Contact',
  ];

  // ──── QUOTES ────
  static const List<Map<String, String>> quotes = [
    {
      "quote": "Arise, awake, and stop not until the goal is achieved.",
      "author": "Swami Vivekananda"
    },
    {
      "quote":
          "Before you start some work, always ask yourself three questions: Why am I doing it, What the results might be, and Will I be successful.",
      "author": "Chanakya"
    },
    {
      "quote": "You have the right to work, but never to the fruit of work.",
      "author": "Bhagavad Gita"
    },
    {
      "quote": "An ounce of practice is worth more than tons of preaching.",
      "author": "Mahatma Gandhi"
    },
    {
      "quote":
          "A leader is one who knows the way, goes the way, and shows the way.",
      "author": "John C. Maxwell"
    },
    {
      "quote": "Don’t watch the clock; do what it does. Keep going.",
      "author": "Sam Levenson"
    },
    {
      "quote":
          "Success usually comes to those who are too busy to be looking for it.",
      "author": "Henry David Thoreau"
    },
    {
      "quote": "Discipline is the bridge between goals and accomplishment.",
      "author": "Jim Rohn"
    },
    {
      "quote":
          "Success is not final, failure is not fatal: it is the courage to continue that counts.",
      "author": "Winston Churchill"
    },
    {
      "quote": "Hard work beats talent when talent doesn’t work hard.",
      "author": "Tim Notke"
    },
    {
      "quote": "The best way to predict the future is to invent it.",
      "author": "Alan Kay"
    },
    {
      "quote": "Do what you can, with what you have, where you are.",
      "author": "Theodore Roosevelt"
    },
  ];
}
