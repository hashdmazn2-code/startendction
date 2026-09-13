import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'academic_profile_screen.dart';
import 'advisors_screen.dart';
import 'assessments_screen.dart';
import 'consultations_screen.dart';
import 'education_home_screen.dart';
import 'recommendations_screen.dart';
class StudentShell extends StatefulWidget{const StudentShell({super.key});@override State<StudentShell> createState()=>_StudentShellState();}
class _StudentShellState extends State<StudentShell>{int tab=0;@override Widget build(BuildContext context){final uid=FirebaseAuth.instance.currentUser!.uid;final pages=[const EducationHomeScreen(),const AssessmentsScreen(),RecommendationsScreen(studentId:uid),ConsultationsScreen(userId:uid),AcademicProfileScreen(studentId:uid)];return Scaffold(body:pages[tab],bottomNavigationBar:NavigationBar(selectedIndex:tab,onDestinationSelected:(v)=>setState(()=>tab=v),destinations:const[NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'الرئيسية'),NavigationDestination(icon:Icon(Icons.fact_check_outlined),label:'التقييمات'),NavigationDestination(icon:Icon(Icons.auto_awesome_outlined),label:'التوصيات'),NavigationDestination(icon:Icon(Icons.forum_outlined),label:'الاستشارات'),NavigationDestination(icon:Icon(Icons.person_outline),label:'ملفي')]));}}
