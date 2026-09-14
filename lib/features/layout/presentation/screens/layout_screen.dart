import 'package:flutter/material.dart';

import '../widget/custom_bottom_navigation.dart';
import 'home_screen.dart';
import 'search_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedIndex = 0;

  List<Widget> screens = [HomeScreen(), SearchScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: selectedIndex,
        onPressed: (index) {
          selectedIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
