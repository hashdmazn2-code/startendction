enum ConsultationStatus { pending, accepted, rejected, scheduled, inProgress, completed, cancelled }

class EducationalConsultation {
  const EducationalConsultation({required this.id, required this.studentId, required this.advisorId, required this.status, required this.subject, this.note, this.appointmentAt, this.conversationId});
  final String id;
  final String studentId;
  final String advisorId;
  final ConsultationStatus status;
  final String subject;
  final String? note;
  final DateTime? appointmentAt;
  final String? conversationId;
  factory EducationalConsultation.fromMap(String id, Map<String, dynamic> data) => EducationalConsultation(
    id: id, studentId: data['studentId']?.toString() ?? '', advisorId: data['advisorId']?.toString() ?? '',
    status: ConsultationStatus.values.firstWhere((value) => value.name == data['status'], orElse: () => ConsultationStatus.pending),
    subject: data['subject']?.toString() ?? '', note: data['note']?.toString(), conversationId: data['conversationId']?.toString(),
    appointmentAt: data['appointmentAt'] is DateTime ? data['appointmentAt'] as DateTime : null,
  );
}
