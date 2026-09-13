import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/educational_consultation.dart';
import '../../services/educational_firestore_service.dart';
class ConsultationsScreen extends StatelessWidget { const ConsultationsScreen({super.key, required this.userId}); final String userId;
@override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('استشاراتي')), body: StreamBuilder<List<EducationalConsultation>>(stream: context.read<EducationalFirestoreService>().consultationsFor(userId), builder:(context,snap){if(!snap.hasData)return const Center(child:CircularProgressIndicator()); if(snap.data!.isEmpty)return const Center(child:Text('لا توجد استشارات بعد.')); return ListView(children:snap.data!.map((item)=>Card(child:ListTile(title:Text(item.subject),subtitle:Text('الحالة: ${item.status.name}'),trailing: item.status==ConsultationStatus.pending?null:const Icon(Icons.chat_bubble_outline)))).toList());})); }
