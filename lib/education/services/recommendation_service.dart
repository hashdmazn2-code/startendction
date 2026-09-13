import '../models/academic_major.dart';
import '../models/major_recommendation.dart';
import '../models/student_profile.dart';

/// Deterministic, testable major matching. Every factor is capped so a strong
/// result reflects the student's saved academic data rather than random values.
class RecommendationService {
  const RecommendationService();

  List<MajorRecommendation> recommend({
    required StudentProfile student,
    required Iterable<AcademicMajor> majors,
  }) {
    final recommendations = majors.where((major) => major.isPublished).map(
      (major) => _score(student, major),
    ).toList()
      ..sort((a, b) => b.matchPercentage.compareTo(a.matchPercentage));
    return recommendations;
  }

  MajorRecommendation _score(StudentProfile student, AcademicMajor major) {
    final reasons = <String>[];
    final strengths = <String>[];
    final gaps = <String>[];
    var points = 0.0;

    final gpaRatio = major.minimumGpa <= 0
        ? 1.0
        : (student.gpa / major.minimumGpa).clamp(0.0, 1.0);
    points += gpaRatio * 25;
    if (gpaRatio >= 1) {
      reasons.add('معدلك الأكاديمي يحقق متطلبات التخصص');
      strengths.add('المعدل الدراسي');
    } else {
      gaps.add('رفع المعدل إلى ${major.minimumGpa.toStringAsFixed(1)} أو أعلى');
    }

    points += _matchedPoints(student.skills, major.requiredSkills, 25, 'مهاراتك', reasons, strengths);
    points += _matchedPoints(student.interests, major.suitableInterests, 20, 'اهتماماتك', reasons, strengths);
    points += _matchedPoints(student.favoriteSubjects, major.coreSubjects, 15, 'موادك المفضلة', reasons, strengths);
    points += _matchedPoints(student.abilities, major.suitableAbilities, 10, 'قدراتك', reasons, strengths);

    // Assessment categories are an evidence-based final 5% when the admin has
    // configured assessment scoring. Missing scores never inflate a result.
    final assessment = student.assessmentScores[major.field] ?? 0;
    if (assessment > 0) {
      points += assessment.clamp(0, 100) * .05;
      reasons.add('نتيجة تقييم جيدة في مجال ${major.field}');
    }

    if (reasons.isEmpty) reasons.add('أكمل ملفك الأكاديمي والتقييم للحصول على أسباب أدق');
    return MajorRecommendation(
      major: major,
      matchPercentage: points.round().clamp(0, 100),
      reasons: reasons,
      strengths: strengths,
      missingRequirements: gaps,
    );
  }

  double _matchedPoints(
    List<String> studentValues,
    List<String> targetValues,
    double weight,
    String label,
    List<String> reasons,
    List<String> strengths,
  ) {
    if (targetValues.isEmpty || studentValues.isEmpty) return 0;
    final normalizedStudent = studentValues.map(_normalize).toSet();
    final matches = targetValues.where((item) => normalizedStudent.contains(_normalize(item))).toList();
    if (matches.isEmpty) return 0;
    reasons.add('$label متوافقة: ${matches.join('، ')}');
    strengths.addAll(matches);
    return weight * matches.length / targetValues.length;
  }

  String _normalize(String value) => value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
}
