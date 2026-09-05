import 'package:flutter/material.dart';

import '../models/contact_model.dart';
import '../models/experience_model.dart';
import '../models/project_model.dart';
import '../models/skill_model.dart';

class PortfolioRepository {
  const PortfolioRepository();

  List<ProjectModel> get projects => const [
        ProjectModel(
          title: 'FinFlow Mobile Banking',
          description: 'Secure fintech experience with fast transactions, insight-rich dashboards, and biometric login.',
          stack: ['Flutter', 'Firebase', 'UX', 'Finance'],
          metric: '2.4x engagement',
          color: Color(0xFF8B5CF6),
        ),
        ProjectModel(
          title: 'LogiSync Ops Suite',
          description: 'Operations dashboard that gives logistics teams live visibility, task ownership, and smart alerts.',
          stack: ['Flutter', 'Realtime', 'Dashboard'],
          metric: '46% faster workflows',
          color: Color(0xFF10B981),
        ),
        ProjectModel(
          title: 'StudyMate Learning App',
          description: 'Personalized learning platform designed around retention, motivation, and measurable student growth.',
          stack: ['Flutter', 'Auth', 'Learning'],
          metric: '4.8/5 rating',
          color: Color(0xFF38BDF8),
        ),
      ];

  List<ExperienceModel> get experience => const [
        ExperienceModel(
          role: 'Senior Flutter Developer',
          company: 'Independent Product Studio',
          period: '2023 - Present',
          detail: 'Leading mobile product delivery, polished UI systems, and performance optimization for client apps.',
        ),
        ExperienceModel(
          role: 'Product Engineer',
          company: 'Startup Ecosystem',
          period: '2021 - 2023',
          detail: 'Built MVPs and internal tools, blending UX strategy, architecture, and API-driven product experiences.',
        ),
        ExperienceModel(
          role: 'UI Developer',
          company: 'Digital Agency',
          period: '2019 - 2021',
          detail: 'Crafted conversion-focused interfaces and rapid prototypes that turned ideas into usable products.',
        ),
      ];

  List<SkillModel> get skills => const [
        SkillModel(name: 'Flutter', level: 'Advanced', progress: .85),
        SkillModel(name: 'Dart', level: 'Advanced', progress: .85),
        SkillModel(name: 'Firebase', level: 'Advanced', progress: .85),
        SkillModel(name: 'UI/UX', level: 'Expert', progress: 1),
        SkillModel(name: 'System Design', level: 'Strong', progress: .7),
        SkillModel(name: 'Product Thinking', level: 'Expert', progress: 1),
        SkillModel(name: 'API Integration', level: 'Advanced', progress: .85),
        SkillModel(name: 'Performance', level: 'Advanced', progress: .85),
      ];

  ContactModel get contact => const ContactModel(
        email: 'anisurrahman.dev@gmail.com',
        location: 'Remote, Bangladesh',
        availability: 'Available for selected product collaborations',
      );
}
