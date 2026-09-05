import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.onSectionSelected, required this.onThemeChanged});

  final ValueChanged<String> onSectionSelected;
  final VoidCallback onThemeChanged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.sizeOf(context).width >= 800;
    final items = {'About': 'about', 'Experience': 'experience', 'Projects': 'projects', 'Skills': 'skills', 'Contact': 'contact'};
    return AppBar(
      titleSpacing: 12,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primary, AppColors.secondary]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(child: Text('AR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
            ),
            const SizedBox(width: 10),
            const Text('Anisur Rahman', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      actions: [
        if (desktop)
          ...items.entries.map((entry) => TextButton(style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8), minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap), onPressed: () => onSectionSelected(entry.value), child: Text(entry.key))),
        if (!desktop)
          PopupMenuButton<String>(
            tooltip: 'Open navigation menu',
            onSelected: onSectionSelected,
            itemBuilder: (context) => items.entries.map((entry) => PopupMenuItem(value: entry.value, child: Text(entry.key))).toList(),
            icon: const Icon(Icons.menu_rounded),
          ),
        IconButton(tooltip: 'Toggle theme', onPressed: onThemeChanged, icon: const Icon(Icons.brightness_6_outlined)),
        const SizedBox(width: 8),
      ],
    );
  }
}
