import 'package:flutter/material.dart';

import '../../../../core/widgets/responsive_wrapper.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../data/repositories/portfolio_repository.dart';
import '../../../skills/presentation/widgets/skill_progress_bar.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required this.repository});

  final PortfolioRepository repository;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    // Trigger smooth fade-and-slide entry animation
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'About me',
          subtitle: 'How I combine product thinking, design, and engineering.',
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
              child: Container(
                padding: const EdgeInsets.all(32.0),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLow.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: colorScheme.outlineVariant.withOpacity(0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge Header
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: colorScheme.primary.withOpacity(0.2),
                        ),
                      ),
                      child: Text(
                        'DESIGN & ENGINEERING',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Main Headline with Gradient Effect
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [
                          colorScheme.onSurface,
                          colorScheme.onSurface.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: const Text(
                        'I turn complex ideas into calm, useful digital products.',
                        style: TextStyle(
                          fontSize: 32,
                          height: 1.25,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Description text
                    Text(
                      'My focus is building thoughtful Flutter experiences that feel fast, accessible, and easy to understand. I partner with founders and teams from the first sketch through launch and iteration.',
                      style: TextStyle(
                        fontSize: 17,
                        height: 1.7,
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 36),

                    const Divider(height: 1),
                    const SizedBox(height: 36),

                    // Skills Section Header
                    Row(
                      children: [
                        Icon(
                          Icons.auto_awesome_rounded,
                          size: 20,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Core toolkit',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Skill list wrapper with interactive cards
                    Wrap(
                      spacing: 14,
                      runSpacing: 14,
                      children: widget.repository.skills.map((skill) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: colorScheme.outlineVariant.withOpacity(0.3),
                            ),
                          ),
                          child: SkillProgressBar(skill: skill),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}