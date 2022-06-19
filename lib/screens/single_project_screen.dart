import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashcop/variables/constants.dart';
import 'package:fashcop/widgets/project_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleProjectScreen extends StatefulWidget {
  static const String id = 'single_project_screen';
  SingleProjectScreen({Key? key, required this.productId, required this.userId})
      : super(key: key);

  final productId;
  final userId;
  @override
  State<SingleProjectScreen> createState() => _SingleProjectScreenState();
}

class _SingleProjectScreenState extends State<SingleProjectScreen> {
  DocumentReference projectRef() => FirebaseFirestore.instance
      .collection('projectsMap')
      .doc(widget.productId);

  DocumentReference userRef() =>
      FirebaseFirestore.instance.collection('users').doc(widget.userId);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    print(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
          shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(30),
              //     bottomRight: Radius.circular(30)),
              ),
          brightness: Brightness.light,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              //borderRadius: const BorderRadius.only(
              //bottomLeft: Radius.circular(30),
              //bottomRight: Radius.circular(30)),
              gradient: LinearGradient(
                colors: [
                  Colors.white30,
                  Colors.white,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: const Text(
            "FaSHcoP",
            style: kHeadingStyle,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: FutureBuilder<DocumentSnapshot>(
            future: projectRef().get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> projectData =
                    snapshot.data?.data() as Map<String, dynamic>;
                return FutureBuilder<DocumentSnapshot>(
                    future: userRef().get(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (userSnapshot.connectionState ==
                          ConnectionState.done) {
                        Map<String, dynamic> userData =
                            userSnapshot.data?.data() as Map<String, dynamic>;

                        return Container(
                          decoration: BoxDecoration(color: Colors.grey[200]),
                          child: Column(
                            children: [
                              Container(
                                  child: Card(
                                margin: const EdgeInsets.only(
                                    left: 0.0,
                                    right: 0.0,
                                    top: 2.5,
                                    bottom: 2.5),
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: ListTile(
                                          leading: CircleAvatar(
                                            radius: 20.0,
                                            backgroundImage: NetworkImage(
                                                userData['profileImage']),
                                          ),
                                          title: Text(
                                            userData['fullName'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                              projectData['projectLocation']),
                                          trailing: Icon(Icons.more_horiz),
                                          contentPadding: EdgeInsets.all(0),
                                          onTap: () {},
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          height: 300,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(projectData[
                                                  'projectImageURL']),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(height: 10),
                                              Text(
                                                "Project Name: ${projectData['projectName']}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Location: ${projectData['projectLocation']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Budget Rnage: ${projectData['budgetRange']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Estimated Profits: ${projectData['estimatedProfits']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Sector: ${projectData['agroSector']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Time Frame: ${projectData['timeFrame']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'Project Description: ${projectData['detailedDescription']}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ]),
                                      ),
                                      const Divider(
                                        color: Colors.black54,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Text(
                                                '0 Likes',
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
                                                onPressed: () {},
                                                icon: const Icon(
                                                    Icons.comment_outlined,
                                                    color: Colors.black54),
                                              ),
                                              Text(
                                                '0 Comments',
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black54),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Text('1 hour ago',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black54,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                            ],
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    });
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}
