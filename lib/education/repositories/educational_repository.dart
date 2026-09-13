import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/academic_major.dart';
import '../models/student_profile.dart';

/// Firestore boundary for educational data. Admin tools write `majors`; student
/// tools write only to the authenticated student's `students/{uid}` document.
class EducationalRepository {
  EducationalRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Stream<List<AcademicMajor>> watchPublishedMajors() => _firestore
      .collection('majors')
      .where('isPublished', isEqualTo: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => AcademicMajor.fromMap(doc.id, doc.data())).toList());

  Stream<StudentProfile?> watchStudent(String uid) => _firestore
      .collection('students')
      .doc(uid)
      .snapshots()
      .map((doc) => doc.exists ? StudentProfile.fromMap(doc.id, doc.data()!) : null);

  Future<void> saveStudent(StudentProfile profile) => _firestore
      .collection('students')
      .doc(profile.id)
      .set(profile.toMap(), SetOptions(merge: true));
}
