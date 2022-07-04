// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:fashcop/screens/home_screen.dart';
import 'package:fashcop/screens/splash_screen.dart';
import 'package:fashcop/variables/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fashcop/widgets/text_input_field.dart';
import 'package:fashcop/widgets/password_field.dart';
import 'package:fashcop/widgets/login_button.dart';
import 'package:fashcop/screens/first_signup_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  late String email, password;

  bool isRememberMe = false;

  final _formKey = GlobalKey<FormState>();

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          print('Forgot Password Pressed');
        },
        padding: const EdgeInsets.only(right: 0),
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget buildRememberMe() {
    return Container(
      height: 20,
      child: Row(
        children: [
          Theme(
            data: ThemeData(unselectedWidgetColor: Color(0xff5ac18e)),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.white,
              activeColor: Color(0xff5ac18e),
              onChanged: (bool? Value) {
                setState(() {
                  isRememberMe = Value!;
                });
              },
            ),
          ),
          const Text(
            'Remember me',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, FirstSignUpScreen.id),
      child: RichText(
        text: const TextSpan(children: [
          TextSpan(
              text: 'Don\'t have an Account?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  String? checkFieldEmpty(String? fieldContent) =>
      fieldContent!.isEmpty ? "Require's an input" : null;

  final passwordControler = TextEditingController();
  final emailcontroler = TextEditingController();

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
                          'Log In',
                          style: const TextStyle(
                              color: Color(0xff5ac18e),
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 50),

                        TextIputField(
                          icon: Icons.email,
                          textFieldName: 'Email',
                          hint: 'Email',
                          onchangeFunction: (value) {
                            email = value;
                          },
                          controller: emailcontroler,
                          validateFunction: checkFieldEmpty,
                          inputType: TextInputType.emailAddress,
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
                              password = value;
                            },
                            controller: passwordControler,
                            inputType: TextInputType.name,
                            inputAction: TextInputAction.next),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildRememberMe(),
                            //buildForgotPassBtn(),
                          ],
                        ),

                        LoginButton(
                            buttonName: 'LOGIN',
                            onpress: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  final loggedInUser =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email, password: password);

                                  Navigator.pushNamed(
                                      context, SplashScreen.splashSCreenId);
                                } on FirebaseAuthException catch (error) {
                                  Fluttertoast.showToast(
                                      msg: error.message!,
                                      gravity: ToastGravity.TOP,
                                      backgroundColor: Colors.red);
                                }

                                // TODO submit
                              }
                            }),
                        buildSignUpBtn(),
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
