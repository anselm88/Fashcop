import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/models/add_project_map.dart';
import 'package:fashcop/variables/constants.dart';
import 'package:fashcop/widgets/login_button.dart';
import 'package:fashcop/widgets/multi_line_text_input_field.dart';
import 'package:fashcop/widgets/text_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  File? _imageFile;
  final _picker = ImagePicker();

  FirebaseStorage storage = FirebaseStorage.instance;
  late String projectImageUrl;

  AddProjectMap _addProjectMap = AddProjectMap();

  final FirebaseAuth auth = FirebaseAuth.instance;

  void getCurrentUser() {
    final User user = auth.currentUser!;
    final uid = user.uid;
    // here you write the codes to input the data into firestore
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
          "Choose Project Picture",
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
              onPressed: () async {
                _takePhotoFromCamera();
              },
              icon: Icon(Icons.camera),
              label: Text("Camera"),
            ),
            FlatButton.icon(
              onPressed: () async {
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

  dynamic dropdownOneValue = sectorList[0];
  dynamic dropdownTwoValue = timeframeList[0];

  final _formKey = GlobalKey<FormState>();

  final projectNameController = TextEditingController();
  final projectLocationController = TextEditingController();
  final budjetrangeController = TextEditingController();
  final estimatedProfitController = TextEditingController();
  final briefDescriptionController = TextEditingController();
  final descriptionController = TextEditingController();

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
                        // const Text(
                        //   "Add A Project",
                        //   style: kAddProjectTextFieldNameStyle,
                        // ),
                        // const SizedBox(height: 20),
                        TextIputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.location_city,
                          textFieldName: 'Project Name',
                          hint: 'Whats the name of your project?',
                          onchangeFunction: (value) {
                            _addProjectMap.projectName = value;
                          },
                          controller: projectNameController,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.done,
                          style: kAddProjectTextFieldNameStyle,
                        ),
                        const SizedBox(height: 10),

                        TextIputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.location_city,
                          textFieldName: 'Location of Project',
                          hint: 'Region/Town',
                          onchangeFunction: (value) {
                            _addProjectMap.projectLocation = value;
                          },
                          controller: projectLocationController,
                          inputType: TextInputType.text,
                          inputAction: TextInputAction.done,
                          style: kAddProjectTextFieldNameStyle,
                        ),
                        const SizedBox(height: 10),
                        TextIputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.money,
                          textFieldName: 'Budget Rnage',
                          hint: 'Enter the budget range. e.g 50000-100000FCFA',
                          onchangeFunction: (value) {
                            _addProjectMap.budgetRange = value;
                          },
                          controller: budjetrangeController,
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          style: kAddProjectTextFieldNameStyle,
                        ),

                        const SizedBox(height: 10),
                        TextIputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.money,
                          textFieldName: 'Estimated Profits',
                          hint: 'How much can you return as profits?',
                          onchangeFunction: (value) {
                            _addProjectMap.estimatedProfit = value;
                          },
                          controller: estimatedProfitController,
                          inputType: TextInputType.number,
                          inputAction: TextInputAction.next,
                          style: kAddProjectTextFieldNameStyle,
                        ),
                        const SizedBox(height: 10),

                        dropdownButton(sectorList, "Agro sector",
                            "Select Sector", dropdownOneValue, (newValue) {
                          setState(() {
                            dropdownOneValue = newValue;

                            _addProjectMap.agroSector = dropdownOneValue;
                          });
                        }),

                        const SizedBox(height: 10),
                        dropdownButton(
                            timeframeList,
                            "Time Frame",
                            "How long can you take to realise this project",
                            dropdownTwoValue, (newValue) {
                          setState(() {
                            dropdownTwoValue = newValue;
                            _addProjectMap.timeFrame = dropdownTwoValue;
                          });
                        }),

                        const SizedBox(height: 10),
                        MultiLineTextInputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.description,
                          textFieldName: "Brief Description",
                          hint: "Enter Brief Project Description",
                          maxLines: 2,
                          minLines: 1,
                          height: 50.00,
                          style: kAddProjectTextFieldNameStyle,
                          onchangeFunction: (value) {
                            _addProjectMap.briefDescription = value;
                          },
                          controller: briefDescriptionController,
                          inputType: TextInputType.multiline,
                          inputAction: TextInputAction.newline,
                        ),
                        const SizedBox(height: 10),
                        MultiLineTextInputField(
                          validateFunction: checkFieldEmpty,
                          icon: Icons.description,
                          textFieldName: "Detailed Description",
                          hint: "Enter Detailed Project Description",
                          maxLines: 500,
                          minLines: 1,
                          height: 50.00,
                          style: kAddProjectTextFieldNameStyle,
                          onchangeFunction: (value) {
                            _addProjectMap.detailedDescription = value;
                          },
                          controller: descriptionController,
                          inputType: TextInputType.multiline,
                          inputAction: TextInputAction.newline,
                        ),
                        const SizedBox(height: 20),

                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()));
                            },
                            child: const Text(
                              'Add Project Image',
                              style: kAddProjectTextFieldNameStyle,
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        if (this._imageFile == null)
                          const SizedBox(
                            height: 0,
                          )
                        else
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: FileImage(this._imageFile!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                        LoginButton(
                            buttonName: 'SUBMIT',
                            onpress: () async {
                              final User user = auth.currentUser!;
                              _addProjectMap.userID = user.uid;

                              Reference ref = storage.ref().child(
                                  "projectImage/" + DateTime.now().toString());
                              UploadTask uploadTask = ref.putFile(_imageFile!);
                              uploadTask.whenComplete(() async {
                                projectImageUrl = await ref.getDownloadURL();
                                print(projectImageUrl);
                              }).catchError((onError) {
                                print(onError);
                              });
                              _addProjectMap.projectImageURL = projectImageUrl;
                              _addProjectMap.createdTime = DateTime.now();

                              try {
                                await FirebaseFirestore.instance
                                    .collection('projectsMap')
                                    .add(_addProjectMap.toJson());
                              } catch (e) {
                                print(e);
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

  Column dropdownButton(List<dynamic> listItem, String name, String hint,
      String valueChoose, ValueChanged onchangeFunction) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: kAddProjectTextFieldNameStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: kTextBoxShadow,
          ),
          height: 50,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButton(
              underline: SizedBox(),
              hint: Text(
                hint,
                style: TextStyle(color: Colors.black38),
              ),
              isExpanded: true,
              value: valueChoose,
              items: listItem.map((valueItem) {
                return DropdownMenuItem(
                  child: Text(valueItem),
                  value: valueItem,
                );
              }).toList(),
              onChanged: onchangeFunction,
            ),
          ),
        ),
      ],
    );
  }
}
