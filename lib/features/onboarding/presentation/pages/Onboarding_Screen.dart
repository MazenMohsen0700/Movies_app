import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/app_colors.dart';
import 'OnboardingPageFive.dart';
import 'OnboardingPageFour.dart';
import 'OnboardingPageOne.dart';
import 'OnboardingPageSix.dart';
import 'OnboardingPageThree.dart';
import 'OnboardingPageTwo.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String RouteName = "/onboarding";

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('onboarding_seen', true);

    final saved = prefs.getBool('onboarding_seen');

    print('ONBOARDING SAVED: $saved');

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          OnboardingPageOne(onExplorePressed: _nextPage),
          OnboardingPageTwo(onNextPressed: _nextPage),
          OnboardingPageThree(
            onNextPressed: _nextPage,
            onBackPressed: _previousPage,
          ),
          OnboardingPageFour(
            onNextPressed: _nextPage,
            onBackPressed: _previousPage,
          ),
          OnboardingPageFive(
            onNextPressed: _nextPage,
            onBackPressed: _previousPage,
          ),
          OnboardingPageSix(
            onFinishPressed: _finish,
            onBackPressed: _previousPage,
          ),
        ],
      ),
    );
  }
}
