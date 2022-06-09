import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  LoginButton({required this.buttonName, required this.onpress});

  final String buttonName;
  final Function() onpress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        disabledColor: Color(0xff5ac18e),
        color: Color(0xff5ac18e),
        elevation: 5,
        onPressed: onpress,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
