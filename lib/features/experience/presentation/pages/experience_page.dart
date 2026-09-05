import 'package:flutter/material.dart';

import '../../../../core/widgets/responsive_wrapper.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../data/repositories/portfolio_repository.dart';
import '../widgets/experience_card.dart';

class ExperiencePage extends StatefulWidget {
  const ExperiencePage({super.key, required this.repository});

  final PortfolioRepository repository;

  @override
  State<ExperiencePage> createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    // Smooth entry animation trigger
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _isAnimated = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final experiences = widget.repository.experience;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Experience',
          subtitle: 'A timeline of product delivery, interface systems, and growth.',
        ),
        const SizedBox(height: 24),
        ResponsiveWrapper(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            opacity: _isAnimated ? 1.0 : 0.0,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              offset: _isAnimated ? Offset.zero : const Offset(0, 0.08),
              child: Stack(
                children: [
                  // Timeline Backbone Line connecting the experience items
                  Positioned(
                    top: 28,
                    bottom: 40,
                    left: 28,
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            colorScheme.primary.withValues(alpha: 0.5),
                            colorScheme.primary.withValues(alpha: 0.15),
                            colorScheme.outlineVariant.withValues(alpha: 0.05),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Experience Card List
                  Column(
                    children: List.generate(experiences.length, (index) {
                      final item = experiences[index];
                      final isLast = index == experiences.length - 1;

                      return Padding(
                        padding: EdgeInsets.only(bottom: isLast ? 0 : 8.0),
                        child: ExperienceCard(experience: item),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}