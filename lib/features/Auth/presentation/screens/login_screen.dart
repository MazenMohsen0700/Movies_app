import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movie_app/features/Auth/presentation/screens/forget_screen.dart';
import 'package:movie_app/features/Auth/presentation/screens/register_screen.dart';
import '../../../../core/theme/appcolor.dart';
import '../../../../core/widgets/Custom_text_field.dart';
import '../../../../core/widgets/custombut.dart';
import '../../../../core/widgets/seletion_item.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../cubit/cubit_changel_lang.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, currentLocale) {
        return Localizations.override(
          context: context,
          locale: currentLocale,
          child: Builder(
            builder: (context) {
              final local = AppLocalizations.of(context)!;

              return Directionality(
                textDirection: TextDirection.ltr,
                child: BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) async {
                    if (state is AuthSuccess) {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('is_logged_in', true);
                      if (mounted) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    }
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Scaffold(
                    resizeToAvoidBottomInset: false,
                    backgroundColor: Appcolor.black,
                    body: SafeArea(
                      child: SingleChildScrollView(
                        child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              const SizedBox(height: 67),
                              Center(
                                child: Image.asset(
                                  "assets/images/logo_login.png",
                                  width: 121,
                                  height: 118,
                                ),
                              ),
                              const SizedBox(height: 67),
                              CustomTextField(
                                controller: emailController,
                                validator: (value) {
                                  bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                  ).hasMatch(value ?? "");
                                  if (value == null || value.isEmpty) {
                                    return "please enter email";
                                  } else if (!emailValid) {
                                    return "enter vaild email";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.emailAddress,
                                hintText: local.email,
                                logo: 'assets/icons/icn_mail.svg',
                              ),
                              const SizedBox(height: 33),
                              CustomTextField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "please enter Password";
                                  } else if (value.length < 8) {
                                    return "Password must be more than 8 char or numbers";
                                  } else {
                                    return null;
                                  }
                                },
                                keyboardType: TextInputType.visiblePassword,
                                hintText: local.password,
                                logo: 'assets/icons/icn_lock.svg',
                                isPassword: true,
                              ),
                              const SizedBox(height: 17.18),
                              Align(
                                alignment: Alignment.centerRight,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetScreen(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    local.forgot_password,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Appcolor.Mainyello,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 33.28),
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  return Custombut(
                                    text: local.login,
                                    isloading: state is LoginLoading,
                                    onPressed: () {
                                      if (formkey.currentState!.validate()) {
                                        context.read<AuthCubit>().login(
                                          email: emailController.text.trim(),
                                          password: passwordController.text
                                              .trim(),
                                        );
                                      }
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 22),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    local.dont_have_account,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const RegisterScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      " ${local.sign_up}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: Appcolor.Mainyello,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 27),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Divider(
                                      color: Appcolor.Mainyello,
                                      thickness: 1,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Text(
                                      local.or,
                                      style: TextStyle(
                                        color: Appcolor.Mainyello,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Divider(
                                      color: Appcolor.Mainyello,
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 27),
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  if (state is GoogleLoading) {
                                    return CircularProgressIndicator(
                                      color: Appcolor.Mainyello,
                                    );
                                  }
                                  return Custombut(
                                    text: local.login_with_google,
                                    logo: "assets/icons/icn_google.svg",
                                    onPressed: () {
                                      context
                                          .read<AuthCubit>()
                                          .loginWithGoogle();
                                    },
                                  );
                                },
                              ),
                              const SizedBox(height: 16),
                              const LanguageSwitch(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
