import 'dart:io';

import 'package:flutter/cupertino.dart';

class SignupFormData extends ChangeNotifier {
  String? fullName,
      userName,
      dateofBirth,
      location,
      gender,
      phoneNumber,
      profileImageURL,
      accountType;
  List<String> agroActivity = [];
  late String email, password;
}
