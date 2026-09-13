class AcademicMajor {
  const AcademicMajor({
    required this.id,
    required this.name,
    required this.description,
    required this.field,
    required this.requiredSkills,
    required this.suitableInterests,
    required this.coreSubjects,
    required this.suitableAbilities,
    required this.minimumGpa,
    this.futureJobs = const [],
    this.isPublished = true,
  });

  final String id;
  final String name;
  final String description;
  final String field;
  final List<String> requiredSkills;
  final List<String> suitableInterests;
  final List<String> coreSubjects;
  final List<String> suitableAbilities;
  final double minimumGpa;
  final List<String> futureJobs;
  final bool isPublished;

  factory AcademicMajor.fromMap(String id, Map<String, dynamic> data) => AcademicMajor(
        id: id,
        name: data['name']?.toString() ?? '',
        description: data['description']?.toString() ?? '',
        field: data['field']?.toString() ?? '',
        requiredSkills: _strings(data['requiredSkills']),
        suitableInterests: _strings(data['suitableInterests']),
        coreSubjects: _strings(data['coreSubjects']),
        suitableAbilities: _strings(data['suitableAbilities']),
        minimumGpa: (data['minimumGpa'] as num?)?.toDouble() ?? 0,
        futureJobs: _strings(data['futureJobs']),
        isPublished: data['isPublished'] as bool? ?? true,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'field': field,
        'requiredSkills': requiredSkills,
        'suitableInterests': suitableInterests,
        'coreSubjects': coreSubjects,
        'suitableAbilities': suitableAbilities,
        'minimumGpa': minimumGpa,
        'futureJobs': futureJobs,
        'isPublished': isPublished,
      };

  static List<String> _strings(dynamic value) =>
      value is List ? value.map((item) => item.toString()).toList() : const [];
}
