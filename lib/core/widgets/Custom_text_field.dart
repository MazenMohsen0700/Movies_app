import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/appcolor.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.logo,
    this.keyboardType,
    this.validator,
    this.controller,
    this.logo2,
    this.isPassword = false,
  });

  final String hintText;
  final String logo;
  final String? logo2;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final bool isPassword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    const borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
      borderSide: BorderSide(color: Appcolor.gray, width: 2.0),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPassword ? _obscureText : false,
        onTapOutside: (_) => FocusManager.instance.primaryFocus!.unfocus(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          enabledBorder: borderStyle,
          focusedBorder: borderStyle,
          border: borderStyle,
          filled: true,
          fillColor: Appcolor.gray,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(widget.logo, width: 31, height: 25),
            ),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.white,
            ),
            onPressed: () => setState(() => _obscureText = !_obscureText),
          )
              : widget.logo2 != null
              ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SvgPicture.asset(widget.logo2!, width: 31, height: 25),
            ),
          )
              : null,
        ),
      ),
    );
  }
}