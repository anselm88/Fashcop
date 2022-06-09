import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  ProjectCard(
      {required this.userImagePath,
      required this.userName,
      required this.projectLocation,
      required this.briefDescription,
      required this.projectImagePath,
      required this.userEmail,
      required this.projectName,
      required this.numberOfLikes,
      required this.numberOfComments,
      required this.onUserName,
      required this.onProjectImage,
      required this.onComment,
      required this.onLike});

  String userImagePath,
      userName,
      projectLocation,
      briefDescription,
      projectImagePath,
      userEmail,
      projectName;
  int numberOfLikes, numberOfComments;
  Function() onUserName, onProjectImage, onLike, onComment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage(userImagePath),
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
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(briefDescription),
            ),
            GestureDetector(
              onTap: onProjectImage,
              child: Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(projectImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Text(userEmail),
            ),
            Container(
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
                      style: TextStyle(fontSize: 16.0, color: Colors.black54),
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
      ),
    );
  }
}
