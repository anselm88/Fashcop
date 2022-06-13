import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fashcop/variables/constants.dart';
import 'package:flutter/services.dart';
import 'package:fashcop/widgets/text_input_field.dart';
import 'package:fashcop/widgets/password_field.dart';
import 'package:fashcop/widgets/login_button.dart';
import 'package:fashcop/screens/second_signup_screen.dart';

class FirstSignUpScreen extends StatefulWidget {
  static const String id = 'first_signup_screen';

  @override
  State<FirstSignUpScreen> createState() => _FirstSignUpScreen();
}

class _FirstSignUpScreen extends State<FirstSignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  String? checkFieldEmpty(String? fieldContent) =>
      fieldContent!.isEmpty ? 'Requires a value' : null;

  String? confirmPasswordValidator(String? confirmPasswordText) {
    if (confirmPasswordController == null ||
        confirmPasswordText!.trim().isEmpty) {
      return 'Reguires a value';
    }
    if (passwordControler.text != confirmPasswordText) {
      return "Passwords don't match";
    }
    return null;
  }

  final passwordControler = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final emailControler = TextEditingController();
  final phoneNumberControler = TextEditingController();

  var loading = false;

  Future signUp() async {
    setState(() {
      loading = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailControler.text, password: passwordControler.text);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: kBackgroundcolour,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 120,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: prefer_const_constructors
                        Text(
                          'Sign Up',
                          style: const TextStyle(
                              color: Color(0xff5ac18e),
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 30),

                        TextIputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.email,
                          textFieldName: 'Email',
                          hint: 'Email',
                          onchangeFunction: (value) {
                            print(value);
                          },
                          controller: emailControler,
                          inputType: TextInputType.emailAddress,
                          inputAction: TextInputAction.next,
                          style: KBlackTextFieldNameStyle,
                        ),
                        const SizedBox(height: 20),
                        TextIputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.phone,
                          textFieldName: 'Phone Number',
                          hint: 'Phone Number',
                          onchangeFunction: (value) {},
                          controller: phoneNumberControler,
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          style: KBlackTextFieldNameStyle,
                        ),

                        const SizedBox(height: 20),

                        PasswordField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.lock,
                          passwordFieldName: 'Password',
                          hint: 'Password',
                          onchangeFunction: (value) {
                            print(value);
                          },
                          controller: passwordControler,
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        PasswordField(
                          validateFunction: confirmPasswordValidator,
                          icon: Icons.lock,
                          passwordFieldName: 'Confirm Password',
                          hint: 'Confirm Password',
                          onchangeFunction: (value) {
                            print(value);
                          },
                          controller: confirmPasswordController,
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.done,
                        ),
                        SizedBox(height: 10),

                        LoginButton(
                            buttonName: 'NEXT',
                            onpress: () {
                              setState(() {
                                if (_formKey.currentState!.validate()) {
                                  signUp();
                                  Navigator.pushNamed(
                                      context, SecondSignUpScreen.id);
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
