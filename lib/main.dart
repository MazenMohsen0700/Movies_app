import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // import المكتبة
import 'package:movie_app/features/Auth/presentation/screens/login_screen.dart';

import 'core/conging/confing.dart';
import 'features/browse_movies/presentation/screens/browse_movies_screen.dart';
import 'firebase_options.dart';
import 'features/Auth/presentation/cubit/auth_cubit.dart';
import 'features/Auth/presentation/cubit/cubit_changel_lang.dart';
import 'features/Auth/presentation/screens/login_screen.dart';
import 'features/Auth/presentation/screens/register_screen.dart';
import 'features/Splash/Presentation/Pages/Splash_screen.dart';
import 'features/browse_movies/presentation/screens/browse_movies_screen.dart';
import 'features/onboarding/presentation/pages/Onboarding_Screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => LocaleCubit()),
      ],
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
        return BlocBuilder<LocaleCubit, Locale>(
          builder: (context, locale) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: locale, // اللغة هنا تتغير لشاشات الـ Auth عادي
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: const SplashScreen(),
              routes: {
                '/onboarding': (context) => const OnboardingScreen(),
                '/login': (context) => const LoginScreen(),
                '/register': (context) => const RegisterScreen(),
                '/home': (context) => const BrowseMoviesScreen(),
              },
              theme: ThemeData(),
            );
          },
        );
      },
    );
  }
}