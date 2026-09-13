import 'package:digl/education/models/academic_major.dart';
import 'package:digl/education/models/student_profile.dart';
import 'package:digl/education/services/recommendation_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = RecommendationService();
  const student = StudentProfile(
    id: 'student-1',
    fullName: 'أحمد',
    gpa: 4.5,
    skills: ['برمجة', 'حل المشكلات'],
    interests: ['التقنية'],
    favoriteSubjects: ['رياضيات', 'حاسب'],
    abilities: ['تفكير منطقي'],
    assessmentScores: {'التقنية': 90},
  );

  test('ranks a major from saved academic evidence rather than a random score', () {
    const engineering = AcademicMajor(
      id: 'software-engineering',
      name: 'هندسة البرمجيات',
      description: '',
      field: 'التقنية',
      requiredSkills: ['برمجة', 'حل المشكلات'],
      suitableInterests: ['التقنية'],
      coreSubjects: ['رياضيات', 'حاسب'],
      suitableAbilities: ['تفكير منطقي'],
      minimumGpa: 4,
    );
    const accounting = AcademicMajor(
      id: 'accounting',
      name: 'المحاسبة',
      description: '',
      field: 'الأعمال',
      requiredSkills: ['تحليل مالي'],
      suitableInterests: ['الأعمال'],
      coreSubjects: ['محاسبة'],
      suitableAbilities: ['دقة'],
      minimumGpa: 4,
    );

    final results = service.recommend(student: student, majors: [accounting, engineering]);

    expect(results.first.major.id, engineering.id);
    expect(results.first.matchPercentage, 100);
    expect(results.last.matchPercentage, 25);
    expect(results.first.reasons, isNotEmpty);
  });

  test('does not recommend unpublished majors', () {
    const hiddenMajor = AcademicMajor(
      id: 'hidden', name: 'مخفي', description: '', field: 'التقنية',
      requiredSkills: [], suitableInterests: [], coreSubjects: [], suitableAbilities: [], minimumGpa: 0, isPublished: false,
    );
    expect(service.recommend(student: student, majors: [hiddenMajor]), isEmpty);
  });
}
