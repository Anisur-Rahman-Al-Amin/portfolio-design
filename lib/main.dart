import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  ThemeMode _mode = ThemeMode.light;
  bool _signedIn = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anisur Rahman Alamin | Personal profile',
      debugShowCheckedModeBanner: false,
      themeMode: _mode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2255D6)),
        scaffoldBackgroundColor: const Color(0xFFFFFBF1),
        fontFamily: 'Arial',
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF101A42),
          foregroundColor: Colors.white,
        ),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: const Color(0xFFFFD84D),
          backgroundColor: const Color(0xFF101A42),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          iconTheme: const WidgetStatePropertyAll(
            IconThemeData(color: Colors.white),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            borderSide: BorderSide(color: Color(0xFF2255D6), width: 2),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2255D6),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF111A35),
        fontFamily: 'Arial',
        useMaterial3: true,
        navigationBarTheme: const NavigationBarThemeData(
          indicatorColor: Color(0xFFFFD84D),
          backgroundColor: Color(0xFF101A42),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          iconTheme: WidgetStatePropertyAll(IconThemeData(color: Colors.white)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),
      ),
      home: PortfolioHome(
        isDark: _mode == ThemeMode.dark,
        signedIn: _signedIn,
        onThemeChanged: (dark) =>
            setState(() => _mode = dark ? ThemeMode.dark : ThemeMode.light),
        onAuthChanged: (signedIn) => setState(() => _signedIn = signedIn),
      ),
    );
  }
}

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({
    super.key,
    required this.isDark,
    required this.signedIn,
    required this.onThemeChanged,
    required this.onAuthChanged,
  });
  final bool isDark;
  final bool signedIn;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<bool> onAuthChanged;

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  final _projectPageController = PageController(viewportFraction: 0.88);
  final _projects = const [
    'Digital product experiments',
    'Web experience concepts',
    'Interface explorations',
    'Problem solving notes',
    'Mobile experience ideas',
  ];
  final _categories = const [
    'Development',
    'Design',
    'Design',
    'Experience',
    'Development',
  ];
  String _filter = 'All';
  int _page = 0;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    _projectPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 1120;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ARA.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (wide)
            ...[
              'Home',
              'About',
              'Work',
              'Skills',
              'Contact',
            ].asMap().entries.map(
              (entry) => TextButton(
                onPressed: () => setState(() => _page = entry.key),
                child: Text(entry.value),
              ),
            ),
          if (widget.signedIn)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Text('M', style: TextStyle(color: Colors.white)),
              ),
            )
          else ...[
            TextButton(
              onPressed: () => _openAuth(false),
              child: const Text('Log in'),
            ),
            FilledButton(
              onPressed: () => _openAuth(true),
              child: const Text('Sign up'),
            ),
          ],
          IconButton(
            tooltip: 'Toggle theme',
            onPressed: () => widget.onThemeChanged(!widget.isDark),
            icon: Icon(
              widget.isDark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          child: _page == 0 || _page == 2
              ? _work(wide)
              : _page == 1
              ? _about(wide)
              : _page == 3
              ? _skills(wide)
              : _contact(wide),
        ),
      ),
      bottomNavigationBar: wide
          ? null
          : NavigationBar(
              selectedIndex: _page,
              onDestinationSelected: (value) => setState(() => _page = value),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  label: 'About',
                ),
                NavigationDestination(
                  icon: Icon(Icons.work_outline),
                  label: 'Work',
                ),
                NavigationDestination(
                  icon: Icon(Icons.auto_awesome_outlined),
                  label: 'Skills',
                ),
                NavigationDestination(
                  icon: Icon(Icons.mail_outline),
                  label: 'Contact',
                ),
              ],
            ),
    );
  }

  void _openAuth(bool signUp) {
    showDialog<void>(
      context: context,
      builder: (context) => AuthDialog(
        initialSignUp: signUp,
        onAuthenticated: () {
          widget.onAuthChanged(true);
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _shell(bool wide, Widget child) => SingleChildScrollView(
    padding: EdgeInsets.fromLTRB(wide ? 32 : 20, 32, wide ? 32 : 20, 64),
    child: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1160),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [child, const SizedBox(height: 70), _footer()],
        ),
      ),
    ),
  );

  Widget _footer() => Container(
    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
    decoration: BoxDecoration(
      color: const Color(0xFF101A42),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MO.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'A thoughtful digital profile for Anisur Rahman Alamin.',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 24),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 14,
          children: [
            const Text(
              '© 2026 Anisur Rahman Alamin',
              style: TextStyle(color: Colors.white54, fontSize: 12),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.public, color: Colors.white70, size: 18),
                SizedBox(width: 14),
                Icon(Icons.alternate_email, color: Colors.white70, size: 18),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  Widget _work(bool wide) => _shell(
    wide,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (wide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _heroCopy()),
              const SizedBox(width: 36),
              const Expanded(child: _HeroScene()),
            ],
          )
        else
          _heroCopy(),
        const SizedBox(height: 56),
        _proofStrip(),
        const SizedBox(height: 96),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Selected work',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _filter,
              underline: const SizedBox(),
              items: const ['All', 'Development', 'Design', 'Experience']
                  .map(
                    (value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _filter = value ?? 'All'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: wide ? 270 : 250,
          child: PageView.builder(
            controller: _projectPageController,
            itemCount: _visibleProjects.length,
            padEnds: false,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _projectCard(_visibleProjects[index]),
            ),
          ),
        ),
        const SizedBox(height: 96),
        _storySection(wide),
        const SizedBox(height: 80),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Have an idea worth building?',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _page = 4),
                child: const Text(
                  'Start a conversation  →',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  List<String> get _visibleProjects => _filter == 'All'
      ? _projects
      : [
          for (var index = 0; index < _projects.length; index++)
            if (_categories[index] == _filter) _projects[index],
        ];

  Widget _heroCopy() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Hello, I’m\nAnisur.',
        style: Theme.of(context).textTheme.displaySmall
            ?.copyWith(fontWeight: FontWeight.bold, height: 1.05),
      ),
      const SizedBox(height: 24),
      Text(
        'Welcome to my corner of the internet. Explore my work, interests, and the ideas I’m building toward next.',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1.4),
      ),
      const SizedBox(height: 32),
      FilledButton.icon(
        onPressed: () => setState(() => _page = 4),
        icon: const Icon(Icons.arrow_forward),
        label: const Text('Start a conversation'),
      ),
    ],
  );

  Widget _proofStrip() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    decoration: BoxDecoration(
      color: const Color(0xFFFFD84D),
      borderRadius: BorderRadius.circular(18),
    ),
    child: const Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 16,
      children: [
        _ProofItem(value: '01', label: 'personal profile'),
        _ProofItem(value: '∞', label: 'curiosity to follow'),
        _ProofItem(value: '24/7', label: 'ideas in motion'),
      ],
    ),
  );

  Widget _storySection(bool wide) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'A few words from the journey',
        style: Theme.of(context).textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 22),
      GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: wide ? 2 : 1,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        childAspectRatio: wide ? 1.35 : 1.25,
        children: const [
          _QuoteCard(
            quote: '“Good work is a balance of curiosity, clarity, and care for the people on the other side of the screen.”',
            person: 'Anisur Rahman Alamin',
            role: 'Personal note',
          ),
          _QuoteCard(
            quote: '“Every project is a chance to learn something new and make the next one a little better.”',
            person: 'Anisur Rahman Alamin',
            role: 'Working philosophy',
          ),
        ],
      ),
      const SizedBox(height: 48),
      Container(
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: const Color(0xFF2255D6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Good conversations create great opportunities.',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Icon(
              Icons.arrow_outward,
              color: Colors.white,
              size: wide ? 42 : 28,
            ),
          ],
        ),
      ),
    ],
  );

  Widget _projectCard(String title) {
    final cardColor = [
      const Color(0xFF101A42),
      const Color(0xFF2255D6),
      const Color(0xFFFFD84D),
      const Color(0xFF101A42),
      const Color(0xFF101A42),
    ][_projects.indexOf(title)];
    final foreground = cardColor == const Color(0xFFFFD84D)
        ? const Color(0xFF101A42)
        : Colors.white;

    return InkWell(
      onTap: () => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: const Text('A selected case study is available on request.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.auto_awesome_outlined, size: 34, color: foreground),
            const Spacer(),
            Text(
              'SELECTED WORK',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: foreground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: foreground),
            ),
            const SizedBox(height: 8),
            Text(
              'Ideas, experiments, and work shaped with care.',
              style: TextStyle(color: foreground),
            ),
          ],
        ),
      ),
    );
  }

  Widget _about(bool wide) => _shell(
    wide,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'A little about me.',
          style: Theme.of(context).textTheme.displaySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        Text(
          'I’m Anisur Rahman Alamin. This space brings together the work, ideas, and interests that shape my professional journey.',
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(height: 1.35),
        ),
        const SizedBox(height: 48),
        const Divider(),
        _aboutRow(
          '01',
          'How I think',
          'Curiosity comes first. I like understanding the problem clearly, then turning complexity into something useful and approachable.',
        ),
        _aboutRow(
          '02',
          'What I value',
          'Clear communication, thoughtful details, continuous learning, and work that creates a meaningful experience for people.',
        ),
        const SizedBox(height: 56),
        _sectionHeading(
          'The journey so far',
          'A living collection of milestones, experiments, and lessons gathered along the way.',
        ),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: wide ? 3 : 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: wide ? 1.1 : 2.4,
          children: const [
            _MetricCard(value: '01', label: 'Explore'),
            _MetricCard(value: '02', label: 'Create'),
            _MetricCard(value: '03', label: 'Keep growing'),
          ],
        ),
        const SizedBox(height: 64),
        _sectionHeading(
          'What I’m focused on',
          'A few themes that keep showing up in my work and learning.',
        ),
        const SizedBox(height: 20),
        _serviceTile(
          Icons.explore_outlined,
          'Building useful things',
          'Turning ideas into clear digital experiences with care for the details.',
        ),
        _serviceTile(
          Icons.layers_outlined,
          'Learning in public',
          'Documenting experiments, lessons, and the process behind the finished result.',
        ),
        _serviceTile(
          Icons.diversity_3_outlined,
          'Better conversations',
          'Connecting with thoughtful people and finding opportunities to collaborate.',
        ),
        const SizedBox(height: 64),
        _sectionHeading(
          'A simple working rhythm',
          'A clear path from curiosity to a finished piece of work.',
        ),
        const SizedBox(height: 20),
        _processRow(
          '01',
          'Notice',
          'Start with a question, a need, or an idea worth exploring.',
        ),
        _processRow(
          '02',
          'Make',
          'Turn the idea into a small, useful, and testable first version.',
        ),
        _processRow(
          '03',
          'Reflect',
          'Keep what works, learn from what does not, and make the next version better.',
        ),
      ],
    ),
  );

  Widget _skills(bool wide) => _shell(
    wide,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills & toolkit',
          style: Theme.of(context).textTheme.displaySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          'A focused snapshot of the tools and ways of thinking I bring to a project.',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1.4),
        ),
        const SizedBox(height: 42),
        _skillGroup('Core strengths', [
          'Problem framing',
          'Clear communication',
          'Product thinking',
          'Continuous learning',
        ]),
        _skillGroup('Digital craft', [
          'Web experiences',
          'Responsive interfaces',
          'Prototyping',
          'Design systems',
        ]),
        _skillGroup('Ways of working', [
          'Research and discovery',
          'Collaborative critique',
          'Iterative delivery',
          'Thoughtful documentation',
        ]),
        const SizedBox(height: 42),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD84D),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Always learning, always improving the next version.',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _skillGroup(String title, List<String> skills) => Padding(
    padding: const EdgeInsets.only(bottom: 28),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: skills
              .map(
                (skill) => Chip(
                  label: Text(skill),
                  avatar: Icon(
                    Icons.check_circle_outline,
                    size: 17,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    ),
  );

  Widget _sectionHeading(String title, String subtitle) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Text(
        subtitle,
        style: Theme.of(context).textTheme.bodyLarge
            ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
    ],
  );

  Widget _serviceTile(IconData icon, String title, String body) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      tileColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Text(body),
      ),
    ),
  );

  Widget _processRow(String number, String title, String body) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(body),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _aboutRow(String number, String title, String body) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60,
          child: Text(
            number,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                body,
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(height: 1.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _contact(bool wide) => _shell(
    wide,
    Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Let’s make something\nmeaningful.',
            style: Theme.of(context).textTheme.displaySmall
                ?.copyWith(fontWeight: FontWeight.bold, height: 1.05),
          ),
          const SizedBox(height: 22),
          Text(
            'Have a project, collaboration, or idea in mind? I’d love to hear about it.',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 40),
          TextFormField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Your name'),
            validator: (value) =>
                value == null || value.isEmpty ? 'Please add your name' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email address'),
            validator: (value) => value == null || !value.contains('@')
                ? 'Please add a valid email'
                : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _message,
            minLines: 5,
            maxLines: 8,
            decoration: const InputDecoration(
              labelText: 'What can I help with?',
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Please add a message' : null,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Thanks, I will be in touch soon.'),
                  ),
                );
              }
            },
            icon: const Icon(Icons.send_outlined),
            label: const Text('Send message'),
          ),
        ],
      ),
    ),
  );
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 6),
        Text(label),
      ],
    ),
  );
}

