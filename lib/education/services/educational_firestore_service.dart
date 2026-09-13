import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/academic_major.dart';
import '../models/educational_advisor.dart';
import '../models/educational_assessment.dart';
import '../models/educational_consultation.dart';
import '../models/student_profile.dart';
import 'recommendation_service.dart';

class EducationalFirestoreService {
  EducationalFirestoreService(this._db, {RecommendationService? recommendationService}) : _recommendationService = recommendationService ?? const RecommendationService();
  final FirebaseFirestore _db;
  final RecommendationService _recommendationService;

  Stream<List<EducationalAssessment>> assessments() => _db.collection('assessments').where('isPublished', isEqualTo: true).snapshots().map((s) => s.docs.map((d) => EducationalAssessment.fromMap(d.id, d.data())).toList());
  Stream<List<AssessmentQuestion>> questions(String assessmentId) => _db.collection('assessments').doc(assessmentId).collection('questions').orderBy('order').snapshots().map((s) => s.docs.map((d) => AssessmentQuestion.fromMap(d.id, d.data())).toList());
  Stream<List<AcademicMajor>> majors() => _db.collection('majors').where('isPublished', isEqualTo: true).snapshots().map((s) => s.docs.map((d) => AcademicMajor.fromMap(d.id, d.data())).toList());
  Stream<List<EducationalAdvisor>> advisors() => _db.collection('advisors').where('isVerified', isEqualTo: true).snapshots().map((s) => s.docs.map((d) => EducationalAdvisor.fromMap(d.id, d.data())).toList());
  Stream<List<EducationalConsultation>> consultationsFor(String uid) => _db.collection('consultations').where('participantIds', arrayContains: uid).orderBy('updatedAt', descending: true).snapshots().map((s) => s.docs.map((d) => EducationalConsultation.fromMap(d.id, d.data())).toList());

  Future<void> submitAssessment({required StudentProfile student, required String assessmentId, required List<AssessmentQuestion> questions, required Map<String, AssessmentOption> answers}) async {
    final scores = <String, List<double>>{};
    for (final question in questions) { final answer = answers[question.id]; if (answer != null) (scores[question.category] ??= []).add(answer.score); }
    final categoryScores = scores.map((key, values) => MapEntry(key, values.isEmpty ? 0 : values.reduce((a, b) => a + b) / values.length));
    final majorDocs = await _db.collection('majors').where('isPublished', isEqualTo: true).get();
    final profile = StudentProfile(id: student.id, fullName: student.fullName, gpa: student.gpa, skills: student.skills, interests: student.interests, favoriteSubjects: student.favoriteSubjects, abilities: student.abilities, educationLevel: student.educationLevel, institution: student.institution, futureGoals: student.futureGoals, assessmentScores: categoryScores);
    final recommendations = _recommendationService.recommend(student: profile, majors: majorDocs.docs.map((d) => AcademicMajor.fromMap(d.id, d.data())));
    final batch = _db.batch();
    final result = _db.collection('assessment_results').doc();
    batch.set(result, {'assessmentId': assessmentId, 'studentId': student.id, 'answers': answers.map((id, option) => MapEntry(id, {'optionId': option.id, 'score': option.score})), 'categoryScores': categoryScores, 'score': categoryScores.values.fold<double>(0, (a, b) => a + b) / (categoryScores.isEmpty ? 1 : categoryScores.length), 'createdAt': FieldValue.serverTimestamp()});
    batch.set(_db.collection('students').doc(student.id), profile.toMap(), SetOptions(merge: true));
    for (final item in recommendations) { batch.set(_db.collection('recommendations').doc('${student.id}_${item.major.id}'), {'studentId': student.id, 'majorId': item.major.id, 'matchPercentage': item.matchPercentage, 'reasons': item.reasons, 'strengths': item.strengths, 'missingRequirements': item.missingRequirements, 'assessmentResultId': result.id, 'updatedAt': FieldValue.serverTimestamp()}); }
    await batch.commit();
  }

  Future<String> requestConsultation({required String studentId, required String advisorId, required String subject, required String note}) async {
    final ref = _db.collection('consultations').doc();
    await ref.set({'studentId': studentId, 'advisorId': advisorId, 'participantIds': [studentId, advisorId], 'subject': subject, 'note': note, 'status': ConsultationStatus.pending.name, 'createdAt': FieldValue.serverTimestamp(), 'updatedAt': FieldValue.serverTimestamp()});
    return ref.id;
  }

  Future<void> updateConsultationStatus(String id, ConsultationStatus status) => _db.collection('consultations').doc(id).update({'status': status.name, 'updatedAt': FieldValue.serverTimestamp()});
}
