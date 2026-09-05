import 'package:flutter/material.dart';

import '../../../../core/widgets/responsive_wrapper.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../data/repositories/portfolio_repository.dart';
import '../widgets/skill_progress_bar.dart';

class SkillsPage extends StatelessWidget {
  const SkillsPage({super.key, required this.repository});

  final PortfolioRepository repository;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SectionTitle(title: 'Skills & strengths', subtitle: 'The practical toolkit behind reliable, polished product work.'),
      ResponsiveWrapper(child: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth < 520 ? constraints.maxWidth : 240.0;
        return Wrap(spacing: 14, runSpacing: 14, children: repository.skills.map((skill) => SizedBox(width: width, child: SkillProgressBar(skill: skill))).toList());
      })),
    ]);
  }
}
