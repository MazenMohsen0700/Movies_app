import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/browse_movies/presentation/screens/browse_movies_screen.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      theme: AppTheme.darkTheme,
      home: const BrowseMoviesScreen(),
    );
  }
}