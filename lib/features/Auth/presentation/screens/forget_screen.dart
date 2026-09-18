import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/appcolor.dart';
import '../../../../core/widgets/Custom_text_field.dart';
import '../../../../core/widgets/custombut.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reset email sent successfully')),
          );
        }

        if (state is ForgotPasswordError) {
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
            "Forget Password",
            style: TextStyle(
              color: Appcolor.Mainyello,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            color: Appcolor.Mainyello,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Form(
          key: formkey,
          child: Column(
            children: [
              Image.asset("assets/images/Forgotpassword.png"),

              const SizedBox(height: 24),

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

              const SizedBox(height: 10),

              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Custombut(
                    text: 'Verify Email',
                    isloading: state is ForgotPasswordLoading,
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        context.read<AuthCubit>().forgotPassword(
                          email: emailController.text.trim(),
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
