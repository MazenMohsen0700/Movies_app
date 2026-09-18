import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/Auth/presentation/screens/login_screen.dart';
import '../../../../core/theme/appcolor.dart';
import '../../../../core/widgets/Custom_text_field.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../core/widgets/custombut.dart';
import '../../../../core/widgets/seletion_item.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final List<String> avatarList = const [
    "assets/images/gamer1.png",
    "assets/images/gamer2.png",
    "assets/images/gamer3.png",
  ];
  String selectedAvatarPath = "assets/images/gamer1.png";
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              local.sign_up,
              style: const TextStyle(
                color: Appcolor.Mainyello,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              color: Appcolor.Mainyello,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AvatarCarouselSelector(
                    avatarImages: avatarList,
                    onAvatarSelected: (selectedPath) {
                      setState(() {
                        selectedAvatarPath = selectedPath;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Avatar",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: nameController,
                    hintText: local.enter_name,
                    logo: "assets/icons/icn_idef.svg",
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: emailController,
                    validator: (value) {
                      bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value ?? "");
                      if (value == null || value.isEmpty) {
                        return "Please enter email";
                      } else if (!emailValid) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    hintText: local.email,
                    logo: 'assets/icons/icn_mail.svg',
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Password";
                      } else if (value.length < 8) {
                        return "Password must be more than 8 characters";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    hintText: local.password,
                    logo: 'assets/icons/icn_lock.svg',
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Wrong Password";
                      } else if (value != passwordController.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    hintText: local.confirm_password,
                    logo: 'assets/icons/icn_lock.svg',
                    isPassword: true,
                  ),
                  const SizedBox(height: 24),
                  CustomTextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    hintText: local.phone_number,
                    logo: 'assets/icons/icn_call.svg',
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return Custombut(
                        text: local.sign_up,
                        isloading: state is RegisterLoading,
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            context.read<AuthCubit>().register(
                              name: nameController.text.trim(),
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 17),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        local.already_have_account,
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
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          " ${local.login}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Appcolor.Mainyello,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const LanguageSwitch(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}