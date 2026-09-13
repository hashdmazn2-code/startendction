import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../models/academic_major.dart';
import 'major_details_screen.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key, this.studentId});
  final String? studentId;
  @override
  Widget build(BuildContext context) {
    if (studentId == null) return const Scaffold(body: Center(child: Text('سجّل الدخول لعرض تخصصاتك المقترحة.')));
    return Scaffold(appBar: AppBar(title: const Text('التخصصات المقترحة لك')), body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection('recommendations').where('studentId', isEqualTo: studentId).orderBy('matchPercentage', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Center(child: Text('تعذر تحميل التوصيات.'));
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        if (snapshot.data!.docs.isEmpty) return const Center(child: Text('أكمل تقييمك التعليمي للحصول على تخصصات مقترحة.'));
        return ListView.builder(itemCount: snapshot.data!.docs.length, itemBuilder: (context, index) {
          final recommendation = snapshot.data!.docs[index].data();
          return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(future: FirebaseFirestore.instance.collection('majors').doc(recommendation['majorId']).get(), builder: (context, majorSnapshot) {
            if (!majorSnapshot.hasData || !majorSnapshot.data!.exists) return const SizedBox.shrink();
            final major = AcademicMajor.fromMap(majorSnapshot.data!.id, majorSnapshot.data!.data()!);
            final reasons = (recommendation['reasons'] as List? ?? const []).join(' • ');
            return Card(child: ListTile(leading: CircleAvatar(child: Text('${recommendation['matchPercentage']}%')), title: Text(major.name), subtitle: Text(reasons), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MajorDetailsScreen(major: major, matchPercentage: recommendation['matchPercentage'] as int?)))));
          });
        });
      },
    ));
  }
}
