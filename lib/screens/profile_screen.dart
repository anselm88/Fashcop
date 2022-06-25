import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/screens/single_project_screen.dart';
import 'package:fashcop/widgets/project_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  String getCurrentUser() {
    final User user = auth.currentUser!;
    final uid = user.uid;
    return uid;
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getCurrentUser();
  //   print(getCurrentUser());
  // }

  DocumentReference userRef(String userID) =>
      FirebaseFirestore.instance.collection('users').doc(userID);

  Future<QuerySnapshot<Map<String, dynamic>>> projectRef() =>
      FirebaseFirestore.instance
          .collection('projectsMap')
          .where('userID', isEqualTo: getCurrentUser())
          .get();

  String? userName;
  String? userImageUrl;

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
                child: FutureBuilder<DocumentSnapshot>(
                  future: userRef(getCurrentUser()).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> userData =
                          snapshot.data?.data() as Map<String, dynamic>;
                      userName = userData['fullName'];
                      userImageUrl = userData['profileImage'];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              userData['profileImage'] == null
                                  ? const CircleAvatar(
                                      radius: 45.0,
                                      backgroundImage:
                                          AssetImage("assets/profile1.png"),
                                    )
                                  : CircleAvatar(
                                      radius: 45,
                                      backgroundImage: NetworkImage(
                                          userData['profileImage']),
                                    ),
                              SizedBox(width: 40),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData['userName'],
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30),
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
                          Text(userData['fullName'],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(userData['location'],
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold)),
                          Text(userData['email'],
                              style: TextStyle(
                                fontSize: 20,
                              )),
                          Text(userData['phoneNumber'],
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ],
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 5),
            FutureBuilder(
                future: projectRef(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    // Map<String, dynamic> projectData =
                    //     snapshot.data!.docs[].data() as Map<String, dynamic>;
                    List<DocumentSnapshot> projectsList = snapshot.data!.docs;
                    return ListView.builder(
                        itemCount: projectsList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> projectData = projectsList[index]
                              .data() as Map<String, dynamic>;
                          print(projectData['projectImageURL']);
                          return ProjectCard(
                            userName: userName,
                            projectLocation: projectData['projectLocation'],
                            userImagePath: userImageUrl,
                            briefDescription: projectData['briefDescription'],
                            projectImagePath: projectData['projectImageURL'],
                            //userEmail: 'johndoe@email.com',
                            projectName: projectData['projectName'],
                            numberOfLikes: 0,
                            numberOfComments: 0,
                            onFullProject: () {},
                            onUserName: () {},
                            onProjectImage: () {},
                            onLike: () {},
                            onComment: () {}, projectId: null, ownerID: null,
                          );
                        });
                  }

                  //how to add box shadow

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                })
          ],
        ),
      ),
    );
  }
}
