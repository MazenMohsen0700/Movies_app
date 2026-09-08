import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/appcolor.dart';

class Custombut extends StatelessWidget {
  Custombut({
    super.key,
    required this.text,
    this.isloading = false,
    this.onPressed,
    this.logo,
  });

  String text;
  bool isloading;
  void Function()? onPressed;
  String? logo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            disabledColor: Appcolor.Mainyello,
            color: Appcolor.Mainyello,
            onPressed: isloading ? null : onPressed,
            borderRadius: BorderRadius.circular(16),

            child: AnimatedCrossFade(
              firstChild: const CupertinoActivityIndicator(color: Colors.black),

              secondChild: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (logo != null) ...[
                    SvgPicture.asset(logo!, width: 24, height: 24),
                    const SizedBox(width: 10),
                  ],

                  Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              crossFadeState: isloading
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,

              duration: const Duration(seconds: 1),
            ),
          ),
        ),
      ),
    );
  }
}
