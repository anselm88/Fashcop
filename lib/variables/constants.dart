import 'package:flutter/material.dart';

const kBackgroundcolour = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0x665ac18e),
        Color(0x995ac18e),
        Color(0xcc5ac18e),
        Color(0xff5ac18e),
      ]),
);

const KLoginTextFieldNameStyle = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const kAddProjectTextFieldNameStyle = TextStyle(
  color: Color(0xff5ac18e),
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

const kHeadingStyle = TextStyle(
  color: Color(0xff5ac18e),
  fontSize: 30,
  fontWeight: FontWeight.w700,
);

const kTextBoxShadow = [
  BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
];

List sectorList = [
  "Cultivation and growing of crops",
  "Rearing of livestock",
  "Rearing of fish (fishery)",
  "Salving of farm produce",
  "Horticulture",
  "Rearing of snail/Heliculture",
  "Apiculture/bee keeping"
];

List timeframeList = [
  "Less than 3 Months",
  "Less than 6 Months",
  "Less than 1 Year",
  "More than 1 Year"
];
