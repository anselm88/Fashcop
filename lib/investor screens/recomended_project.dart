import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/screens/another_users_profile.dart';
import 'package:fashcop/screens/home_page.dart';
import 'package:fashcop/screens/single_project_screen.dart';
import 'package:fashcop/widgets/project_card.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecomendedProjects extends StatefulWidget {
  const RecomendedProjects({Key? key}) : super(key: key);

  @override
  State<RecomendedProjects> createState() => _RecomendedProjectsState();
}

class _RecomendedProjectsState extends State<RecomendedProjects> {
  Stream<DocumentSnapshot> currentLoginUser = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  Stream<QuerySnapshot> projectRef(String agroSector) =>
      FirebaseFirestore.instance
          .collection('projectsMap')
          .where('agroSector', isEqualTo: agroSector)
          .limit(1)
          .snapshots();

  Stream<DocumentSnapshot> userRef(String userID) => FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      // .where('userID', isEqualTo: userID)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: currentLoginUser,
            builder: (BuildContext context, userSnapshot) {
              if (userSnapshot.hasError) {
                return Text('Something went wrong');
              }
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading');
              }
              Map<String, dynamic> currentUserData =
                  userSnapshot.data!.data()! as Map<String, dynamic>;

              List agroActivity = currentUserData['agroActivity'] as List;
              print('user interest' + agroActivity.toString());
              return Column(
                children: [
                  for (var agroSector in agroActivity)
                    StreamBuilder<QuerySnapshot>(
                      stream: projectRef(agroSector),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> refSnapshot) {
                        if (refSnapshot.hasError) {
                          return Text('Something went wrong');
                        }
                        if (refSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text('Loading');
                        }
                        List<DocumentSnapshot> projectsList =
                            refSnapshot.data!.docs;
                        if (projectsList.isEmpty) {
                          return Container();
                        }
                        Map<String, dynamic> projectData =
                            projectsList[0].data()! as Map<String, dynamic>;
                        debugPrint("Item in the list: " +
                            projectsList.length.toString());
                        // return Text("identified project:   " +
                        //     projectData["projectName"]);
                        return StreamBuilder<DocumentSnapshot>(
                          stream: userRef(projectData['userID']),
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                            if (userSnapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (userSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            Map<String, dynamic> userData = userSnapshot.data!
                                .data() as Map<String, dynamic>;

                            print('aggro sector' + projectData['agroSector']);
                            return ProjectCard(
                              userName: userData['fullName'],
                              projectLocation: projectData['projectLocation'],
                              userImagePath: userData['profileImage'] ?? "",
                              briefDescription: projectData['briefDescription'],
                              projectImagePath:
                                  projectData['projectImageURL'] ?? "",
                              //userEmail: 'johndoe@email.com',
                              projectName: projectData['projectName'],
                              numberOfLikes: 0,
                              numberOfComments: 0,
                              onFullProject: () {
                                Navigator.pushNamed(
                                    context, SingleProjectScreen.id,
                                    arguments: ProductArguments(
                                        projectsList[0].id,
                                        projectData['userID']));
                              },
                              onUserName: () {
                                Navigator.pushNamed(
                                    context, AnotherUsersProfile.id,
                                    arguments: ProjectOwnerArguments(
                                        projectData['userID']));
                              },

                              onProjectImage: () {},
                              onLike: () {},
                              onComment: () async {
                                await FirebaseAnalytics.instance.logEvent(
                                  name: "Investor_Liked_post",
                                  parameters: {
                                    "projectID": projectsList[0].id,
                                    "projectTite": projectData['projectName'],
                                  },
                                );
                              },
                              projectId: projectsList[0].id,
                              ownerID: projectData['userID'],
                            );

                            // Text(
                            //     "Project Name:  posted By: ${userData['fullName']}");
                          },
                        );
                      },
                    ),
                ],
              );
              // return StreamBuilder<QuerySnapshot>(
              //   stream: projectRef,
              //   builder: (BuildContext context,
              //       AsyncSnapshot<QuerySnapshot> snapshot) {
              //     if (snapshot.hasError) {
              //       return Text('Something went wrong');
              //     }

              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return Text("Loading");
              //     }
              //     debugPrint(snapshot.data!.docs.length.toString());
              //     List<DocumentSnapshot> projectsList = snapshot.data!.docs;

              //     return ListView.builder(
              //       itemCount: projectsList.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         Map<String, dynamic> projectData =
              //             projectsList[index].data()! as Map<String, dynamic>;
              //         return StreamBuilder<DocumentSnapshot>(
              //             stream: userRef(projectData['userID']),
              //             builder: (BuildContext context,
              //                 AsyncSnapshot<DocumentSnapshot> userSnapshot) {
              //               if (userSnapshot.hasError) {
              //                 return Text('Something went wrong');
              //               }

              //               if (userSnapshot.connectionState ==
              //                   ConnectionState.waiting) {
              //                 return Text("Loading");
              //               }
              //               Map<String, dynamic> userData =
              //                   userSnapshot.data!.data() as Map<String, dynamic>;

              //               print('aggro sector' + projectData['agroSector']);
              //               return ProjectCard(
              //                 userName: userData['fullName'],
              //                 projectLocation: projectData['projectLocation'],
              //                 userImagePath: userData['profileImage'] ?? "",
              //                 briefDescription: projectData['briefDescription'],
              //                 projectImagePath:
              //                     projectData['projectImageURL'] ?? "",
              //                 //userEmail: 'johndoe@email.com',
              //                 projectName: projectData['projectName'],
              //                 numberOfLikes: 0,
              //                 numberOfComments: 0,
              //                 onFullProject: () {
              //                   Navigator.pushNamed(
              //                       context, SingleProjectScreen.id,
              //                       arguments: ProductArguments(
              //                           projectsList[index].id,
              //                           projectData['userID']));
              //                 },
              //                 onUserName: () {
              //                   Navigator.pushNamed(
              //                       context, AnotherUsersProfile.id,
              //                       arguments: ProjectOwnerArguments(
              //                           projectData['userID']));
              //                 },

              //                 onProjectImage: () {},
              //                 onLike: () {},
              //                 onComment: () async {
              //                   await FirebaseAnalytics.instance.logEvent(
              //                     name: "Investor_Liked_post",
              //                     parameters: {
              //                       "projectID": projectsList[index].id,
              //                       "projectTite": projectData['projectName'],
              //                     },
              //                   );
              //                 },
              //                 projectId: projectsList[index].id,
              //                 ownerID: projectData['userID'],
              //               );

              //               // Text(
              //               //     "Project Name:  posted By: ${userData['fullName']}");
              //             });
              //       },
              //     );
              //   },
              // );
            }),
      ),
    );
  }
}
