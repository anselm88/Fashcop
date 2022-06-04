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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: prefer_const_constructors
                      Text(
                        'Sign Up',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 30),

                      TextIputField(
                        icon: Icons.email,
                        textFieldName: 'Email',
                        hint: 'Email',
                        onchangeFunction: (value) {},
                        inputType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      TextIputField(
                        icon: Icons.phone,
                        textFieldName: 'Phone Number',
                        hint: 'Phone Number',
                        onchangeFunction: (value) {},
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                      ),

                      const SizedBox(height: 20),

                      PasswordField(
                        icon: Icons.lock,
                        passwordFieldName: 'Password',
                        hint: 'Password',
                        onchangeFunction: (value) {
                          print(value);
                        },
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      PasswordField(
                        icon: Icons.lock,
                        passwordFieldName: 'Confirm Password',
                        hint: 'Confirm Password',
                        onchangeFunction: (value) {
                          print(value);
                        },
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 10),

                      LoginButton(
                          buttonName: 'NEXT',
                          onpress: () {
                            setState(() {
                              Navigator.pushNamed(
                                  context, SecondSignUpScreen.id);
                            });
                          }),
                    ],
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
