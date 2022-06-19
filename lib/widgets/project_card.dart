import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  ProjectCard(
      {required this.userImagePath,
      required this.userName,
      required this.projectLocation,
      required this.briefDescription,
      required this.projectImagePath,
      required this.projectName,
      required this.numberOfLikes,
      required this.numberOfComments,
      required this.onUserName,
      required this.onProjectImage,
      required this.onComment,
      required this.onLike,
      required this.onFullProject});

  String userImagePath,
      userName,
      projectLocation,
      briefDescription,
      projectImagePath,
      projectName;
  int numberOfLikes, numberOfComments;
  Function() onUserName, onProjectImage, onLike, onComment, onFullProject;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 2.5, bottom: 2.5),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: userImagePath == ""
                    ? const CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage("assets/profile1.png"),
                      )
                    : CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(userImagePath),
                      ),
                title: Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(projectLocation),
                trailing: Icon(Icons.more_horiz),
                contentPadding: EdgeInsets.all(0),
                onTap: onUserName,
              ),
            ),
            InkWell(
              onTap: onFullProject,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(briefDescription),
                  ),
                  projectImagePath == ""
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: onProjectImage,
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(projectImagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(projectName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        )),
                  ),
                  const Divider(
                    color: Colors.black54,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: onLike,
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            '$numberOfLikes Likes',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: onComment,
                            icon: const Icon(Icons.comment_outlined,
                                color: Colors.black54),
                          ),
                          Text(
                            '$numberOfComments Comments',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black54),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: const Text('1 hour ago',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black54,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
