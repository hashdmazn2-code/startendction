import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/education_controller.dart';
import '../../models/educational_assessment.dart';
import '../../models/student_profile.dart';
import '../../repositories/educational_repository.dart';
import '../../services/educational_firestore_service.dart';
import 'recommendations_screen.dart';

class AssessmentQuestionsScreen extends StatefulWidget {
  const AssessmentQuestionsScreen({super.key, required this.assessment, required this.studentId});
  final EducationalAssessment assessment;
  final String studentId;
  @override State<AssessmentQuestionsScreen> createState() => _AssessmentQuestionsScreenState();
}
class _AssessmentQuestionsScreenState extends State<AssessmentQuestionsScreen> {
  final answers = <String, AssessmentOption>{};
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(widget.assessment.title)),
    body: StreamBuilder<List<AssessmentQuestion>>(
      stream: context.read<EducationalFirestoreService>().questions(widget.assessment.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final questions = snapshot.data!;
        if (questions.isEmpty) return const Center(child: Text('لم تُضف الإدارة أسئلة لهذا التقييم بعد.'));
        return StreamBuilder<StudentProfile?>(
          stream: context.read<EducationalRepository>().watchStudent(widget.studentId),
          builder: (context, profileSnapshot) {
            final profile = profileSnapshot.data;
            if (profile == null) return const Center(child: Text('أكمل ملفك الأكاديمي قبل بدء التقييم.'));
            return Consumer<EducationController>(builder: (context, controller, _) => ListView(padding: const EdgeInsets.all(16), children: [
              LinearProgressIndicator(value: answers.length / questions.length), const SizedBox(height: 16),
              ...questions.map((question) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(question.text, style: Theme.of(context).textTheme.titleMedium), ...question.options.map((option) => RadioListTile<AssessmentOption>(value: option, groupValue: answers[question.id], title: Text(option.label), onChanged: (value) => setState(() => answers[question.id] = value!)))])))),
              FilledButton(onPressed: answers.length != questions.length || controller.saving ? null : () async { await controller.submitAssessment(profile: profile, assessmentId: widget.assessment.id, questions: questions, answers: answers); if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RecommendationsScreen(studentId: widget.studentId))); }, child: Text(controller.saving ? 'جارٍ تحليل الإجابات...' : 'عرض تخصصاتي المقترحة')),
            ]));
          },
        );
      },
    ),
  );
}
