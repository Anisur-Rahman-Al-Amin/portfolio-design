import 'package:flutter/material.dart';

import '../../../../data/models/project_model.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project, required this.onTap});

  final ProjectModel project;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        height: 240,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [project.color.withAlpha(35), Theme.of(context).cardColor],
          ),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.metric, style: TextStyle(color: project.color, fontWeight: FontWeight.w700, fontSize: 12)),
            const SizedBox(height: 10),
            Text(project.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Expanded(child: Text(project.description, maxLines: 3, overflow: TextOverflow.ellipsis, style: TextStyle(height: 1.5, color: Theme.of(context).colorScheme.onSurfaceVariant))),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: project.stack.take(3).map((tool) => Chip(visualDensity: VisualDensity.compact, label: Text(tool, style: const TextStyle(fontSize: 10)))).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
