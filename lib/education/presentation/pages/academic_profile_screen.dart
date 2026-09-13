import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/student_profile.dart';
import '../../repositories/educational_repository.dart';

class AcademicProfileScreen extends StatefulWidget {
  const AcademicProfileScreen({super.key, required this.studentId});
  final String studentId;
  @override State<AcademicProfileScreen> createState() => _AcademicProfileScreenState();
}
class _AcademicProfileScreenState extends State<AcademicProfileScreen> {
  final form = GlobalKey<FormState>(); final name = TextEditingController(); final gpa = TextEditingController(); final institution = TextEditingController(); final skills = TextEditingController(); final interests = TextEditingController(); final subjects = TextEditingController(); final abilities = TextEditingController();
  bool loaded = false;
  List<String> list(TextEditingController c) => c.text.split(',').map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('ملفي الأكاديمي')), body: StreamBuilder<StudentProfile?>(stream: context.read<EducationalRepository>().watchStudent(widget.studentId), builder: (context, snap) {
    final p = snap.data; if (!loaded && p != null) { loaded = true; name.text=p.fullName; gpa.text=p.gpa.toString(); institution.text=p.institution??''; skills.text=p.skills.join(', '); interests.text=p.interests.join(', '); subjects.text=p.favoriteSubjects.join(', '); abilities.text=p.abilities.join(', '); }
    return Form(key: form, child: ListView(padding: const EdgeInsets.all(16), children: [
      _field(name, 'الاسم'), _field(gpa, 'المعدل التراكمي', number: true), _field(institution, 'المدرسة / الجامعة'), _field(skills, 'المهارات (افصل بفاصلة)'), _field(interests, 'الاهتمامات (افصل بفاصلة)'), _field(subjects, 'المواد المفضلة (افصل بفاصلة)'), _field(abilities, 'القدرات (افصل بفاصلة)'),
      FilledButton(onPressed: () async { if (!form.currentState!.validate()) return; await context.read<EducationalRepository>().saveStudent(StudentProfile(id: widget.studentId, fullName: name.text.trim(), gpa: double.tryParse(gpa.text) ?? 0, skills: list(skills), interests: list(interests), favoriteSubjects: list(subjects), abilities: list(abilities), institution: institution.text.trim())); if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم حفظ الملف الأكاديمي.'))); }, child: const Text('حفظ البيانات')),
    ]));
  }));
  Widget _field(TextEditingController c, String label, {bool number=false}) => Padding(padding: const EdgeInsets.only(bottom: 12), child: TextFormField(controller: c, keyboardType: number ? TextInputType.number : null, decoration: InputDecoration(labelText: label), validator: (v) => v == null || v.trim().isEmpty ? 'هذا الحقل مطلوب' : null));
}
