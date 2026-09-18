import 'package:animate_do/animate_do.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../Auth/presentation/screens/login_screen.dart';
import '../../../browse_movies/presentation/screens/browse_movies_screen.dart';
import '../../../onboarding/presentation/pages/Onboarding_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String RouteName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();

    final bool onboardingSeen = prefs.getBool('onboarding_seen') ?? false;

    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BrowseMoviesScreen()),
      );
    } else if (onboardingSeen) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: ZoomIn(
                duration: const Duration(seconds: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/Splash_Images/Logo.png",
                      width: 121,
                      height: 118,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: BounceInDown(
                duration: const Duration(seconds: 2),
                delay: const Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/Splash_Images/Route_Logo.png",
                      width: 180,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Supervised by Mohamed Nabil",
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
