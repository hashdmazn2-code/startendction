class EducationalAssessment {
  const EducationalAssessment({required this.id, required this.title, required this.description, required this.isPublished});
  final String id;
  final String title;
  final String description;
  final bool isPublished;
  factory EducationalAssessment.fromMap(String id, Map<String, dynamic> data) => EducationalAssessment(id: id, title: data['title']?.toString() ?? '', description: data['description']?.toString() ?? '', isPublished: data['isPublished'] == true);
}

class AssessmentQuestion {
  const AssessmentQuestion({required this.id, required this.text, required this.category, required this.options});
  final String id;
  final String text;
  final String category;
  final List<AssessmentOption> options;
  factory AssessmentQuestion.fromMap(String id, Map<String, dynamic> data) => AssessmentQuestion(
    id: id, text: data['text']?.toString() ?? '', category: data['category']?.toString() ?? 'عام',
    options: ((data['options'] as List?) ?? const []).whereType<Map>().map((item) => AssessmentOption.fromMap(Map<String, dynamic>.from(item))).toList(),
  );
}

class AssessmentOption {
  const AssessmentOption({required this.id, required this.label, required this.score});
  final String id;
  final String label;
  final double score;
  factory AssessmentOption.fromMap(Map<String, dynamic> data) => AssessmentOption(id: data['id']?.toString() ?? data['label']?.toString() ?? '', label: data['label']?.toString() ?? '', score: (data['score'] as num?)?.toDouble() ?? 0);
}
