import 'package:fashcop/variables/constants.dart';
import 'package:flutter/material.dart';

class MultiLineTextInputField extends StatelessWidget {
  MultiLineTextInputField(
      {required this.icon,
      required this.textFieldName,
      required this.hint,
      required this.maxLines,
      required this.minLines,
      required this.height,
      required this.style,
      required this.validateFunction,
      required this.onchangeFunction,
      required this.inputType,
      required this.inputAction});

  final IconData icon;
  final String textFieldName;
  final String hint;
  final int maxLines;
  final int minLines;
  final double height;
  final TextStyle style;
  final String? Function(String?)? validateFunction;
  final ValueChanged<String> onchangeFunction;
  final TextInputType inputType;
  final TextInputAction inputAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          textFieldName,
          style: style,
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
          height: height,
          child: TextFormField(
            keyboardType: inputType,
            textInputAction: inputAction,
            minLines: minLines,
            maxLines: maxLines,
            //expands: true,
            style: const TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                icon,
                color: Color(0xff5ac18e),
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.black38,
                fontSize: 12.0,
              ),
            ),
            onChanged: onchangeFunction,
            validator: validateFunction,
          ),
        ),
      ],
    );
  }
}
