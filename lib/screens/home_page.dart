import 'package:fashcop/widgets/project_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ProjectCard(
            userName: 'John Doe',
            projectLocation: 'NorthWest, Bamenda',
            userImagePath: 'assets/profile1.png',
            briefDescription: 'This project is all about....',
            projectImagePath: 'assets/corn.jpg',
            userEmail: 'johndoe@email.com',
            projectName: 'Corn Productions',
            numberOfLikes: 0,
            numberOfComments: 0,
            onUserName: () {},
            onProjectImage: () {},
            onLike: () {},
            onComment: () {},
          );
        },
      ),
    );
  }
}
