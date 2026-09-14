import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/Auth/presentation/screens/login_screen.dart';
import '../../../../core/theme/appcolor.dart';
import '../../../../core/widgets/Custom_text_field.dart';
import '../../../../core/widgets/avatar.dart';
import '../../../../core/widgets/custombut.dart';
import '../../../../core/widgets/seletion_item.dart';
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
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
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
          title: const Text(
            "Register",
            style: TextStyle(
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
                SizedBox(height: 12),
                Text(
                  "Avatar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 12),
                CustomTextField(
                  hintText: "Enter Name",
                  logo: "assets/icons/icn_idef.svg",
                  keyboardType: TextInputType.name,
                ),
                SizedBox(height: 24),
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
                  hintText: 'Email',
                  logo: 'assets/icons/icn_mail.svg',
                ),
                SizedBox(height: 24),
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
                  hintText: 'Password',
                  logo: 'assets/icons/icn_lock.svg',
                  isPassword: true,
                ),
                SizedBox(height: 24),
                CustomTextField(
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Wrong Password";
                    } else if (value != passwordController.text) {
                      return "Password does not match";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Confirm Password',
                  logo: 'assets/icons/icn_lock.svg',
                  isPassword: true,
                ),
                SizedBox(height: 24),
                CustomTextField(
                  keyboardType: TextInputType.number,
                  hintText: 'Phone number',
                  logo: 'assets/icons/icn_call.svg',
                ),
                SizedBox(height: 24),
                Custombut(
                  text: 'Create Account',
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      context.read<AuthCubit>().register(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                    }
                  },
                ),
                SizedBox(height: 17),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already Have Account ?",
                      style: TextStyle(
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
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        " Login",
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
                SizedBox(height: 18),
                LanguageSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
