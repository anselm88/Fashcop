import 'package:flutter/material.dart';
import 'package:fashcop/variables/constants.dart';
import 'package:flutter/services.dart';
import 'package:fashcop/widgets/text_input_field.dart';
import 'package:fashcop/widgets/login_button.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fashcop/screens/final_signup_screen.dart';

class SecondSignUpScreen extends StatefulWidget {
  static const String id = 'second_signup_screen';

  @override
  State<SecondSignUpScreen> createState() => _SecondSignUpScreen();
}

class _SecondSignUpScreen extends State<SecondSignUpScreen> {
  File? _imageFile;
  final _picker = ImagePicker();

  List gender = ["Male", "Female", "Other"];

  String? select;

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          fillColor: MaterialStateProperty.all<Color?>(Color(0xff5ac18e)),
          value: gender[btnValue],
          groupValue: select,
          onChanged: (dynamic value) {
            setState(() {
              print(value);
              select = value;
            });
          },
        ),
        Text(title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: this._imageFile == null
                ? const AssetImage("assets/profile1.png") as ImageProvider
                : FileImage(this._imageFile!),
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomSheet()));
              },
              child: const Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Column(children: <Widget>[
        const Text(
          "Choose Profile Picture",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              onPressed: () {
                _takePhotoFromCamera();
              },
              icon: Icon(Icons.camera),
              label: Text("Camera"),
            ),
            FlatButton.icon(
              onPressed: () {
                _takePhotoFromGallery();
              },
              icon: Icon(Icons.image),
              label: Text("Gallery"),
            ),
          ],
        )
      ]),
    );
  }

  Future<void> _takePhotoFromCamera() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.camera);
    setState(() => this._imageFile = File(pickedFile!.path));
  }

  Future<void> _takePhotoFromGallery() async {
    final PickedFile? pickedFile =
        await _picker.getImage(source: ImageSource.gallery);
    setState(() => this._imageFile = File(pickedFile!.path));
  }

  final _formKey = GlobalKey<FormState>();
  final fullNamecontroller = TextEditingController();
  final userNamecontroller = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final locationController = TextEditingController();

  String? checkFieldEmpty(String? fieldContent) =>
      fieldContent!.isEmpty ? "Require's an Input" : null;

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ignore: prefer_const_constructors
                        imageProfile(),
                        const SizedBox(height: 20),

                        TextIputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.person,
                          textFieldName: 'Full Name',
                          hint: 'Full Name',
                          onchangeFunction: (value) {},
                          controller: fullNamecontroller,
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.next,
                          style: KBlackTextFieldNameStyle,
                        ),
                        const SizedBox(height: 10),
                        TextIputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.person,
                          textFieldName: 'User Name',
                          hint: 'User Name',
                          onchangeFunction: (value) {},
                          controller: userNamecontroller,
                          inputType: TextInputType.name,
                          inputAction: TextInputAction.next,
                          style: KBlackTextFieldNameStyle,
                        ),
                        const SizedBox(height: 10),
                        TextIputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.calendar_month,
                          textFieldName: 'Date of Birth',
                          hint: 'Date of Birth',
                          onchangeFunction: (value) {},
                          controller: dateOfBirthController,
                          inputType: TextInputType.datetime,
                          inputAction: TextInputAction.next,
                          style: KBlackTextFieldNameStyle,
                        ),
                        const SizedBox(height: 10),

                        TextIputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.location_city,
                          textFieldName: 'Location',
                          hint: 'Region/Town',
                          onchangeFunction: (value) {},
                          controller: locationController,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.done,
                          style: KBlackTextFieldNameStyle,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Gender',
                          style: TextStyle(
                            color: Colors.black,
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

                        const SizedBox(height: 10),

                        LoginButton(
                            buttonName: 'NEXT',
                            onpress: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(
                                    context, FinalSignUpScreen.id);
                              }
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
