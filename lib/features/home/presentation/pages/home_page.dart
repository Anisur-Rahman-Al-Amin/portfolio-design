import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/responsive_wrapper.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../data/repositories/portfolio_repository.dart';
import '../../../experience/presentation/widgets/experience_card.dart';
import '../../../projects/presentation/widgets/project_card.dart';
import '../../../skills/presentation/widgets/skill_progress_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.repository, required this.onSectionSelected});

  final PortfolioRepository repository;
  final ValueChanged<String> onSectionSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _hero(context),
        const SectionTitle(title: 'About me'),
        _about(context),
        const SectionTitle(title: 'Experience'),
        _experience(context),
        const SectionTitle(title: 'Featured work'),
        _projects(context),
        const SectionTitle(title: 'Skills & strengths'),
        _skills(context),
        const SectionTitle(title: 'Let’s work together'),
        _contact(context),
        _footer(context),
      ],
    );
  }

  Widget _hero(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 900;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Theme.of(context).scaffoldBackgroundColor, AppColors.primary.withAlpha(55), AppColors.secondary.withAlpha(35)],
        ),
      ),
      child: ResponsiveWrapper(
        padding: 0,
        child: wide
            ? Row(children: [Expanded(child: _heroCopy(context)), const SizedBox(width: 32), Expanded(child: _profileCard(context))])
            : Column(children: [_heroCopy(context), const SizedBox(height: 28), _profileCard(context)]),
      ),
    );
  }

  Widget _heroCopy(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Flutter Developer  •  Product Builder  •  UI Systems', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700)),
        const SizedBox(height: 18),
        Text(AppStrings.heroTitle, style: TextStyle(fontSize: MediaQuery.sizeOf(context).width < 420 ? 38 : 52, height: 1.05, fontWeight: FontWeight.w900)),
        const SizedBox(height: 18),
        Text(AppStrings.heroDescription, style: TextStyle(fontSize: 17, height: 1.7, color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 26),
        Wrap(spacing: 12, runSpacing: 12, children: [
          FilledButton.icon(onPressed: () => onSectionSelected('projects'), icon: const Icon(Icons.arrow_forward_rounded), label: const Text('View projects')),
          OutlinedButton.icon(onPressed: () => onSectionSelected('contact'), icon: const Icon(Icons.mail_outline_rounded), label: const Text('Let’s talk')),
        ]),
      ],
    );
  }

  Widget _profileCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(color: Theme.of(context).cardColor.withAlpha(210), borderRadius: BorderRadius.circular(28), border: Border.all(color: Theme.of(context).dividerColor)),
          child: Column(children: [
            Container(width: 180, height: 180, decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [AppColors.primary, AppColors.secondary, AppColors.accent])), child: const Center(child: Text('AR', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)))),
            const SizedBox(height: 18),
            const Text('Anisur Rahman Al Amin', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text('Mobile Product Engineer', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ]),
        ),
      ),
    );
  }

  Widget _about(BuildContext context) => ResponsiveWrapper(child: _glass(context, Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('I build modern digital products with clarity, speed, and human-centered thinking.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)), const SizedBox(height: 14), Text('I enjoy turning complex product challenges into intuitive experiences. My work sits at the intersection of product design, engineering, and business thinking, helping teams launch faster and build stronger user trust.', style: TextStyle(height: 1.8, color: Theme.of(context).colorScheme.onSurfaceVariant))])));

  Widget _experience(BuildContext context) => ResponsiveWrapper(child: Column(children: repository.experience.map((item) => ExperienceCard(experience: item)).toList()));

  Widget _projects(BuildContext context) {
    return ResponsiveWrapper(child: LayoutBuilder(builder: (context, constraints) {
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
    }));
  }

  Widget _skills(BuildContext context) => ResponsiveWrapper(child: LayoutBuilder(builder: (context, constraints) => Wrap(spacing: 14, runSpacing: 14, children: repository.skills.map((skill) => SizedBox(width: constraints.maxWidth < 520 ? constraints.maxWidth : 240, child: SkillProgressBar(skill: skill))).toList())));

  Widget _contact(BuildContext context) => ResponsiveWrapper(child: _glass(context, Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text(AppStrings.contactTitle, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)), const SizedBox(height: 10), Text(AppStrings.contactDescription, style: TextStyle(height: 1.7, color: Theme.of(context).colorScheme.onSurfaceVariant)), const SizedBox(height: 18), FilledButton.icon(onPressed: () => onSectionSelected('contact'), icon: const Icon(Icons.mail_outline_rounded), label: const Text(AppStrings.email))])));

  Widget _footer(BuildContext context) => Container(width: double.infinity, padding: const EdgeInsets.all(24), child: const Center(child: Text('© 2026 Anisur Rahman  •  Built with Flutter')));

  Widget _glass(BuildContext context, Widget child) => Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(22), border: Border.all(color: Theme.of(context).dividerColor)), child: child);
}
