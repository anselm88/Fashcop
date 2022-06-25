import 'package:flutter/material.dart';

class RecomendedProjects extends StatefulWidget {
  const RecomendedProjects({Key? key}) : super(key: key);

  @override
  State<RecomendedProjects> createState() => _RecomendedProjectsState();
}

class _RecomendedProjectsState extends State<RecomendedProjects> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Recommended Projects"),
    );
  }
}
