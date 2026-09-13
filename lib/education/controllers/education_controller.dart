import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/academic_major.dart';
import '../models/educational_assessment.dart';
import '../models/student_profile.dart';
import '../services/educational_firestore_service.dart';

class EducationController extends ChangeNotifier {
  EducationController(this.service, this.auth);
  final EducationalFirestoreService service;
  final FirebaseAuth auth;
  bool saving = false;

  Future<void> submitAssessment({required StudentProfile profile, required String assessmentId, required List<AssessmentQuestion> questions, required Map<String, AssessmentOption> answers}) async {
    saving = true; notifyListeners();
    try { await service.submitAssessment(student: profile, assessmentId: assessmentId, questions: questions, answers: answers); }
    finally { saving = false; notifyListeners(); }
  }
}
