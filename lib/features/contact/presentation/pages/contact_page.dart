import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/widgets/responsive_wrapper.dart';
import '../../../../core/widgets/section_title.dart';
import '../../../../data/repositories/portfolio_repository.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key, required this.repository});

  final PortfolioRepository repository;

  Future<void> _email(BuildContext context) async {
    final uri = Uri(scheme: 'mailto', path: repository.contact.email, queryParameters: {'subject': 'Project inquiry'});
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not open your email app.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SectionTitle(title: 'Let’s work together', subtitle: 'Have an idea, product challenge, or collaboration in mind?'),
      ResponsiveWrapper(child: Card(child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(AppStrings.contactTitle, style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Text(AppStrings.contactDescription, style: TextStyle(height: 1.7, color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 20),
        Text(repository.contact.location),
        const SizedBox(height: 4),
        Text(repository.contact.availability, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 22),
        FilledButton.icon(onPressed: () => _email(context), icon: const Icon(Icons.mail_outline_rounded), label: const Text(AppStrings.email)),
      ])))),
    ]);
  }
}
