import 'package:flutter/material.dart';
import 'package:fashcop/variables/constants.dart';
import 'package:flutter/services.dart';
import 'package:fashcop/widgets/text_input_field.dart';
import 'package:fashcop/widgets/password_field.dart';
import 'package:fashcop/widgets/login_button.dart';

class SecondSignUpScreen extends StatefulWidget {
  static const String id = 'second_signup_screen';

  @override
  State<SecondSignUpScreen> createState() => _SecondSignUpScreen();
}

class _SecondSignUpScreen extends State<SecondSignUpScreen> {
  List gender = ["Male", "Female", "Other"];

  String? select;

  get fillColor => null;

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          fillColor:
              MaterialStateProperty.all<Color?>(Color.fromARGB(97, 0, 0, 0)),
          value: gender[btnValue],
          groupValue: select,
          onChanged: (dynamic? value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: const [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage("assets/profile.png"),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: Icon(
              Icons.camera_alt,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
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
                    vertical: 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ignore: prefer_const_constructors
                      imageProfile(),
                      const SizedBox(height: 30),

                      TextIputField(
                        icon: Icons.person,
                        textFieldName: 'Full Name',
                        hint: 'Full Name',
                        onchangeFunction: (value) {},
                        inputType: TextInputType.name,
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),
                      TextIputField(
                        icon: Icons.calendar_month,
                        textFieldName: 'Date of Birth',
                        hint: 'Date of Birth',
                        onchangeFunction: (value) {},
                        inputType: TextInputType.datetime,
                        inputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 20),

                      const Text(
                        'Gender',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Row(
                        children: <Widget>[
                          addRadioButton(0, 'Male'),
                          addRadioButton(1, 'Female'),
                          addRadioButton(2, 'Others'),
                        ],
                      ),

                      const SizedBox(height: 20),

                      LoginButton(
                          buttonName: 'NEXT',
                          onpress: () {
                            print('login pressed');
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
