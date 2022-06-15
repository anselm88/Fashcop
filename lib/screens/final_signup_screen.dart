import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/components/signup_data.dart';
import 'package:fashcop/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fashcop/variables/constants.dart';
import 'package:flutter/services.dart';
import 'package:fashcop/widgets/text_input_field.dart';
import 'package:fashcop/widgets/login_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fashcop/models/checkbox_state.dart';
import 'package:provider/provider.dart';

class FinalSignUpScreen extends StatefulWidget {
  static const String id = 'final_signup_screen';

  @override
  State<FinalSignUpScreen> createState() => _FinalSignUpScreen();
}

class _FinalSignUpScreen extends State<FinalSignUpScreen> {
  final _auth = FirebaseAuth.instance;
  final agroActivities = [
    CheckBoxState(title: "Cultivation and growing of crops"),
    CheckBoxState(title: "Rearing of livestock"),
    CheckBoxState(title: "Rearing of fish (fishery)"),
    CheckBoxState(title: "Salving of farm produce"),
    CheckBoxState(title: "Horticulture"),
    CheckBoxState(title: "Rearing of snail/Heliculture"),
    CheckBoxState(title: "Apiculture/bee keeping"),
  ];

  final _formKey = GlobalKey<FormState>();
  final List<String> selectedAgroActivities = [];

  Widget buildSingleCheckBox(CheckBoxState checkBoxState) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Color(0xff5ac18e),
      ),
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        value: checkBoxState.isChecked,
        checkColor: Colors.white,
        activeColor: Color(0xff5ac18e),
        title: Text(
          checkBoxState.title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        onChanged: (bool? Value) {
          setState(() {
            checkBoxState.isChecked = Value!;
            selectedAgroActivities.add(checkBoxState.title);
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
                          color: Color(0xff5ac18e),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      ...agroActivities.map(buildSingleCheckBox).toList(),

                      // ignore: prefer_const_constructors

                      Form(
                        key: _formKey,
                        child: LoginButton(
                            buttonName: 'FINISH',
                            onpress: () async {
                              _formKey.currentState!.save();
                              try {
                                setState(() {
                                  Provider.of<SignupFormData>(context,
                                          listen: false)
                                      .agroActivity = selectedAgroActivities;
                                });

                                UserCredential newUser =
                                    await _auth.createUserWithEmailAndPassword(
                                  email: Provider.of<SignupFormData>(context,
                                          listen: false)
                                      .email,
                                  password: Provider.of<SignupFormData>(context,
                                          listen: false)
                                      .password,
                                );
                                User? aUser = newUser.user;
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(aUser!.uid)
                                    .set({
                                  'userId': aUser.uid,
                                  'fullName': Provider.of<SignupFormData>(
                                          context,
                                          listen: false)
                                      .fullName,
                                  'userName': Provider.of<SignupFormData>(
                                          context,
                                          listen: false)
                                      .userName,
                                  'email': Provider.of<SignupFormData>(context,
                                          listen: false)
                                      .email,
                                  'dateofBirth': Provider.of<SignupFormData>(
                                          context,
                                          listen: false)
                                      .dateofBirth,
                                  'location': Provider.of<SignupFormData>(
                                          context,
                                          listen: false)
                                      .location,
                                  'phoneNumber': Provider.of<SignupFormData>(
                                          context,
                                          listen: false)
                                      .phoneNumber,
                                  'gender': Provider.of<SignupFormData>(context,
                                          listen: false)
                                      .gender,
                                  'profileImage': Provider.of<SignupFormData>(
                                          context,
                                          listen: false)
                                      .profileImage,
                                  'agroActivity': Provider.of<SignupFormData>(
                                          context,
                                          listen: false)
                                      .agroActivity,
                                });
                                Navigator.pushNamed(context, HomeScreen.id);
                              } on FirebaseAuthException catch (error) {
                                Fluttertoast.showToast(
                                    msg: error.message!,
                                    gravity: ToastGravity.TOP,
                                    backgroundColor: Colors.red);
                              }
                            }),
                      ),
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
