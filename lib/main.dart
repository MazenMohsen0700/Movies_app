import 'package:flutter/material.dart';

import 'features/Auth/presentation/screens/login_screen.dart';
import 'features/Splash/Presentation/Pages/Splash_screen.dart';
import 'features/onboarding/presentation/pages/Onboarding_Screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
        },

      theme: ThemeData(

      ),

    );
  }
}


