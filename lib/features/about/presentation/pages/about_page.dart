import 'package:flutter/material.dart';

import '../../../../core/widgets/responsive_wrapper.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../data/repositories/portfolio_repository.dart';
import '../../../skills/presentation/widgets/skill_progress_bar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key, required this.repository});

  final PortfolioRepository repository;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SectionTitle(title: 'About me', subtitle: 'How I combine product thinking, design, and engineering.'),
      ResponsiveWrapper(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('I turn complex ideas into calm, useful digital products.', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        Text('My focus is building thoughtful Flutter experiences that feel fast, accessible, and easy to understand. I partner with founders and teams from the first sketch through launch and iteration.', style: TextStyle(fontSize: 16, height: 1.8, color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 30),
        const Text('Core toolkit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 14),
        Wrap(spacing: 14, runSpacing: 14, children: repository.skills.map((skill) => SkillProgressBar(skill: skill)).toList()),
      ])),
    ]);
  }
}
