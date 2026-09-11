import 'package:flutter/material.dart';

import '../../../../core/theme/appcolor.dart';
import '../../../../core/widgets/Custom_text_field.dart';
import '../../../../core/widgets/custombut.dart';

class ForgetScreen extends StatelessWidget {
 ForgetScreen({super.key});
  GlobalKey<FormState>  formkey= GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
        key:formkey ,
        child: Column(
          children: [
            Image.asset("assets/images/Forgotpassword.png"),
            SizedBox(height: 24,),
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
            SizedBox(height: 10,),
            Custombut(text: 'Verify Email', onPressed: (){
              if(formkey.currentState!.validate()){
                print("login");
              }


            },),

          ],
        ),
      ),
    );
  }
}
