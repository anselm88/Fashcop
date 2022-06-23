import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/screens/another_users_profile.dart';
import 'package:fashcop/screens/home_page.dart';
import 'package:fashcop/screens/single_project_screen.dart';
import 'package:fashcop/widgets/project_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> favoriteRef(String userID) =>
      FirebaseFirestore.instance
          .collection('favorites')
          .doc(userID)
          .collection('userFavorites')
          .snapshots();
  // .where('userID', isEqualTo: userID)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                            favoritesList[index].id, favoriteData['userID']));
                  },
                  onUserName: () {
                    Navigator.pushNamed(context, AnotherUsersProfile.id,
                        arguments:
                            ProjectOwnerArguments(favoriteData['userID']));
                  },

                  onProjectImage: () {},
                  onLike: () {},
                  onComment: () {},
                  projectId: favoritesList[index].id,
                  ownerID: favoriteData['userID'],
                );
              },
            );
          }),
    );
  }
}
