import 'package:flutter/material.dart';

import 'assessment_screen.dart';
import 'recommendations_screen.dart';

class EducationHomeScreen extends StatelessWidget {
  const EducationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('المستشار التعليمي الذكي')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(colors: [scheme.primary, scheme.secondary]),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.school_rounded, color: Colors.white, size: 42),
                  SizedBox(height: 16),
                  Text('اكتشف مستقبلك الأكاديمي بثقة', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800)),
                  SizedBox(height: 8),
                  Text('أكمل ملفك وتقييمك لتحصل على توصيات تخصصات مبنية على بياناتك.', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('ابدأ رحلتك', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            _ActionCard(
              icon: Icons.fact_check_outlined,
              title: 'التقييم التعليمي',
              subtitle: 'حلّل ميولك ومهاراتك وقدراتك',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AssessmentScreen())),
            ),
            _ActionCard(
              icon: Icons.auto_awesome_outlined,
              title: 'التخصصات المقترحة لك',
              subtitle: 'اعرض نسبة المطابقة وأسباب الترشيح',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const RecommendationsScreen())),
            ),
            _ActionCard(
              icon: Icons.support_agent_rounded,
              title: 'استشر مستشارًا تعليميًا',
              subtitle: 'ابحث عن خبير موثّق واحجز استشارة',
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تظهر قائمة المستشارين بعد إكمال ملفك الأكاديمي.'))),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({required this.icon, required this.title, required this.subtitle, required this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          onTap: onTap,
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(child: Icon(icon)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        ),
      );
}
