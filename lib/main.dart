import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // import المكتبة
import 'package:movie_app/features/layout/presentation/screens/home_screen.dart';

import 'features/browse_movies/presentation/screens/browse_movies_screen.dart';
import 'firebase_options.dart';
import 'features/Auth/presentation/cubit/auth_cubit.dart';
import 'features/Splash/Presentation/Pages/Splash_screen.dart';
import 'features/onboarding/presentation/pages/Onboarding_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    BlocProvider(
      create: (context) => AuthCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
            '/home': (context) =>  BrowseMoviesScreen()
          },
          theme: ThemeData(),
        );
      },
    );
  }
}