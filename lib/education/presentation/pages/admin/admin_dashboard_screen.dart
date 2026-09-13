import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  Future<Map<String, int>> _counts() async {
    final db = FirebaseFirestore.instance;
    final entries = await Future.wait([
      db.collection('students').count().get(),
      db.collection('advisors').count().get(),
      db.collection('advisors').where('verificationStatus', isEqualTo: 'pending').count().get(),
      db.collection('consultations').count().get(),
      db.collection('appointments').count().get(),
      db.collection('majors').count().get(),
      db.collection('assessments').count().get(),
    ]);
    return {
      'الطلاب': entries[0].count ?? 0,
      'المستشارون': entries[1].count ?? 0,
      'طلبات الاعتماد': entries[2].count ?? 0,
      'الاستشارات': entries[3].count ?? 0,
      'المواعيد': entries[4].count ?? 0,
      'التخصصات': entries[5].count ?? 0,
      'التقييمات': entries[6].count ?? 0,
    };
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('لوحة تحكم الإدارة')),
        body: FutureBuilder<Map<String, int>>(
          future: _counts(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('تعذر تحميل إحصائيات الإدارة.'));
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return GridView.count(
              padding: const EdgeInsets.all(20),
              crossAxisCount: MediaQuery.sizeOf(context).width > 700 ? 4 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: snapshot.data!.entries.map((entry) => Card(
                child: Center(child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text('${entry.value}', style: Theme.of(context).textTheme.headlineMedium), Text(entry.key)],
                )),
              )).toList(),
            );
          },
        ),
      );
}
