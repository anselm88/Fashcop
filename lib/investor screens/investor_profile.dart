import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/screens/another_users_profile.dart';
import 'package:fashcop/screens/home_page.dart';
import 'package:fashcop/screens/single_project_screen.dart';
import 'package:fashcop/widgets/project_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InvestorProfileScreen extends StatefulWidget {
  @override
  State<InvestorProfileScreen> createState() => _InvestorProfileScreenState();
}

class _InvestorProfileScreenState extends State<InvestorProfileScreen> {
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

  Stream<QuerySnapshot<Map<String, dynamic>>> favoriteRef(String userID) =>
      FirebaseFirestore.instance
          .collection('favorites')
          .doc(userID)
          .collection('userFavorites')
          .snapshots();
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

            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: favoriteRef(auth.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  List<DocumentSnapshot> favoritesList = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: favoritesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, dynamic> favoriteData =
                          favoritesList[index].data()! as Map<String, dynamic>;

                      return ProjectCard(
                        userName: favoriteData['userName'],
                        projectLocation: favoriteData['projectLocation'],
                        userImagePath: favoriteData['userImage'] ?? "",
                        briefDescription: favoriteData['briefDescription'],
                        projectImagePath: favoriteData['projectImage'] ?? "",
                        //userEmail: 'johndoe@email.com',
                        projectName: favoriteData['projectName'],
                        numberOfLikes: 0,
                        numberOfComments: 0,
                        onFullProject: () {
                          Navigator.pushNamed(context, SingleProjectScreen.id,
                              arguments: ProductArguments(
                                  favoritesList[index].id,
                                  favoriteData['ownerId']));
                        },
                        onUserName: () {
                          Navigator.pushNamed(context, AnotherUsersProfile.id,
                              arguments: ProjectOwnerArguments(
                                  favoriteData['ownerId']));
                        },

                        onProjectImage: () {},
                        onLike: () {},
                        onComment: () {},
                        projectId: favoritesList[index].id,
                        ownerID: favoriteData['ownerId'],
                      );
                    },
                  );
                }),
            // FutureBuilder(
            //     future: projectRef(),
            //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if (snapshot.hasError) {
            //         return Text('Something went wrong');
            //       }

            //       if (snapshot.connectionState == ConnectionState.done) {
            //         // Map<String, dynamic> projectData =
            //         //     snapshot.data!.docs[].data() as Map<String, dynamic>;
            //         List<DocumentSnapshot> projectsList = snapshot.data!.docs;
            //         return ListView.builder(
            //             itemCount: projectsList.length,
            //             shrinkWrap: true,
            //             itemBuilder: (BuildContext context, int index) {
            //               Map<String, dynamic> projectData = projectsList[index]
            //                   .data() as Map<String, dynamic>;
            //               print(projectData['projectImageURL']);
            //               return ProjectCard(
            //                 userName: userName,
            //                 projectLocation: projectData['projectLocation'],
            //                 userImagePath: userImageUrl,
            //                 briefDescription: projectData['briefDescription'],
            //                 projectImagePath: projectData['projectImageURL'],
            //                 //userEmail: 'johndoe@email.com',
            //                 projectName: projectData['projectName'],
            //                 numberOfLikes: 0,
            //                 numberOfComments: 0,
            //                 onFullProject: () {},
            //                 onUserName: () {},
            //                 onProjectImage: () {},
            //                 onLike: () {},
            //                 onComment: () {}, projectId: null, ownerID: null,
            //               );
            //             });
            //       }

            //       //how to add box shadow

            //       return Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     })
          ],
        ),
      ),
    );
  }
}
