import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/models/favorite_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectCard extends StatefulWidget {
  final projectId;
  final projectImagePath;
  final projectName;
  final projectLocation;
  final briefDescription;
  final userImagePath;
  final userName;
  final numberOfLikes;
  final numberOfComments;
  final ownerID;
  final Function() onUserName;
  final Function() onProjectImage;
  final Function() onFullProject;
  final onLike;
  final onComment;

  ProjectCard(
      {required this.projectId,
      required this.userImagePath,
      required this.userName,
      required this.ownerID,
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

  // String userImagePath,
  //     userName,
  //     projectLocation,
  //     briefDescription,
  //     projectImagePath,
  //     projectName;
  // int numberOfLikes, numberOfComments;
  // Function() onUserName, onProjectImage, onLike, onComment, onFullProject;

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

    FirebaseFirestore.instance
        .collection('favorites')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('userFavorites')
        .doc(widget.projectId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        isFavorite = value.get("projectFavorite");
                      })
                    }
                }
            });

    return Card(
      margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 2.5, bottom: 2.5),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.50),
              child: ListTile(
                leading: widget.userImagePath == ""
                    ? const CircleAvatar(
                        radius: 20.0,
                        backgroundImage: AssetImage("assets/profile1.png"),
                      )
                    : CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(widget.userImagePath),
                      ),
                title: Text(
                  widget.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(widget.projectLocation),
                trailing: Icon(Icons.more_horiz),
                contentPadding: EdgeInsets.all(0),
                onTap: widget.onUserName,
              ),
            ),
            InkWell(
              onTap: widget.onFullProject,
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text("Title: ${widget.projectName}",
                        style: TextStyle(
                          fontSize: 18.0,
                        )),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Text("Brief Description: ${widget.briefDescription}",
                        style: TextStyle(
                          fontSize: 16.0,
                        )),
                  ),
                  widget.projectImagePath == null
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: widget.onProjectImage,
                          child: Container(
                            padding: EdgeInsets.all(0),
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.projectImagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
                            onPressed: () async {
                              setState(() {
                                isFavorite = !isFavorite;

                                if (isFavorite == true) {
                                  favoriteProvider.favorite(
                                      projectId: widget.projectId,
                                      projectImagePath: widget.projectImagePath,
                                      projectName: widget.projectName,
                                      projectLocation: widget.projectLocation,
                                      briefDescription: widget.briefDescription,
                                      userImagePath: widget.userImagePath,
                                      userName: widget.userName,
                                      projectFavorite: true,
                                      ownerId: widget.ownerID);
                                } else if (isFavorite == false) {
                                  FirebaseFirestore.instance
                                      .collection('favorites')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection('userFavorites')
                                      .doc(widget.projectId)
                                      .delete();
                                }

                                // Function logAnalyticsEvent(String id) {
                                //   FirebaseAnalytics().logEvent(
                                //     name: 'favorite',
                                //     parameters: {
                                //       'projectId': id,
                                //     },
                                //   );
                                // }
                              });

                              // await FirebaseAnalytics.instance.logSelectContent(
                              //   contentType: "image",
                              //   itemId: widget.projectId,
                              // );
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Color(0xff5ac18e),
                            ),
                          ),
                          Text(
                            ' Likes',
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
                            onPressed: widget.onComment,
                            icon: const Icon(Icons.comment_outlined,
                                color: Color(0xff5ac18e)),
                          ),
                          Text(
                            '${widget.numberOfComments} Comments',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black54),
                          ),
                        ],
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
