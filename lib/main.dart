import 'package:flutter/material.dart';

import 'education/presentation/pages/education_home_screen.dart';
import 'education/theme/education_theme.dart';

void main() => runApp(const SmartEducationalAdvisorApp());

class SmartEducationalAdvisorApp extends StatelessWidget {
  const SmartEducationalAdvisorApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'المستشار التعليمي الذكي',
        debugShowCheckedModeBanner: false,
        theme: EducationTheme.light(),
        darkTheme: EducationTheme.dark(),
        themeMode: ThemeMode.system,
        locale: const Locale('ar'),
        builder: (context, child) => Directionality(textDirection: TextDirection.rtl, child: child!),
        home: const EducationHomeScreen(),
      );
}
