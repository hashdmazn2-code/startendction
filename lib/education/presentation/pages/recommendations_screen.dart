import 'package:flutter/material.dart';

class RecommendationsScreen extends StatelessWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('التخصصات المقترحة لك')),
        body: const Padding(
          padding: EdgeInsets.all(24),
          child: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.explore_outlined, size: 72),
              SizedBox(height: 20),
              Text('أكمل ملفك الأكاديمي أولاً', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700)),
              SizedBox(height: 10),
              Text('سنحسب المطابقة من المعدل والمهارات والاهتمامات والمواد المفضلة ونتيجة التقييم، ثم نعرض أسباب كل ترشيح.', textAlign: TextAlign.center),
            ]),
          ),
        ),
      );
}
