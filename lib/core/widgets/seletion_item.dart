import 'package:flutter/material.dart';

class LanguageSwitch extends StatefulWidget {
  const LanguageSwitch({super.key});

  @override
  State<LanguageSwitch> createState() => _LanguageSwitchState();
}

class _LanguageSwitchState extends State<LanguageSwitch> {
  bool isLeft = true;

  final String firstFlag = 'assets/images/eg.png';
  final String secondFlag = 'assets/images/LR.png';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => isLeft = !isLeft),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 68,
        height: 36,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.amber, width: 2),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            width: 28,
            height: 28,
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: Colors.amber,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                isLeft ? firstFlag : secondFlag,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}