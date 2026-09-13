import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'student_shell.dart';
import 'advisor_shell.dart';
import 'simple_auth_screen.dart';

class EducationAuthGate extends StatelessWidget { const EducationAuthGate({super.key});
@override Widget build(BuildContext context)=>StreamBuilder<User?>(stream:FirebaseAuth.instance.authStateChanges(),builder:(context,snapshot){if(snapshot.connectionState==ConnectionState.waiting)return const Scaffold(body:Center(child:CircularProgressIndicator()));final user=snapshot.data;if(user==null)return const SimpleAuthScreen();return FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(future:FirebaseFirestore.instance.collection('users').doc(user.uid).get(),builder:(context,account){if(!account.hasData)return const Scaffold(body:Center(child:CircularProgressIndicator()));final role=account.data!.data()?['accountType']??'student';if(role=='advisor' && account.data!.data()?['isVerified']!=true)return const _VerificationPending(); if(role=='advisor') return const AdvisorShell(); return const StudentShell();});});}
class _VerificationPending extends StatelessWidget {const _VerificationPending();@override Widget build(BuildContext context)=>Scaffold(body:Center(child:Padding(padding:const EdgeInsets.all(24),child:Column(mainAxisSize:MainAxisSize.min,children:[const Icon(Icons.verified_user_outlined,size:72),const SizedBox(height:16),const Text('طلب اعتماد المستشار قيد المراجعة',style:TextStyle(fontSize:20,fontWeight:FontWeight.bold),textAlign:TextAlign.center),const SizedBox(height:12),const Text('سنرسل إشعارًا فور مراجعة مؤهلاتك من الإدارة.',textAlign:TextAlign.center),TextButton(onPressed:FirebaseAuth.instance.signOut,child:const Text('تسجيل الخروج'))]))));}
