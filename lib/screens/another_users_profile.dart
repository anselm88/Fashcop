import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/screens/single_project_screen.dart';
import 'package:fashcop/widgets/custom_app_bar.dart';
import 'package:fashcop/widgets/project_card.dart';
import 'package:flutter/material.dart';

class AnotherUsersProfile extends StatefulWidget {
  static const String id = 'another_users_profile';

  AnotherUsersProfile({Key? key, required this.userId}) : super(key: key);

  final userId;

  @override
  State<AnotherUsersProfile> createState() => _AnotherUsersProfileState();
}

class _AnotherUsersProfileState extends State<AnotherUsersProfile> {
  DocumentReference userRef() =>
      FirebaseFirestore.instance.collection('users').doc(widget.userId);

  // final FirebaseFirestore fb = FirebaseFirestore.instance;

  // Future<QuerySnapshot<Map<String, dynamic>>> getProducts() {
  //   return fb
  //       .collection("projectMaps")
  //       .where('userID', isEqualTo: widget.userId)
  //       .get();
  // }

  // CollectionReference projectRef() => FirebaseFirestore.instance
  //     .collection('projectsMap').where('userID', isEqualTo: widget.userId).get();

  Query<Map<String, dynamic>> projectRef() => FirebaseFirestore.instance
      .collection('projectsMap')
      .where('userID', isEqualTo: widget.userId);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(color: Colors.grey[200]),
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
                  future: userRef().get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (userSnapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> userData =
                          userSnapshot.data?.data() as Map<String, dynamic>;

                      return Container(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 45,
                                    backgroundImage:
                                        NetworkImage(userData['profileImage']),
                                  ),
                                  SizedBox(width: 40),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
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
                          ),
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              SizedBox(height: 5),
              FutureBuilder(
                  future: projectRef().get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      // Map<String, dynamic> projectData =
                      //     snapshot.data! as Map<String, dynamic>;
                      // Text(snapshot.data!.docs.data()['userID'])
                      return ProjectCard(
                        userName: 'John Doe',
                        projectLocation: 'NorthWest, Bamenda',
                        userImagePath: '',
                        briefDescription: 'This project is all about....',
                        projectImagePath: '',
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
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
