import 'package:flutter/material.dart';

import '../../../../core/widgets/responsive_wrapper.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../data/repositories/portfolio_repository.dart';
import '../widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key, required this.repository});

  final PortfolioRepository repository;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SectionTitle(title: 'Featured work', subtitle: 'A closer look at products built with Flutter and product thinking.'),
      ResponsiveWrapper(child: LayoutBuilder(builder: (context, constraints) {
        final columns = constraints.maxWidth >= 900 ? 3 : constraints.maxWidth >= 600 ? 2 : 1;
        final width = (constraints.maxWidth - (columns - 1) * 20) / columns;
        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: repository.projects.map((project) {
            return SizedBox(
              width: width,
              child: ProjectCard(
                project: project,
                onTap: () => showDialog<void>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(project.title),
                    content: Text(project.description),
                    actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      })),
    ]);
  }
}
