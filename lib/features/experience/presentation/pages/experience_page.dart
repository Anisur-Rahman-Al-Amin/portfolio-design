import 'package:flutter/material.dart';

import '../../../../core/widgets/responsive_wrapper.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../data/repositories/portfolio_repository.dart';
import '../widgets/experience_card.dart';

class ExperiencePage extends StatelessWidget {
  const ExperiencePage({super.key, required this.repository});

  final PortfolioRepository repository;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SectionTitle(title: 'Experience', subtitle: 'A timeline of product delivery, interface systems, and growth.'),
      ResponsiveWrapper(child: Column(children: repository.experience.map((item) => ExperienceCard(experience: item)).toList())),
    ]);
  }
}
