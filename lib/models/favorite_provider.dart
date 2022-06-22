import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class FavoriteProvider with ChangeNotifier {
  void favorite(
      {required projectId,
      required projectImagePath,
      required projectName,
      required projectLocation,
      required briefDescription,
      required userImagePath,
      required userName,
      required projectFavorite}) {
    FirebaseFirestore.instance
        .collection('favorites')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('userFavorites')
        .doc(projectId)
        .set({
      "projectId": projectId,
      "projectImage": projectImagePath,
      "projectName": projectName,
      "projectLocation": projectLocation,
      "briefDescription": briefDescription,
      "userImage": userImagePath,
      "userName": userName,
      "projectFavorite": projectFavorite,
    });
  }
}
