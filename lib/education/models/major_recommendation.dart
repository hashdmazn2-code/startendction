import 'academic_major.dart';

class MajorRecommendation {
  const MajorRecommendation({
    required this.major,
    required this.matchPercentage,
    required this.reasons,
    required this.strengths,
    required this.missingRequirements,
  });

  final AcademicMajor major;
  final int matchPercentage;
  final List<String> reasons;
  final List<String> strengths;
  final List<String> missingRequirements;
}
