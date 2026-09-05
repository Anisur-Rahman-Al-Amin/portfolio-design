import 'package:flutter/material.dart';

import '../../../../data/models/experience_model.dart';

class ExperienceCard extends StatefulWidget {
  const ExperienceCard({super.key, required this.experience});

  final ExperienceModel experience;

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isHovered
              ? colorScheme.surfaceContainerHigh.withOpacity(0.8)
              : colorScheme.surfaceContainerLow.withOpacity(0.6),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? colorScheme.primary.withOpacity(0.4)
                : colorScheme.outlineVariant.withOpacity(0.4),
            width: _isHovered ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? colorScheme.primary.withOpacity(0.08)
                  : Colors.black.withOpacity(0.02),
              blurRadius: _isHovered ? 24 : 16,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 500;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Glowing Timeline Indicator Point
                Container(
                  margin: const EdgeInsets.only(top: 6, right: 18),
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isHovered
                        ? colorScheme.primary.withOpacity(0.2)
                        : Colors.transparent,
                  ),
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isHovered ? colorScheme.primary : colorScheme.primary.withOpacity(0.7),
                      boxShadow: _isHovered
                          ? [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.6),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ]
                          : [],
                    ),
                  ),
                ),

                // Main Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Role & Period Row / Column
                      if (isWide)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.experience.role,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.3,
                                  color: colorScheme.onSurface,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            _buildPeriodBadge(colorScheme),
                          ],
                        )
                      else ...[
                        Text(
                          widget.experience.role,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        _buildPeriodBadge(colorScheme),
                      ],

                      const SizedBox(height: 8),

                      // Company Tag
                      Row(
                        children: [
                          Icon(
                            Icons.business_rounded,
                            size: 16,
                            color: colorScheme.primary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.experience.company,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      // Detail Body
                      Text(
                        widget.experience.detail,
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.65,
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Helper Badge for Experience Period
  Widget _buildPeriodBadge(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorScheme.outlineVariant.withOpacity(0.3),
        ),
      ),
      child: Text(
        widget.experience.period,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}