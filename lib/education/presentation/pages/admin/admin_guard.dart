import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'admin_dashboard_screen.dart';

class AdminGuard extends StatelessWidget {
  const AdminGuard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const _AccessDenied();
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        final account = snapshot.data!.data();
        if (account?['accountType'] != 'admin' || account?['isActive'] == false) {
          return const _AccessDenied();
        }
        return const AdminDashboardScreen();
      },
    );
  }
}

class _AccessDenied extends StatelessWidget {
  const _AccessDenied();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('وصول غير مسموح')),
        body: const Center(child: Text('هذه الصفحة مخصصة للمدير فقط.')),
      );
}
