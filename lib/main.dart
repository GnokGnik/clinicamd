import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
//Pj8/Pz9FP3Blbj8GHwZTP3s/J0gNCg==

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClinicaMD',
      themeMode: ThemeMode.system,
      home: AuthService().handleAuthState(),
    );
  }
}
