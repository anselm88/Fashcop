import 'package:flutter/material.dart';
import 'package:fashcop/variables/constants.dart';
import 'package:flutter/services.dart';
import 'package:fashcop/widgets/text_input_field.dart';
import 'package:fashcop/widgets/login_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fashcop/models/checkbox_state.dart';

class FinalSignUpScreen extends StatefulWidget {
  static const String id = 'final_signup_screen';

  @override
  State<FinalSignUpScreen> createState() => _FinalSignUpScreen();
}

class _FinalSignUpScreen extends State<FinalSignUpScreen> {
  bool isRememberMe = false;

  final agroActivities = [
    CheckBoxState(title: "Cultivation and growing of crops"),
    CheckBoxState(title: "Rearing of livestock"),
    CheckBoxState(title: "Rearing of fish (fishery)"),
    CheckBoxState(title: "Salving of farm produce"),
    CheckBoxState(title: "Horticulture"),
    CheckBoxState(title: "Rearing of snail/Heliculture"),
    CheckBoxState(title: "Apiculture/bee keeping"),
  ];

  Widget buildSingleCheckBox(CheckBoxState checkBoxState) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.white),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: checkBoxState.isChecked,
        checkColor: Colors.green,
        activeColor: Colors.white,
        title: Text(
          checkBoxState.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onChanged: (bool? Value) {
          setState(() {
            checkBoxState.isChecked = Value!;
          });
        },
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
                      const Text(
                        "Choose Agro Activities",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      ...agroActivities.map(buildSingleCheckBox).toList(),

                      // ignore: prefer_const_constructors

                      LoginButton(
                          buttonName: 'FINISH',
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