class _ProofItem extends StatelessWidget {
  const _ProofItem({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 170,
    child: Row(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    ),
  );
}

class _QuoteCard extends StatelessWidget {
  const _QuoteCard({
    required this.quote,
    required this.person,
    required this.role,
  });
  final String quote;
  final String person;
  final String role;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(18),
      border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.format_quote,
          color: Theme.of(context).colorScheme.primary,
          size: 30,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Text(
            quote,
            style: Theme.of(context).textTheme.titleMedium
                ?.copyWith(height: 1.35, fontWeight: FontWeight.w600),
          ),
        ),
        Text(person, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 3),
        Text(role, style: Theme.of(context).textTheme.bodySmall),
      ],
    ),
  );
}

class _HeroScene extends StatefulWidget {
  const _HeroScene();

  @override
  State<_HeroScene> createState() => _HeroSceneState();
}

class _HeroSceneState extends State<_HeroScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 7),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 310,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final turn = _controller.value * 6.28;
          final pulse = 0.98 + (math.sin(turn) * 0.02);
          return Stack(
            alignment: Alignment.center,
            children: [
              Transform.rotate(
                angle: turn,
                child: Container(
                  width: 270,
                  height: 270,
                  decoration: BoxDecoration(
                    color: colors.primary.withAlpha(12),
                    border: Border.all(
                      color: colors.primary.withAlpha(45),
                      width: 1.5,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(0.34)
                  ..rotateZ(turn * 0.04)
                  ..scale(pulse),
                child: _CodeWorkspace(
                  colors: colors,
                  progress: _controller.value,
                ),
              ),
              Positioned(
                right: 26,
                top: 30,
                child: Transform.rotate(
                  angle: -turn * 0.35,
                  child: const _GlassOrb(icon: Icons.draw_outlined),
                ),
              ),
              Positioned(
                left: 24,
                bottom: 30,
                child: Transform.rotate(
                  angle: turn * 0.35,
                  child: const _GlassOrb(icon: Icons.lightbulb_outline),
                ),
              ),
              Positioned(
                left: 16 + (math.sin(turn) * 8),
                top: 80 + (math.cos(turn) * 8),
                child: const _FloatingBadge(label: '</>', icon: Icons.code),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CodeWorkspace extends StatelessWidget {
  const _CodeWorkspace({required this.colors, required this.progress});
  final ColorScheme colors;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final scanPosition = 20 + (progress * 155);
    return Container(
      width: 246,
      height: 188,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF101A42),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withAlpha(75),
            blurRadius: 35,
            spreadRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const _WindowDot(color: Color(0xFFFF6B6B)),
              const _WindowDot(color: Color(0xFFFFD84D)),
              const _WindowDot(color: Color(0xFF68D391)),
              const Spacer(),
              Text(
                'anisur.dev',
                style: TextStyle(
                  color: Colors.white.withAlpha(100),
                  fontSize: 9,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _codeLine(const Color(0xFFFFD84D), 0.62),
                    _codeLine(const Color(0xFF70D6FF), 0.82),
                    _codeLine(const Color(0xFFFF9F68), 0.48),
                    const SizedBox(height: 8),
                    _codeLine(const Color(0xFF68D391), 0.72),
                    _codeLine(const Color(0xFFE2E8F0), 0.55),
                    _codeLine(const Color(0xFF70D6FF), 0.36),
                  ],
                ),
                Positioned(
                  left: scanPosition,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 2,
                    color: const Color(0xFFFFD84D).withAlpha(35),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const Icon(
                Icons.play_arrow_rounded,
                color: Color(0xFF68D391),
                size: 16,
              ),
              const SizedBox(width: 5),
              Text(
                'creating with purpose',
                style: TextStyle(
                  color: Colors.white.withAlpha(160),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _codeLine(Color color, double width) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: FractionallySizedBox(
      widthFactor: width,
      child: Container(
        height: 7,
        decoration: BoxDecoration(
          color: color.withAlpha(190),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  );
}

class _WindowDot extends StatelessWidget {
  const _WindowDot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 7,
    height: 7,
    margin: const EdgeInsets.only(right: 5),
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

class _FloatingBadge extends StatelessWidget {
  const _FloatingBadge({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: const Color(0xFFFFD84D),
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 12)],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF101A42)),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 11,
            color: Color(0xFF101A42),
          ),
        ),
      ],
    ),
  );
}

class _GlassOrb extends StatelessWidget {
  const _GlassOrb({required this.icon});
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    width: 62,
    height: 62,
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface.withAlpha(220),
      shape: BoxShape.circle,
      boxShadow: const [BoxShadow(color: Color(0x22000000), blurRadius: 18)],
    ),
    child: Icon(icon, color: Theme.of(context).colorScheme.primary),
  );
}

class AuthDialog extends StatefulWidget {
  const AuthDialog({
    super.key,
    required this.initialSignUp,
    required this.onAuthenticated,
  });
  final bool initialSignUp;
  final VoidCallback onAuthenticated;

  @override
  State<AuthDialog> createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final _formKey = GlobalKey<FormState>();
  late bool _signUp = widget.initialSignUp;
  bool _obscure = true;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) widget.onAuthenticated();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(28, 28, 28, 0),
      contentPadding: const EdgeInsets.fromLTRB(28, 12, 28, 28),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              _signUp ? 'Stay connected' : 'Welcome back',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            tooltip: 'Close',
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: SizedBox(
        width: 390,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _signUp
                      ? 'Create a profile to keep in touch with new work.'
                      : 'Log in to continue exploring the profile.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 22),
                SegmentedButton<bool>(
                  segments: const [
                    ButtonSegment(value: false, label: Text('Log in')),
                    ButtonSegment(value: true, label: Text('Sign up')),
                  ],
                  selected: {_signUp},
                  onSelectionChanged: (value) =>
                      setState(() => _signUp = value.first),
                ),
                const SizedBox(height: 20),
                if (_signUp) ...[
                  TextFormField(
                    controller: _name,
                    decoration: const InputDecoration(
                      labelText: 'Full name',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Enter your name'
                        : null,
                  ),
                  const SizedBox(height: 12),
                ],
                TextFormField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                    prefixIcon: Icon(Icons.mail_outline),
                  ),
                  validator: (value) => value == null || !value.contains('@')
                      ? 'Enter a valid email'
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _password,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      tooltip: 'Show password',
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) => value == null || value.length < 6
                      ? 'Use at least 6 characters'
                      : null,
                ),
                if (!_signUp)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?'),
                    ),
                  ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: _submit,
                  child: Text(_signUp ? 'Create account' : 'Log in'),
                ),
                const SizedBox(height: 14),
                const Text(
                  'By continuing, you agree to the profile terms.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
