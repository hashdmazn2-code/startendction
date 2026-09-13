import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/educational_advisor.dart';
import '../../services/educational_firestore_service.dart';
import 'consultation_request_screen.dart';
class AdvisorsScreen extends StatelessWidget { const AdvisorsScreen({super.key, required this.studentId}); final String studentId;
@override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('المستشارون التعليميون')),body:StreamBuilder<List<EducationalAdvisor>>(stream:context.read<EducationalFirestoreService>().advisors(),builder:(context,snap){if(!snap.hasData)return const Center(child:CircularProgressIndicator());if(snap.data!.isEmpty)return const Center(child:Text('لا يوجد مستشارون معتمدون حاليًا.'));return ListView(children:snap.data!.map((advisor)=>Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.school)),title:Text(advisor.name),subtitle:Text('${advisor.field} • ${advisor.institution}'),trailing:const Icon(Icons.arrow_back_ios_new),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>ConsultationRequestScreen(studentId:studentId,advisor:advisor)))))).toList());}));}
