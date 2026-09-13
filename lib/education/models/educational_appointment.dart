class EducationalAppointment {
  const EducationalAppointment({required this.id,required this.consultationId,required this.studentId,required this.advisorId,required this.startAt,required this.endAt,required this.status});
  final String id, consultationId, studentId, advisorId, status;
  final DateTime startAt,endAt;
  bool overlaps(EducationalAppointment other) => advisorId == other.advisorId && startAt.isBefore(other.endAt) && endAt.isAfter(other.startAt);
}
