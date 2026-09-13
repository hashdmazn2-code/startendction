import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/educational_assessment.dart';
import '../../services/educational_firestore_service.dart';
import 'assessment_questions_screen.dart';

class AssessmentsScreen extends StatelessWidget {
  const AssessmentsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('التقييمات التعليمية')),
    body: StreamBuilder<List<EducationalAssessment>>(
      stream: context.read<EducationalFirestoreService>().assessments(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Center(child: Text('تعذر تحميل التقييمات.'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        if (snapshot.data!.isEmpty) return const Center(child: Text('لا توجد تقييمات منشورة حاليًا.'));
        return ListView.builder(itemCount: snapshot.data!.length, itemBuilder: (context, index) {
          final assessment = snapshot.data![index];
          return Card(child: ListTile(leading: const Icon(Icons.psychology_alt_outlined), title: Text(assessment.title), subtitle: Text(assessment.description), trailing: const Icon(Icons.arrow_back_ios_new_rounded), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AssessmentQuestionsScreen(assessment: assessment, studentId: FirebaseAuth.instance.currentUser!.uid)))));
        });
      },
    ),
  );
}
