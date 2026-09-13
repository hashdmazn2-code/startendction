import 'package:flutter/material.dart';

class AssessmentScreen extends StatelessWidget {
  const AssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('التقييم التعليمي')),
        body: const Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.quiz_outlined, size: 72),
              SizedBox(height: 20),
              Text('أسئلة التقييم تُدار من لوحة الإدارة', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700), textAlign: TextAlign.center),
              SizedBox(height: 10),
              Text('عند نشر تقييم، ستظهر أسئلته هنا وتُحفظ الإجابات والنتائج في حساب الطالب.', textAlign: TextAlign.center),
            ]),
          ),
        ),
      );
}
