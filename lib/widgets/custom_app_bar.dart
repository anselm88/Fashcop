import 'package:fashcop/variables/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

PreferredSize customAppbar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: AppBar(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      shape: const RoundedRectangleBorder(
          // borderRadius: BorderRadius.only(
          //     bottomLeft: Radius.circular(30),
          //     bottomRight: Radius.circular(30)),
          ),
      brightness: Brightness.light,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          //borderRadius: const BorderRadius.only(
          //bottomLeft: Radius.circular(30),
          //bottomRight: Radius.circular(30)),
          gradient: LinearGradient(
            colors: [
              Colors.white30,
              Colors.white,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
      title: const Text(
        "FaSHcoP",
        style: kHeadingStyle,
      ),
    ),
  );
}
