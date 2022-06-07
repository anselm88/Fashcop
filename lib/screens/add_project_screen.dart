import 'package:fashcop/variables/constants.dart';
import 'package:fashcop/widgets/login_button.dart';
import 'package:fashcop/widgets/multi_line_text_input_field.dart';
import 'package:fashcop/widgets/text_input_field.dart';
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
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

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
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              icon: Icon(Icons.camera),
              label: Text("Camera"),
            ),
            FlatButton.icon(
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              icon: Icon(Icons.image),
              label: Text("Gallery"),
            ),
          ],
        )
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  dynamic dropdownOneValue = sectorList[0];
  dynamic dropdownTwoValue = timeframeList[0];

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ignore: prefer_const_constructors
                      const Text(
                        "Add A Project",
                        style: kAddProjectTextFieldNameStyle,
                      ),
                      const SizedBox(height: 20),

                      TextIputField(
                        icon: Icons.location_city,
                        textFieldName: 'Location of Project',
                        hint: 'Region/Town',
                        onchangeFunction: (value) {},
                        inputType: TextInputType.text,
                        inputAction: TextInputAction.done,
                        style: kAddProjectTextFieldNameStyle,
                      ),
                      const SizedBox(height: 10),
                      TextIputField(
                        icon: Icons.money,
                        textFieldName: 'Budget Rnage',
                        hint: 'Enter the budget range. e.g 50000-100000FCFA',
                        onchangeFunction: (value) {},
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        style: kAddProjectTextFieldNameStyle,
                      ),

                      const SizedBox(height: 10),
                      TextIputField(
                        icon: Icons.money,
                        textFieldName: 'Estimated Profits',
                        hint: 'How much can you return as profits?',
                        onchangeFunction: (value) {},
                        inputType: TextInputType.number,
                        inputAction: TextInputAction.next,
                        style: kAddProjectTextFieldNameStyle,
                      ),
                      const SizedBox(height: 10),

                      dropdownButton(sectorList, "Agro sector", "Select Sector",
                          dropdownOneValue, (newValue) {
                        setState(() {
                          dropdownOneValue = newValue;
                          print(dropdownOneValue);
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
                          print(dropdownTwoValue);
                        });
                      }),

                      const SizedBox(height: 10),
                      MultiLineTextInputField(
                        icon: Icons.description,
                        textFieldName: "Brief Description",
                        hint: "Enter Brief Project Description",
                        maxLines: 2,
                        minLines: 1,
                        height: 100.00,
                        style: kAddProjectTextFieldNameStyle,
                        onchangeFunction: (value) {},
                        inputType: TextInputType.multiline,
                        inputAction: TextInputAction.newline,
                      ),
                      const SizedBox(height: 10),
                      MultiLineTextInputField(
                        icon: Icons.description,
                        textFieldName: "Detailed Description",
                        hint: "Enter Detailed Project Description",
                        maxLines: 500,
                        minLines: 1,
                        height: 200.00,
                        style: kAddProjectTextFieldNameStyle,
                        onchangeFunction: (value) {},
                        inputType: TextInputType.multiline,
                        inputAction: TextInputAction.newline,
                      ),
                      const SizedBox(height: 20),

                      InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()));
                          },
                          child: const Center(
                            child: Text(
                              'Add Project Image',
                              style: kAddProjectTextFieldNameStyle,
                            ),
                          )),

                      const SizedBox(height: 10),

                      LoginButton(buttonName: 'SUBMIT', onpress: () {}),
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
