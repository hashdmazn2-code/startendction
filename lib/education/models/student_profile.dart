class StudentProfile {
  const StudentProfile({
    required this.id,
    required this.fullName,
    required this.gpa,
    required this.skills,
    required this.interests,
    required this.favoriteSubjects,
    required this.abilities,
    this.educationLevel,
    this.institution,
    this.futureGoals = const [],
    this.assessmentScores = const {},
  });

  final String id;
  final String fullName;
  final double gpa;
  final List<String> skills;
  final List<String> interests;
  final List<String> favoriteSubjects;
  final List<String> abilities;
  final String? educationLevel;
  final String? institution;
  final List<String> futureGoals;
  /// Category scores produced by the Firebase-managed assessment (0–100).
  final Map<String, double> assessmentScores;

  Map<String, dynamic> toMap() => {
        'fullName': fullName,
        'gpa': gpa,
        'skills': skills,
        'interests': interests,
        'favoriteSubjects': favoriteSubjects,
        'abilities': abilities,
        'educationLevel': educationLevel,
        'institution': institution,
        'futureGoals': futureGoals,
        'assessmentScores': assessmentScores,
        'updatedAt': DateTime.now().toUtc().toIso8601String(),
      };

  factory StudentProfile.fromMap(String id, Map<String, dynamic> data) => StudentProfile(
        id: id,
        fullName: data['fullName']?.toString() ?? '',
        gpa: (data['gpa'] as num?)?.toDouble() ?? 0,
        skills: _strings(data['skills']),
        interests: _strings(data['interests']),
        favoriteSubjects: _strings(data['favoriteSubjects']),
        abilities: _strings(data['abilities']),
        educationLevel: data['educationLevel']?.toString(),
        institution: data['institution']?.toString(),
        futureGoals: _strings(data['futureGoals']),
        assessmentScores: (data['assessmentScores'] as Map<String, dynamic>? ?? const {})
            .map((key, value) => MapEntry(key, (value as num?)?.toDouble() ?? 0)),
      );

  static List<String> _strings(dynamic value) =>
      value is List ? value.map((item) => item.toString()).toList() : const [];
}
