import 'package:flutter/material.dart';

import '../../../../data/models/skill_model.dart';

class SkillProgressBar extends StatelessWidget {
  const SkillProgressBar({super.key, required this.skill});

  final SkillModel skill;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Expanded(child: Text(skill.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700))), Text(skill.level, style: const TextStyle(fontSize: 10, color: Color(0xFF4F46E5), fontWeight: FontWeight.w700))]),
          const SizedBox(height: 12),
          ClipRRect(borderRadius: BorderRadius.circular(99), child: LinearProgressIndicator(value: skill.progress, minHeight: 8, color: const Color(0xFF4F46E5), backgroundColor: const Color(0x334F46E5))),
        ],
      ),
    );
  }
}
