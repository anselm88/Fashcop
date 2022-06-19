import 'package:fashcop/screens/single_project_screen.dart';
import 'package:fashcop/widgets/project_card.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage('assets/profile1.png'),
                        ),
                        SizedBox(width: 40),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'johndoe',
                                style: TextStyle(
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(height: 10),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size(0, 30),
                                  side: BorderSide(
                                    color: Colors.grey[400]!,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    const Text('John Doe',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text("Northwest, Bamenda",
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                    const Text('JohnDoe@gmail.com',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                    const Text('6764181838',
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Container(
                child: ProjectCard(
              userName: 'John Doe',
              projectLocation: 'NorthWest, Bamenda',
              userImagePath: 'assets/profile1.png',
              briefDescription: 'This project is all about....',
              projectImagePath: 'assets/corn.jpg',
              //userEmail: 'johndoe@email.com',
              projectName: 'Corn Production',
              numberOfLikes: 0,
              numberOfComments: 0,
              onFullProject: () {
                Navigator.pushNamed(context, SingleProjectScreen.id);
              },
              onUserName: () {},
              onProjectImage: () {},
              onLike: () {},
              onComment: () {},
            )),
          ],
        ),
      ),
    );
  }
}
