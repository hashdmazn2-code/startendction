import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/educational_appointment.dart';
class AppointmentConflict implements Exception { const AppointmentConflict(); }
class EducationalAppointmentService {
  EducationalAppointmentService(this._db); final FirebaseFirestore _db;
  Future<String> book(EducationalAppointment appointment) async {
    final slotId='${appointment.advisorId}_${appointment.startAt.toUtc().toIso8601String()}';
    await _db.runTransaction((tx) async { final slot=_db.collection('appointment_slots').doc(slotId); if((await tx.get(slot)).exists) throw const AppointmentConflict(); tx.set(slot,{'advisorId':appointment.advisorId,'studentId':appointment.studentId,'startAt':Timestamp.fromDate(appointment.startAt),'endAt':Timestamp.fromDate(appointment.endAt),'appointmentId':appointment.id}); tx.set(_db.collection('appointments').doc(appointment.id),{'consultationId':appointment.consultationId,'studentId':appointment.studentId,'advisorId':appointment.advisorId,'startAt':Timestamp.fromDate(appointment.startAt),'endAt':Timestamp.fromDate(appointment.endAt),'status':'scheduled','createdAt':FieldValue.serverTimestamp()}); tx.update(_db.collection('consultations').doc(appointment.consultationId),{'status':'scheduled','updatedAt':FieldValue.serverTimestamp()}); }); return appointment.id;
  }
}
