import 'package:digl/education/presentation/pages/education_home_screen.dart';
import 'package:digl/education/theme/education_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the Smart Educational Advisor dashboard', (tester) async {
    await tester.pumpWidget(MaterialApp(theme: EducationTheme.light(), home: const EducationHomeScreen()));
    expect(find.text('المستشار التعليمي الذكي'), findsOneWidget);
    expect(find.text('اكتشف مستقبلك الأكاديمي بثقة'), findsOneWidget);
  });
}
