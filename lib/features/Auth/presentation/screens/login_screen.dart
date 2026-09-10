import 'package:flutter/material.dart';
import 'package:moives_app2/features/Auth/presentation/screens/register_screen.dart';

import '../../../../core/theme/appcolor.dart';
import '../../../../core/widgets/Custom_text_field.dart';
import '../../../../core/widgets/custombut.dart';
import '../../../../core/widgets/seletion_item.dart';

class LoginScreen extends StatelessWidget {
 LoginScreen({super.key});
  GlobalKey<FormState>  formkey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Appcolor.black,
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(height: 67),

              Center(
                child: Image.asset(
                  "assets/images/logo_login.png",
                  width: 121,
                  height: 118,
                ),
              ),

              SizedBox(height: 67),

              CustomTextField(
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

              SizedBox(height: 33),

              CustomTextField(
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
              SizedBox(height: 17.18),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password ?",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Appcolor.Mainyello,
                  ),
                ),
              ),
              SizedBox(height: 33.28),
              Custombut(text: 'Login', onPressed: (){
                if(formkey.currentState!.validate()){
                  print("login");
                }


              },),
              SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen(),));
                    },
                    child: Text(
                      " Sign Up",
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
              SizedBox(height: 27),
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
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "OR",
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
              SizedBox(height: 27),

              Custombut(text: 'Login with Google',logo: "assets/icons/icn_google.svg",),
              SizedBox(height: 14),

              LanguageSwitch(),
            ],
          ),
        ),
      ),
    );
  }
}
