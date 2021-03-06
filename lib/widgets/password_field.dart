import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  PasswordField(
      {required this.icon,
      required this.passwordFieldName,
      required this.hint,
      required this.validateFunction,
      required this.onchangeFunction,
      required this.controller,
      required this.inputType,
      required this.inputAction});
  final IconData icon;
  final String passwordFieldName;
  final String hint;
  final String? Function(String?)? validateFunction;
  final ValueChanged<String> onchangeFunction;
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          passwordFieldName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 50,
          child: TextFormField(
            keyboardType: inputType,
            textInputAction: inputAction,
            obscureText: true,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Color(0xff5ac18e),
                ),
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.black38,
                )),
            onChanged: onchangeFunction,
            validator: validateFunction,
            controller: controller,
          ),
        ),
      ],
    );
  }
}
