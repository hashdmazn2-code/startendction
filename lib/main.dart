import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'education/controllers/education_controller.dart';
import 'education/presentation/pages/splash_screen.dart';
import 'education/repositories/educational_repository.dart';
import 'education/services/educational_firestore_service.dart';
import 'education/theme/education_theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SmartEducationalAdvisorApp());
}

class SmartEducationalAdvisorApp extends StatelessWidget {
  const SmartEducationalAdvisorApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider(create: (_) => EducationalFirestoreService(FirebaseFirestore.instance)),
          Provider(create: (_) => EducationalRepository(FirebaseFirestore.instance)),
          ChangeNotifierProvider(
            create: (context) => EducationController(
              context.read<EducationalFirestoreService>(),
              FirebaseAuth.instance,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'المستشار التعليمي الذكي',
          debugShowCheckedModeBanner: false,
          theme: EducationTheme.light(),
          darkTheme: EducationTheme.dark(),
          themeMode: ThemeMode.system,
          locale: const Locale('ar'),
          builder: (context, child) => Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          ),
          home: const SplashScreen(),
        ),
      );
}
