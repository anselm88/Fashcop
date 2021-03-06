import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/screens/another_users_profile.dart';
import 'package:fashcop/screens/home_page.dart';
import 'package:fashcop/screens/single_project_screen.dart';
import 'package:fashcop/widgets/project_card.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class InvestorHomePage extends StatefulWidget {
  static const String id = 'home_page';

  const InvestorHomePage({Key? key}) : super(key: key);

  @override
  State<InvestorHomePage> createState() => _InvestorHomePageState();
}

class _InvestorHomePageState extends State<InvestorHomePage> {
  bool isFavorite = false;

  Stream<QuerySnapshot> projectRef = FirebaseFirestore.instance
      .collection('projectsMap')
      .orderBy("createdTime", descending: true)
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
      body: StreamBuilder<QuerySnapshot>(
        stream: projectRef,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }
          debugPrint(snapshot.data!.docs.length.toString());
          List<DocumentSnapshot> projectsList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: projectsList.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> projectData =
                  projectsList[index].data()! as Map<String, dynamic>;
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
                    Map<String, dynamic> userData =
                        userSnapshot.data!.data() as Map<String, dynamic>;

                    return ProjectCard(
                      userName: userData['fullName'],
                      projectLocation: projectData['projectLocation'],
                      userImagePath: userData['profileImage'] ?? "",
                      briefDescription: projectData['briefDescription'],
                      projectImagePath: projectData['projectImageURL'] ?? "",
                      //userEmail: 'johndoe@email.com',
                      projectName: projectData['projectName'],
                      numberOfLikes: 0,
                      numberOfComments: 0,
                      onFullProject: () {
                        Navigator.pushNamed(context, SingleProjectScreen.id,
                            arguments: ProductArguments(
                                projectsList[index].id, projectData['userID']));
                      },
                      onUserName: () {
                        Navigator.pushNamed(context, AnotherUsersProfile.id,
                            arguments:
                                ProjectOwnerArguments(projectData['userID']));
                      },

                      onProjectImage: () {},
                      onLike: () {},
                      onComment: () async {
                        await FirebaseAnalytics.instance.logEvent(
                          name: "Investor_Liked_post",
                          parameters: {
                            "projectID": projectsList[index].id,
                            "projectTite": projectData['projectName'],
                          },
                        );
                      },
                      projectId: projectsList[index].id,
                      ownerID: projectData['userID'],
                    );

                    // Text(
                    //     "Project Name:  posted By: ${userData['fullName']}");
                  });
            },
          );
        },
      ),
    );
  }
}
