import 'package:digl/education/models/educational_appointment.dart';
import 'package:flutter_test/flutter_test.dart';
void main(){test('detects conflicting advisor time slots',(){final a=EducationalAppointment(id:'a',consultationId:'c',studentId:'s',advisorId:'d',startAt:DateTime(2026,1,1,10),endAt:DateTime(2026,1,1,10,30),status:'scheduled');final b=EducationalAppointment(id:'b',consultationId:'c2',studentId:'s2',advisorId:'d',startAt:DateTime(2026,1,1,10,15),endAt:DateTime(2026,1,1,10,45),status:'scheduled');expect(a.overlaps(b),isTrue);});}
