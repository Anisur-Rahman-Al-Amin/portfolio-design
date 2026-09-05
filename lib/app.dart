import 'package:flutter/material.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/custom_app_bar.dart';
import 'data/repositories/portfolio_repository.dart';
import 'features/about/presentation/pages/about_page.dart';
import 'features/contact/presentation/pages/contact_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/projects/presentation/pages/projects_page.dart';

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      home: PortfolioShell(
        isDark: _themeMode == ThemeMode.dark,
        onThemeChanged: () => setState(() => _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark),
      ),
    );
  }
}

class PortfolioShell extends StatefulWidget {
  const PortfolioShell({super.key, required this.isDark, required this.onThemeChanged});

  final bool isDark;
  final VoidCallback onThemeChanged;

  @override
  State<PortfolioShell> createState() => _PortfolioShellState();
}

class _PortfolioShellState extends State<PortfolioShell> {
  final repository = const PortfolioRepository();
  final scrollController = ScrollController();
  int selectedIndex = 0;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void selectSection(String section) {
    const tabs = {'about': 2, 'projects': 1, 'contact': 3};
    if (section == 'experience' || section == 'skills') {
      setState(() => selectedIndex = 0);
      return;
    }
    final index = tabs[section];
    if (index == null) return;
    setState(() => selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.sizeOf(context).width < 800;
    final pages = [
      HomePage(repository: repository, onSectionSelected: selectSection),
      ProjectsPage(repository: repository),
      AboutPage(repository: repository),
      ContactPage(repository: repository),
    ];

    return Scaffold(
      appBar: CustomAppBar(onSectionSelected: selectSection, onThemeChanged: widget.onThemeChanged),
      body: SingleChildScrollView(controller: selectedIndex == 0 ? scrollController : null, child: pages[selectedIndex]),
      bottomNavigationBar: mobile
          ? NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (index) => setState(() => selectedIndex = index),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.work_outline), selectedIcon: Icon(Icons.work), label: 'Work'),
                NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'About'),
                NavigationDestination(icon: Icon(Icons.mail_outline), selectedIcon: Icon(Icons.mail), label: 'Contact'),
              ],
            )
          : null,
    );
  }
}
