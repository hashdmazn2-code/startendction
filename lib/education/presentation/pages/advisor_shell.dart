import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/educational_consultation.dart';
import '../../services/educational_firestore_service.dart';

class AdvisorShell extends StatelessWidget { const AdvisorShell({super.key});
@override Widget build(BuildContext context){final uid=FirebaseAuth.instance.currentUser!.uid;return Scaffold(appBar:AppBar(title:const Text('بوابة المستشار التعليمي'),actions:[IconButton(onPressed:FirebaseAuth.instance.signOut,icon:const Icon(Icons.logout))]),body:StreamBuilder<List<EducationalConsultation>>(stream:context.read<EducationalFirestoreService>().consultationsFor(uid),builder:(context,snap){if(!snap.hasData)return const Center(child:CircularProgressIndicator());if(snap.data!.isEmpty)return const Center(child:Text('لا توجد طلبات استشارة حاليًا.'));return ListView(children:snap.data!.map((item)=>Card(child:ListTile(title:Text(item.subject),subtitle:Text('الحالة: ${item.status.name}'),trailing:item.status==ConsultationStatus.pending?Wrap(children:[IconButton(tooltip:'قبول',icon:const Icon(Icons.check_circle,color:Colors.green),onPressed:()=>context.read<EducationalFirestoreService>().updateConsultationStatus(item.id,ConsultationStatus.accepted)),IconButton(tooltip:'رفض',icon:const Icon(Icons.cancel,color:Colors.red),onPressed:()=>context.read<EducationalFirestoreService>().updateConsultationStatus(item.id,ConsultationStatus.rejected))]):null))).toList());}));}}
