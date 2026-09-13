import 'package:digl/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows the Smart Educational Advisor home', (tester) async {
    await tester.pumpWidget(const SmartEducationalAdvisorApp());
    expect(find.text('المستشار التعليمي الذكي'), findsOneWidget);
    expect(find.text('اكتشف مستقبلك الأكاديمي بثقة'), findsOneWidget);
  });
}
