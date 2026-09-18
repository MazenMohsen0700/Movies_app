import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/Auth/presentation/cubit/cubit_changel_lang.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  final String arFlag = 'assets/images/eg.png';
  final String enFlag = 'assets/images/LR.png';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, currentLocale) {
        final isArabic = currentLocale.languageCode == 'ar';

        return GestureDetector(
          onTap: () {
            final newLang = isArabic ? 'en' : 'ar';
            context.read<LocaleCubit>().changeLanguage(newLang);
          },
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
              alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
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
                    isArabic ? arFlag : enFlag,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}