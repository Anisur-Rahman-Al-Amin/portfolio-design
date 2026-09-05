import 'package:flutter/material.dart';

import '../../../../data/models/experience_model.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key, required this.experience});

  final ExperienceModel experience;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 12, height: 12, margin: const EdgeInsets.only(top: 8, right: 18), decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF4F46E5))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(alignment: WrapAlignment.spaceBetween, runSpacing: 6, children: [Text(experience.role, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)), Text(experience.period, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontWeight: FontWeight.w600))]),
                const SizedBox(height: 8),
                Text(experience.company, style: const TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Text(experience.detail, style: TextStyle(height: 1.7, color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
